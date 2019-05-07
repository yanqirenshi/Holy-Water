riot.tag2('angel_page', '<section class="section"> <div class="container"> <h1 class="title hw-text-white">祓魔師</h1> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">パスワード変更</h1> <h2 class="subtitle hw-text-white">準備中</h2> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">サインアウト</h1> <h2 class="subtitle hw-text-white"></h2> <div class="contents"> <button class="button is-danger hw-box-shadow" style="margin-left:22px; margin-top:11px;" onclick="{clickSignOut}">Sign Out</button> </div> </div> </section> </div> </section>', '', '', function(opts) {
     this.clickSignOut = () => {
         ACTIONS.signOut();
     };
});

riot.tag2('app-page-area', '', '', '', function(opts) {
     this.draw = () => {
         if (this.opts.route)
             ROUTER.draw(this, STORE.get('site.pages'), this.opts.route);
     }
     this.on('mount', () => {
         this.draw();
     });
     this.on('update', () => {
         this.draw();
     });
});

riot.tag2('app', '<div class="kasumi"></div> <menu-bar brand="{{label:\'RT\'}}" site="{site()}" moves="{[]}"></menu-bar> <app-page-area></app-page-area> <p class="image-ref" style="">背景画像: <a href="http://joxaren.com/?p=853">旅人の夢</a></p> <message-area></message-area> <home_working-action data="{impure()}"></home_working-action>', '', '', function(opts) {
     this.site = () => {
         return STORE.state().get('site');
     };
     this.impure = () => {
         return STORE.get('purging.impure');
     }
     this.updateMenuBar = () => {
         if (this.tags['menu-bar'])
             this.tags['menu-bar'].update();
     }

     STORE.subscribe((action)=>{
         if (action.type=='MOVE-PAGE') {
             this.updateMenuBar();

             this.tags['app-page-area'].update({ opts: { route: action.route }});
         }

         if (action.type=='FETCHED-IMPURE-PURGING')
             this.tags['home_working-action'].update();
     })

     window.addEventListener('resize', (event) => {
         this.update();
     });

     this.on('mount', () => {
         let hash = location.hash.split('/');
         hash[0] = hash[0].substring(1)

         ACTIONS.movePage({ route: hash });
     });
});

riot.tag2('cemetery-list', '<table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth"> <thead> <tr> <th colspan="3">Impure</th> <th colspan="2">Purge</th> <th rowspan="2">備考</th> </tr> <tr> <th>ID</th> <th style="width:333px;">名称</th> <th>完了</th> <th>開始</th> <th>終了</th> </tr> </thead> <tbody> <tr each="{impure in opts.data}"> <td nowrap>{impure.id}</td> <td style="width:333px;" nowrap>{impure.name}</td> <td nowrap>{dt(impure.finished_at)}</td> <td nowrap>{dt(impure.start)}</td> <td nowrap>{dt(impure.end)}</td> <td style="word-break: break-word;">{description(impure.description)}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.dt = (v) => {
         if (!v) return '---'

         return moment(v).format('MM-DD HH:mm:ss')
     };

     this.description = (str) => {
         if (str.length<=222)
             return str;

         return str.substring(0, 222) + '........';
     };
});

riot.tag2('cemetery_page', '<section class="section"> <div class="container"> <h2 class="subtitle" style="text-shadow: 0px 0px 11px #fff;"></h2> <div> <cemetery_page_filter style="margin-bottom:22px;" from="{from}" to="{to}" callback="{callback}"></cemetery_page_filter> </div> <div style="padding-bottom:22px;"> <cemetery-list data="{impures()}"></cemetery-list> </div> </div> </section>', 'cemetery_page { height: 100%; display: block; overflow: scroll; }', '', function(opts) {
     this.from = moment().add(-1, 'd').startOf('day');
     this.to   = moment().add(1, 'd').startOf('day');
     this.moveDate = (unit, amount) => {
         this.from = this.from.add(amount, unit);
         this.to   = this.to.add(amount, unit);

         this.tags['cemetery_page_filter'].update();
     };

     this.callback = (action, data) => {
         if ('move-date'==action) {
             this.moveDate(data.unit, data.amount);
             return;
         }
         if ('refresh'==action) {
             ACTIONS.fetchDoneImpures(this.from, this.to);
             return;
         }
     };

     this.impures = () => {
         return STORE.get('impures_done').list.sort((a, b) => {
             return a.id*1 < b.id*1 ? 1 : -1;
         });
     };

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-DONE-IMPURES')
             this.update();
     });

     this.on('mount', () => {
         ACTIONS.fetchDoneImpures(this.from, this.to);
     });
});

riot.tag2('cemetery_page_filter', '<span class="hw-text-white" style="font-size:24px; font-weight:bold;">期間：</Span> <input class="input" type="text" placeholder="From" riot-value="{date2str(opts.from)}" readonly> <span style="font-size:24px;"> 〜 </span> <input class="input" type="text" placeholder="To" riot-value="{date2str(opts.to)}" readonly> <div class="operators"> <move-date-operator label="日" unit="d" callback="{callback}"></move-date-operator> <move-date-operator label="週" unit="w" callback="{callback}"></move-date-operator> <move-date-operator label="月" unit="M" callback="{callback}"></move-date-operator> <button class="button refresh hw-box-shadow" style="margin-top:1px; margin-left:11px;" onclick="{clickRefresh}">Refresh</button> </div>', 'cemetery_page_filter, cemetery_page_filter .operators { display: flex; } cemetery_page_filter .input { width: 111px; border: none; }', '', function(opts) {
     this.date2str = (date) => {
         if (!date) return '';
         return date.format('YYYY-MM-DD');
     };

     this.clickRefresh = () => {
         this.opts.callback('refresh');
     };

     this.callback = (action, data) => {
         this.opts.callback('move-date', {
             unit: data.unit,
             amount: data.amount,
         })
     };
});

riot.tag2('menu-bar', '<aside class="menu"> <p ref="brand" class="menu-label" onclick="{clickBrand}"> {opts.brand.label} </p> <ul class="menu-list"> <li each="{opts.site.pages}"> <a class="{opts.site.active_page==code ? \'is-active\' : \'\'}" href="{\'#\' + code}"> {menu_label} </a> </li> </ul> </aside> <div class="move-page-menu hide" ref="move-panel"> <p each="{moves()}"> <a href="{href}">{label}</a> </p> </div>', 'menu-bar .move-page-menu { z-index: 666665; background: #ffffff; position: fixed; left: 55px; top: 0px; min-width: 111px; height: 100vh; box-shadow: 2px 0px 8px 0px #e0e0e0; padding: 22px 55px 22px 22px; } menu-bar .move-page-menu.hide { display: none; } menu-bar .move-page-menu > p { margin-bottom: 11px; } menu-bar > .menu { z-index: 666666; height: 100vh; width: 55px; padding: 11px 0px 11px 11px; position: fixed; left: 0px; top: 0px; background: #e198b4; } menu-bar .menu-label, menu-bar .menu-list a { padding: 0; width: 33px; height: 33px; text-align: center; margin-top: 8px; border-radius: 3px; background: none; color: #ffffff; font-weight: bold; padding-top: 7px; font-size: 14px; } menu-bar .menu-label,[data-is="menu-bar"] .menu-label{ background: #ffffff; color: #e198b4; } menu-bar .menu-label.open,[data-is="menu-bar"] .menu-label.open{ background: #ffffff; color: #e198b4; width: 44px; border-radius: 3px 0px 0px 3px; text-shadow: 0px 0px 1px #eee; padding-right: 11px; } menu-bar .menu-list a.is-active { border-radius: 3px; background: #ffffff; color: #333333; }', '', function(opts) {
     this.moves = () => {
         let moves = [
             {
                 code: 'link-a',
                 href: 'https://ja.wikipedia.org/wiki/Getting_Things_Done',
                 label: 'Getting Things Done - ウィキペディア'
             },
             {
                 code: 'link-b',
                 href: 'https://postd.cc/gtd-in-15-minutes/',
                 label: '15分で分かるGTD – 仕事を成し遂げる技術の実用的ガイド | POSTD'
             },
             {
                 code: 'link-c',
                 href: 'http://gtd-japan.jp/about',
                 label: 'GTD®とは - 日本唯一のGTD公式サイト。GTD Japan'
             },
             {
                 code: 'link-d',
                 href: 'https://teamhackers.io/work-efficiency-rises-three-times',
                 label: '作業効率が3倍上がる、質を落とさず早く仕上げるタスク管理・時短編'
             },
         ]
         return moves.filter((d)=>{
             return d.code != this.opts.current;
         });
     };

     this.brandStatus = (status) => {
         let brand = this.refs['brand'];
         let classes = brand.getAttribute('class').trim().split(' ');

         if (status=='open') {
             if (classes.find((d)=>{ return d!='open'; }))
                 classes.push('open')
         } else {
             if (classes.find((d)=>{ return d=='open'; }))
                 classes = classes.filter((d)=>{ return d!='open'; });
         }
         brand.setAttribute('class', classes.join(' '));
     }

     this.clickBrand = () => {
         let panel = this.refs['move-panel'];
         let classes = panel.getAttribute('class').trim().split(' ');

         if (classes.find((d)=>{ return d=='hide'; })) {
             classes = classes.filter((d)=>{ return d!='hide'; });
             this.brandStatus('open');
         } else {
             classes.push('hide');
             this.brandStatus('close');
         }
         panel.setAttribute('class', classes.join(' '));
     };
});

riot.tag2('message-area', '<message-item each="{msg in messages()}" data="{msg}" callback="{callback}"></message-item>', 'message-area { position: fixed; right: 22px; top: 22px; z-index: 666666; } message-area > message-item { margin-bottom: 11px; } message-area > message-item:last-child { margin-bottom: 0px; }', '', function(opts) {
     this.callback = (action, data) => {
         if ('close-message'==action)
             ACTIONS.closeMessage(data);
     };
     STORE.subscribe((action) => {
         if ('CLOSED-MESSAGE'==action.type)
             this.update();
         if ('PUSHED-MESSAGE'==action.type)
             this.update();
     });

     this.messages = () => {
         return STORE.get('messages');
     };
});

riot.tag2('message-item', '<article class="message hw-box-shadow is-{opts.data.type}"> <div class="message-header"> <p>{opts.data.title}</p> <button class="delete" aria-label="delete" onclick="{clickCloseButton}"></button> </div> <div class="message-body" style="padding: 11px 22px;"> <div class="contents" style="overflow: auto;"> <p each="{txt in contents()}">{txt}</p> </div> </div> </article>', 'message-item > .message{ min-height: calc(46px + 44px); min-width: 111px; max-height: 222px; max-width: 333px; } message-item { display: block; }', '', function(opts) {
     this.contents = () => {
         if (!opts.data || !opts.data.contents)
             return [];

         return opts.data.contents.split('\n');
     };
     this.clickCloseButton = () => {
         this.opts.callback('close-message', this.opts.data);
     };
});

riot.tag2('page-tabs', '<div class="tabs is-{type()}"> <ul> <li each="{opts.core.tabs}" class="{opts.core.active_tab==code ? \'is-active\' : \'\'}"> <a code="{code}" onclick="{clickTab}">{label}</a> </li> </ul> </div>', 'page-tabs li:first-child { margin-left: 22px; }', '', function(opts) {
     this.clickTab = (e) => {
         let code = e.target.getAttribute('code');
         this.opts.callback(e, 'CLICK-TAB', { code: code });
     };
     this.type = () => {
         return this.opts.type ? this.opts.type : 'boxed';
     };
});

riot.tag2('section-breadcrumb', '<nav class="breadcrumb" aria-label="breadcrumbs"> <ul> <li each="{path()}" class="{active ? \'is-active\' : \'\'}"> <a href="{href}" aria-current="page">{label}</a> </li> </ul> </nav>', 'section-breadcrumb section-container > .section,[data-is="section-breadcrumb"] section-container > .section{ padding-top: 3px; }', '', function(opts) {
     this.label = (node, is_last, node_name) => {
         if (node.menu_label)
             return node.menu_label;

         if (node.regex)
             return node_name;

         return is_last ? node_name : node.code;
     };
     this.active = (node, is_last) => {
         if (is_last)
             return true;

         if (!node.tag)
             return true;

         return false;
     };
     this.makeData = (routes, href, path) => {
         if (!path || path.length==0)
             return null;

         let node_name = path[0];
         let node = routes.find((d) => {
             if (d.regex) {
                 return d.regex.exec(node_name);
             } else {
                 return d.code == node_name;
             }
         });

         if (!node) {
             console.warn(routes);
             console.warn(path);
             throw new Error ('なんじゃこりゃぁ!!')
         }

         let sep = href=='#' ? '' : '/';
         let node_label = node.regex ? node_name : node.code;
         let new_href = href + sep + node_label;

         let is_last = path.length == 1;

         let crumb = [{
             label: this.label(node, is_last, node_name),
             href: new_href,
             active: this.active(node, is_last),
         }]

         if (is_last==1)
             return crumb;

         return crumb.concat(this.makeData(node.children, new_href, path.slice(1)))
     };
     this.path = () => {
         let hash = location.hash;
         let path = hash.split('/');

         let routes = STORE.get('site.pages');

         if (path[0] && path[0].substr(0,1)=='#')
             path[0] = path[0].substr(1);

         return this.makeData(routes, '#', path);
     }
});

riot.tag2('section-container', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 3}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <yield></yield> </div> </section>', '', '', function(opts) {
});

riot.tag2('section-contents', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 3}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <div class="contents"> <yield></yield> </div> </div> </section>', 'section-contents > section.section { padding: 0.0rem 1.5rem 2.0rem 1.5rem; }', '', function(opts) {
});

riot.tag2('section-footer', '<footer class="footer"> <div class="container"> <div class="content has-text-centered"> <p> </p> </div> </div> </footer>', 'section-footer > .footer { background: #ffffff; padding-top: 13px; padding-bottom: 13px; }', '', function(opts) {
});

riot.tag2('section-header-with-breadcrumb', '<section-header title="{opts.title}"></section-header> <section-breadcrumb></section-breadcrumb>', 'section-header-with-breadcrumb section-header > .section,[data-is="section-header-with-breadcrumb"] section-header > .section{ margin-bottom: 3px; }', '', function(opts) {
});

riot.tag2('section-header', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 3}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <yield></yield> </div> </section>', 'section-header > .section { background: #ffffff; }', '', function(opts) {
});

riot.tag2('section-list', '<table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th>機能</th> <th>概要</th> </tr> </thead> <tbody> <tr each="{data()}"> <td><a href="{hash}">{title}</a></td> <td>{description}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.data = () => {
         return opts.data.filter((d) => {
             if (d.code=='root') return false;

             let len = d.code.length;
             let suffix = d.code.substr(len-5);
             if (suffix=='_root' || suffix=='-root')
                 return false;

             return true;
         });
     };
});

riot.tag2('home_working-action', '<button class="button is-small" style="margin-right:11px;" onclick="{clickStop}">Stop</button> <span>{name()}</span> <div style="margin-top: 8px;"> <p style="display:inline; font-size:12px; margin-right:22px;"> <span style="width:88px;display:inline-block;">経過: {distance()}</span> <span>開始: </span> <span>{start()}</span> </p> <button class="button is-small" onclick="{clickStopAndClose}">Stop & Close</button> </div>', 'home_working-action { display: block; position: fixed; bottom: 33px; right: 33px; background: #fff; padding: 11px 22px; border-radius: 8px; }', 'class="hw-box-shadow {hide()}" style="box-shadow:0px 0px 22px rgba(254, 242, 99, 0.666)"', function(opts) {

     this.clickStop = () => {
         let impure = this.opts.data;
         if (impure)
             ACTIONS.stopImpure(impure);
     }
     this.clickStopAndClose = () => {
         let impure = this.opts.data;
         if (impure)
             ACTIONS.finishImpure(impure, true);
     };

     this.hide = () => {
         return opts.data ? '' : 'hide';
     }
     this.name = () => {
         return opts.data ? opts.data.name : '';
     };
     this.distance = () => {
         if (!opts.data || !opts.data.purge || !opts.data.purge.start)
             return '??:??:??'

         let start = opts.data.purge.start;
         let sec_tmp   = moment().diff(start, 'second');

         let sec = sec_tmp % 60;
         sec_tmp -= sec;
         let min_tmp = sec_tmp / 60;
         let min = min_tmp % 60;
         min_tmp -= min;
         let hour = min_tmp / 60;

         let fmt = (v) => {
             return v<10 ? '0'+v : v;
         }

         return fmt(hour) + ':' + fmt(min) + ':' + fmt(sec) + ', ';
     }
     this.start = () => {
         if (!opts.data || !opts.data.purge || !opts.data.purge.start)
             return '????-??-?? ??:??:??';

         let start = opts.data.purge.start;

         return moment(start).format('YYYY-MM-DD HH:mm:ss');
     };
});

riot.tag2('sections-list', '<table class="table"> <tbody> <tr each="{opts.data}"> <td><a href="{hash}">{name}</a></td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('deamons_page', '<section class="section"> <div class="container"> <h1 class="title hw-text-white">Deamons</h1> <h2 class="subtitle hw-text-white">実績を集計するためのグループ</h2> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">List</h1> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow"> <thead> <tr> <th>ID</th> <th>Name</th> <th>Name(Short)</th> </tr> </thead> <tbody> <tr each="{deamon in deamons()}"> <td>{deamon.id}</td> <td>{deamon.name}</td> <td>{deamon.name_short}</td> </tr> </tbody> </table> </div> </div> </section> </div> </section>', '', '', function(opts) {
     this.deamons = () => {
         return STORE.get('deamons.list');
     };
     this.on('mount', () => {
         ACTIONS.fetchDeamons();
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-DEAMONS')
             this.update();
     });
});

riot.tag2('help_page', '<section class="section"> <div class="container"> <h1 class="title hw-text-white">聖書</h1> <h2 class="subtitle hw-text-white">ヘルプ的ななにか</h2> <div class="contents hw-text-white"> <p>準備中</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_impure', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('home_impure_root', '', '', '', function(opts) {
});

riot.tag2('home_close-impure-area', '<div> <p>Close Impure. Drag & Drop here</p> </div>', 'home_close-impure-area > div{ background: #fefefe; padding: 5px; border-radius: 5px; } home_close-impure-area > div > p{ border: 1px dashed #f0f0f0; border-radius: 5px; padding: 5px 11px; background: #fcfcfc; }', '', function(opts) {
});

riot.tag2('home_emergency-door', '<span class="move-door {dragging ? \'open\' : \'close\'}" ref="move-door" dragover="{dragover}" drop="{drop}"> <span class="icon closed-door"> <i class="fas fa-door-closed"></i> </span> <span class="icon opened-door" angel-id="{opts.source.id}"> <i class="fas fa-door-open" angel-id="{opts.source.id}"></i> </span> </span>', 'home_emergency-door .move-door { font-size: 14px; } home_emergency-door .move-door.close .opened-door{ display: none; } home_emergency-door .move-door.open .closed-door{ display: none; } home_emergency-door { width: 24px; } home_emergency-door .icon { color: #cccccc; } home_emergency-door .icon:hover { color: #880000; } home_emergency-door .move-door.open .icon { color: #880000; }', '', function(opts) {
     this.dragging = false;
     this.dragover = (e) => {
         e.preventDefault();
     };
     this.drop = (e) => {
         let impure = JSON.parse(e.dataTransfer.getData('impure'));
         let angel  = this.opts.source;

         ACTIONS.startTransferImpureToAngel(impure, angel);

         e.preventDefault();
     };

     STORE.subscribe((action) => {
         if (action.type=='START-DRAG-IMPURE-ICON') {
             this.dragging = true;
             this.update();
         }
         if (action.type=='END-DRAG-IMPURE-ICON') {
             this.dragging = false;
             this.update();
         }
     });
});

riot.tag2('home_impures', '<div class="flex-parent" style="height:100%; margin-top: -8px;"> <div class="card-container"> <div style="overflow: hidden; padding-bottom: 222px; padding-top: 22px;"> <impure-card each="{impure in impures()}" data="{impure}" open="{open_cards[impure.id]}" callbacks="{callbacks}"></impure-card> </div> </div> </div>', 'home_impures .flex-parent { display: flex; flex-direction: column; } home_impures .card-container { padding-right: 22px; display: block; overflow: auto; overflow-x: hidden; flex-grow: 1; }', 'class="{hide()}"', function(opts) {
     this.open_cards = {};
     this.callbacks = {
         switchSize: (size, data) => {
             if (size=='small')
                 delete this.open_cards[data.id]
             else if (size=='large')
                 this.open_cards[data.id] = true;

             this.update();
         }
     };

     this.hide = () => {
         return this.opts.maledict ? '' : 'hide';
     };
     this.impures = () => {
         let out = STORE.get('impures').list.sort((a, b) => {
             return a.id > b.id ? 1 : -1;
         });

         let filter = this.opts.filter;
         if (this.opts.filter===null)
             return out;

         return out.filter((d) => {
             return d.name.toLowerCase().indexOf(filter.toLowerCase()) >= 0;
         });
     };

     STORE.subscribe((action) => {
         let update_only = [
             'FETCHED-MALEDICT-IMPURES',
         ]

         if (update_only.indexOf(action.type)>=0) {
             this.update();
         }

         if (action.type=='CREATED-MALEDICT-IMPURES')
             if (this.opts.maledict.id == action.maledict.id)
                 ACTIONS.fetchMaledictImpures(this.opts.maledict.id);

         if (action.type=='MOVED-IMPURE' ||
             action.type=='FINISHED-IMPURE' ||
             action.type=='TRANSFERD-IMPURE-TO-ANGEL' ||
             action.type=='STARTED-ACTION' ||
             action.type=='STOPED-ACTION' ||
             action.type=='SAVED-IMPURE') {

             ACTIONS.fetchMaledictImpures(this.opts.maledict.id);
         }
     });
});

riot.tag2('home_maledicts', '<nav class="panel hw-box-shadow"> <p class="panel-heading">Maledicts</p> <a each="{data()}" class="panel-block {isActive(id)}" onclick="{clickItem}" maledict-id="{id}" style="padding: 5px 8px;"> <span style="width:120px; font-size:11px;" maledict-id="{id}"> {name} </span> <span class="operators" style="font-size:14px;"> <span class="icon" title="ここに「やること」を追加する。" maledict-id="{id}" maledict-name="{name}" onclick="{clickAddButton}"> <i class="far fa-plus-square" maledict-id="{id}"></i> </span> <span class="move-door {dragging ? \'open\' : \'close\'}" ref="move-door" dragover="{dragover}" drop="{drop}"> <span class="icon closed-door"> <i class="fas fa-door-closed"></i> </span> <span class="icon opened-door" maledict-id="{id}"> <i class="fas fa-door-open" maledict-id="{id}"></i> </span> </span> </span> </a> </nav>', 'home_maledicts > .panel { width: 188px; border-radius: 4px 4px 0 0; } home_maledicts > .panel > .panel-heading{ font-size:12px; font-weight:bold; } home_maledicts .panel-block { background:#fff; } home_maledicts .panel-block.is-active { background:#eaf4fc; } home_maledicts .move-door.close .opened-door { display: none; } home_maledicts .move-door.open .closed-door { display: none; } home_maledicts .operators { width: 53px; } home_maledicts .operators .icon { color: #cccccc; } home_maledicts .operators .icon:hover { color: #880000; } home_maledicts .operators .move-door.open .icon { color: #880000; }', '', function(opts) {
     this.dragging = false;

     this.dragover = (e) => {
         e.preventDefault();
     };
     this.drop = (e) => {
         let impure = JSON.parse(e.dataTransfer.getData('impure'));
         let maledict = this.opts.data.ht[e.target.getAttribute('maledict-id')];

         ACTIONS.moveImpure(maledict, impure);

         e.preventDefault();
     };

     this.clickItem = (e) => {
         let target = e.target;
         let maledict = this.opts.data.ht[target.getAttribute('maledict-id')];

         ACTIONS.selectedHomeMaledict(maledict);
     };
     this.clickAddButton = (e) => {
         let target = e.target;
         let maledict = this.opts.data.ht[target.getAttribute('maledict-id')];

         this.opts.callback('open-modal-create-impure', maledict);

         e.stopPropagation();
     };
     this.on('mount', () => {
         let maledicts = this.data()
                             .sort((a,b) => {
                                 return a.ORDER < b.ORDER;
                             });

         ACTIONS.selectedHomeMaledict(maledicts[0]);
     });

     this.data = () => {
         if (!this.opts.data) return [];

         return this.opts.data.list.filter((d)=>{
             return d['maledict-type']['ORDER']!=999;
         });
     };

     this.active_maledict = null;
     this.isActive = (id) => {
         if (!opts.select) return;

         return id==opts.select.id ? 'is-active' : ''
     }
     STORE.subscribe((action) => {
         if (action.type=='START-DRAG-IMPURE-ICON') {
             this.dragging = true;
             this.update();
         }
         if (action.type=='END-DRAG-IMPURE-ICON') {
             this.dragging = false;
             this.update();
         }
     });
});

riot.tag2('home_modal-create-impure', '<div class="modal {opts.open ? \'is-active\' : \'\'}"> <div class="modal-background"></div> <div class="modal-card"> <header class="modal-card-head"> <p class="modal-card-title">やる事を追加</p> <button class="delete" aria-label="close" onclick="{clickCloseButton}"></button> </header> <section class="modal-card-body"> <h4 class="title is-6">場所: {maledictName()}</h4> <div> <span>接頭文字:</span> <button each="{prefixes}" class="button is-small" style="margin-left: 8px;" onclick="{clickTitlePrefix}" riot-value="{label}">{label}</button> </div> <input class="input" type="text" placeholder="Title" ref="name" style="margin-top:11px;"> <textarea class="textarea" placeholder="Description" rows="6" style="margin-top:11px;" ref="description"></textarea> </section> <footer class="modal-card-foot"> <button class="button" onclick="{clickCloseButton}">Cancel</button> <button class="button is-success" onclick="{clickCreateButton}">Create!</button> </footer> </div> </div>', '', '', function(opts) {
     this.prefixes = [
         { label: 'RBP：' },
         { label: 'RBR：' },
         { label: 'GLPGSH：' },
         { label: 'HW：' },
         { label: 'WBS：' },
         { label: 'TER：' },
         { label: '人事：' },
         { label: 'Ill：' },
     ];
     this.clickTitlePrefix = (e) => {
         let prefix = e.target.getAttribute('value');

         let elem = this.refs.name
         let name = elem.value;

         let pos = name.indexOf('：');
         if (pos==-1) {
             elem.value = prefix + name;
             return;
         }

         for (let item of this.prefixes) {
             let l = item.label;
             let label_length = l.length;

             if (label_length > name.length)
                 continue;

             if (name.substring(0, label_length)==l) {
                 elem.value = prefix + name.substring(label_length);
                 return;
             }
         }

         elem.value = prefix + name;
     };

     this.maledictName = () => {
         return this.opts.maledict ? this.opts.maledict.name : '';
     }

     this.clickCreateButton = (e) => {
         this.opts.callback('create-impure', {
             name: this.refs['name'].value,
             description: this.refs['description'].value,
             maledict: this.opts.maledict
         });
     };
     this.clickCloseButton = (e) => {
         this.opts.callback('close-modal-create-impure');
     };
});

riot.tag2('home_page', '<div class="bucket-area"> <home_maledicts data="{STORE.get(\'maledicts\')}" select="{maledict()}" callback="{callback}" dragging="{dragging}"></home_maledicts> <home_orthodox-angels></home_orthodox-angels> <home_other-services></home_other-services> </div> <div class="contetns-area"> <div style="display:flex;"> <home_squeeze-area callback="{callback}"></home_squeeze-area> <home_requtest-area></home_requtest-area> </div> <home_impures maledict="{maledict()}" callback="{callback}" filter="{squeeze_word}"></home_impures> <home_servie-items></home_servie-items> </div> <home_modal-create-impure open="{modal_open}" callback="{callback}" maledict="{modal_maledict}"></home_modal-create-impure> <modal_request-impure source="{request_impure}"></modal_request-impure>', 'home_page { height: 100%; width: 100%; padding: 22px 0px 0px 22px; display: flex; } home_page > .contetns-area { height: 100%; margin-left: 11px; flex-grow: 1; } home_page home_squeeze-area { margin-right: 55px; }', '', function(opts) {
     this.modal_open     = false;
     this.modal_maledict = null;
     this.maledict       = null;
     this.squeeze_word   = null;
     this.request_impure = null;

     this.impure = () => {
         return STORE.get('purging.impure');
     }
     this.maledict = () => {
         return STORE.get('selected.home.maledict');
     };

     this.callback = (action, data) => {
         if ('open-modal-create-impure'==action)
             this.openModal(data);

         if ('close-modal-create-impure'==action)
             this.closeModal();

         if ('create-impure'==action)
             ACTIONS.createMaledictImpures(data.maledict, {
                 name: data.name,
                 description: data.description,
             });

         if ('squeeze-impure'==action) {
             this.squeeze_word = (data.trim().length==0 ? null : data);
             this.tags['home_impures'].update();
         }
     };

     STORE.subscribe((action) => {
         if (action.type=='SELECTED-HOME-MALEDICT') {

             this.update();

             let maledict = this.maledict();
             ACTIONS.fetchMaledictImpures(maledict.id);
         }

         if (action.type=='FETCHED-MALEDICTS')
             this.update();

         if (action.type=='CREATED-MALEDICT-IMPURES')
             this.closeModal();

         if (action.type=='START-TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = action.contents;
             this.tags['modal_request-impure'].update();
         }

         if (action.type=='STOP-TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = null;
             this.tags['modal_request-impure'].update();
         }

         if (action.type=='TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = null;
             this.tags['modal_request-impure'].update();
         }

         if (action.type=='SELECT-SERVICE-ITEM') {
             this.tags['home_maledicts'].update();
             this.tags['home_impures'].update();

             let service = action.data.selected.home.service;
             ACTIONS.fetchServiceItems(service.service, service.id);
         }
     });

     this.on('mount', () => {
         ACTIONS.fetchMaledicts();
         ACTIONS.fetchAngels();
     });

     this.openModal = (maledict) => {
         this.modal_open = true;
         this.modal_maledict = maledict;

         this.tags['home_modal-create-impure'].update();
     };
     this.closeModal = () => {
         this.modal_open = false;
         this.tags['home_modal-create-impure'].update();
     };
});

riot.tag2('home_requtest-area', '<p class="{isHide()}"> 依頼メッセージ未読: <a href="#home/requests"><span class="count">{count()}</span></a> 件 </p>', 'home_requtest-area > p { color: #fff; font-weight: bold; font-size: 14px; line-height: 38px; } home_requtest-area .count { color: #f00; font-size: 21px; }', '', function(opts) {
     this.isHide = () => {
         return this.count()==0 ? 'hide' : '';
     };
     this.count = () => {
         return STORE.get('requests.messages.unread.list').length;
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-REQUEST-MESSAGES-UNREAD') {
             this.update();
             ACTIONS.notifyNewMessages();
         }
     });
});

riot.tag2('home_servie-items', '<div class="items"> <div each="{obj in source()}" class="item"> <service-card-small source="{obj}"></service-card-small> </div> </div>', 'home_servie-items { overflow: auto; height: 100%; display: block; padding-top: 22px; padding-bottom: 222px; }', '', function(opts) {
     this.source = () => {
         return STORE.get('gitlab.list');
     };

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-SERVICE-ITEMS') {
             this.update();
         }
     });
});

riot.tag2('home_squeeze-area', '<div style="width:444px; margin-bottom:22px; margin-left:22px;"> <div class="control has-icons-left has-icons-right"> <input class="input is-small is-rounded" type="text" placeholder="Squeeze Impure※ まだ表示のみで機能しません。" onkeyup="{onKeyUp}" ref="word"> <span class="icon is-left"> <i class="fas fa-search" aria-hidden="true"></i> </span> </div> </div> <button class="button" onclick="{clickClearButton}" style="margin-top:3px; height:22px;"> <i class="fas fa-times-circle"></i> </button>', 'home_squeeze-area { display: flex; } home_squeeze-area .button{ padding: 0px; margin-left: 8px; background: none; border: none; color: #ffff; } home_squeeze-area .button:hover{ color: #880000; } home_squeeze-area .button i{ font-size: 22px; }', '', function(opts) {
     this.clickClearButton = (e) => {
         this.refs.word.value = '';
         this.opts.callback('squeeze-impure', '');
     };

     this.onKeyUp = (e) => {
         this.opts.callback('squeeze-impure', e.target.value);
     };
});

riot.tag2('icon-door-closed', '<span class="icon closed-door"> <i class="fas fa-door-closed"></i> </span>', 'icon-door-closed span.icon { color: #cccccc; } icon-door-closed span.icon:hover { color: #880000; }', '', function(opts) {
});

riot.tag2('icon-door-opened', '<span class="icon opened-door" maledict-id="{id}"> <i class="fas fa-door-open" maledict-id="{id}"></i> </span>', 'icon-door-opened span.icon { color: #880000; }', '', function(opts) {
});

riot.tag2('icon-ranning', '<i class="fas fa-running"></i>', 'icon-ranning i { color: #cccccc; } icon-ranning i:hover { color: #880000; }', '', function(opts) {
});

riot.tag2('impure-card-footer', '<footer class="card-footer" style="font-size:14px; height:33px;"> <span class="card-footer-item action" action="{startStopAction()}" onclick="{clickButton}">{startStopLabel()}</span> <span class="card-footer-item view" action="move-2-view" onclick="{clickButton}">照会</span> <span class="card-footer-item open" action="{changeSizeAction()}" onclick="{clickButton}">{changeSizeLabel()}</span> </footer>', '', '', function(opts) {

     this.startStopLabel = () => {
         if (!this.opts.status)
             return '開始';

         return '停止';
     }
     this.startStopAction = () => {
         if (!this.opts.status)
             return 'start-action';

         return 'stop-action';
     }
     this.changeSizeLabel = () => {
         if (this.opts.mode == 'large')
             return '閉じる'

         return '開く'
     }
     this.changeSizeAction = () => {
         if (this.opts.mode == 'large')
             return 'switch-small'

         return 'switch-large'
     }

     this.clickButton = (e) => {
         let target = e.target;
         let action = target.getAttribute('action');

         if (action=='start-action' && this.opts.status)
             return;

         if (action=='stop-action' && !this.opts.status)
             return;

         this.opts.callback(action);
     };
});

riot.tag2('impure-card-header', '<header class="card-header" style="height:33px;"> <p class="card-header-title">Impure</p> <impure-card-move-icon callback="{opts.callback}" data="{opts.data}"></impure-card-move-icon> </header>', '', '', function(opts) {
});

riot.tag2('impure-card-large', '<div class="card hw-box-shadow"> <impure-card-header callback="{opts.callback}" data="{opts.data}"></impure-card-header> <div class="card-content" style="display:flex;flex-direction:column;"> <div> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> </div> <div style="margin-top:11px; flex-grow:1;"> <impure-card-large_tab_show class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_show> <impure-card-large_tab_edit class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_edit> <impure-card-large_tab_incantation class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_incantation> <impure-card-large_tab_create-after class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_create-after> <impure-card-large_tab_finish class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_finish> </div> </div> <impure-card-footer callback="{this.opts.callback}" status="{opts.status}" mode="large"></impure-card-footer> </div>', 'impure-card-large > .card { width: calc(222px + 222px + 222px + 22px + 22px); height: calc(222px + 222px + 22px); float: left; margin-left: 22px; margin-top: 1px; margin-bottom: 22px; border: 1px solid #dddddd; border-radius: 5px; } impure-card-large > .card .card-content{ height: calc(222px + 222px + 22px - 33px - 33px - 1px); padding: 11px 22px; overflow: auto; } impure-card-large .tabs { font-size:12px; }', '', function(opts) {
     STORE.subscribe((action) => {
         if (action.type=='SAVED-IMPURE') {
         }
     });

     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };

     this.page_tabs = new PageTabs([
         {code: 'show',         label: '照会',           tag: 'impure-card-large_tab_show' },
         {code: 'edit',         label: '編集',           tag: 'impure-card-large_tab_edit' },
         {code: 'incantation',  label: '詠唱',           tag: 'impure-card-large_tab_incantation' },
         {code: 'create-after', label: '後続作業の作成', tag: 'impure-card-large_tab_create-after' },
         {code: 'finish',       label: '完了',           tag: 'impure-card-large_tab_finish' },
     ]);

     this.on('mount', () => {

         let len = Object.keys(this.tags).length;
         if (len==0)
             return;

         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };
});

riot.tag2('impure-card-large_tab_create-after', '<div class="form-contents"> <div class="left"> <input class="input is-small" type="text" placeholder="Title" ref="name" onkeyup="{keyUpTitle}"> <textarea class="textarea is-small" placeholder="Description" rows="6" style="margin-top:11px; flex-grow:1;" ref="description"></textarea> </div> <div class="right"> <button class="button is-small" onclick="{clickReset}">Reset</button> <button class="button is-small" onclick="{clickClear}">Clear</button> <span style="flex-grow:1;"></span> <button class="button is-small is-success" onclick="{clickCreate}" disabled="{isDisable()}">Create!</button> </div> </div>', 'impure-card-large_tab_create-after .form-contents { display:flex; width:100%; height:100%; } impure-card-large_tab_create-after .form-contents > .left { flex-grow:1; display:flex; flex-direction:column; } impure-card-large_tab_create-after .form-contents > .right{ padding-left:8px; display:flex; flex-direction: column; } impure-card-large_tab_create-after .form-contents > .right > * { margin-bottom: 8px; }', '', function(opts) {
     this.isDisable = () => {
         return this.refs.name.value.trim().length==0;
     };
     this.keyUpTitle = () => {
         this.update();
     };

     this.name = '';
     this.description = '';
     STORE.subscribe((action) => {
         if (action.type=='CREATED-IMPURE-AFTER-IMPURE')
             if (action.from.id == this.opts.data.id) {
                 this.clickClear();
             }
     });
     this.clickReset = () => {
         let from = this.opts.data;

         this.refs.name.value = from.name;
         this.refs.description.value = from.description;

         this.update();
     };
     this.clickClear = () => {
         this.refs.name.value = '';
         this.refs.description.value = '';

         this.update();
     };
     this.clickCreate = () => {
         ACTIONS.createImpureAfterImpure(this.opts.data, {
             name: this.refs.name.value,
             description: this.refs.description.value,
         })
     };
});

riot.tag2('impure-card-large_tab_edit', '<div class="form-contents"> <div class="left"> <input class="input is-small" type="text" placeholder="Text input" riot-value="{name()}" ref="name" style="margin-bottom:8px;"> <textarea class="textarea description is-small" placeholder="10 lines of textarea" rows="10" style="flex-grow: 1;" ref="description">{description()}</textarea> </div> <div class="right"> <span style="flex-grow:1;"></span> <button class="button is-small is-danger" onclick="{clickSave}">Save</button> </div> </div>', 'impure-card-large_tab_edit .form-contents { display:flex; width:100%; height:100%; } impure-card-large_tab_edit .form-contents > .left { flex-grow:1; display:flex; flex-direction:column; } impure-card-large_tab_edit .form-contents > .right{ padding-left:8px; display:flex; flex-direction: column; }', '', function(opts) {
     this.clickSave = () => {
         this.opts.callback('save-impure-contents', {
             id: this.opts.data.id,
             name: this.refs.name.value.trim(),
             description: this.refs.description.value.trim(),
         });
     };

     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };
     this.description = () => {
         if (!this.opts.data) return ''
         return this.opts.data.description.trim();
     };
});

riot.tag2('impure-card-large_tab_finish', '<div class="form-contents"> <div class="left"> <textarea class="textarea is-small" placeholder="完了時のメモなどがあれば入力してください。(任意項目)" style="width:100%; height:100%;" ref="spell"></textarea> </div> <div class="right"> <a class="button is-small" action="finishe-impure" onclick="{clickClearButton}">Clear</a> <span style="flex-grow:1;"></span> <a class="button is-small is-danger" action="finishe-impure" onclick="{clickFinishButton}">完了</a> </div> </div>', 'impure-card-large_tab_finish .form-contents { display:flex; width:100%; height:100%; } impure-card-large_tab_finish .form-contents > .left { flex-grow:1; width:100%; height:100%; } impure-card-large_tab_finish .form-contents > .right{ padding-left:8px; display:flex; flex-direction: column; }', '', function(opts) {
     this.clickClearButton = (e) => {
         this.refs.spell.value = '';
     }
     this.clickFinishButton = (e) => {
         let target = e.target;
         let spell = this.refs.spell.value.trim();

         this.opts.callback(target.getAttribute('action'), { spell: spell });
     };
});

riot.tag2('impure-card-large_tab_incantation', '<div class="form-contents"> <div class="left"> <textarea class="textarea is-small" placeholder="作業中のメモなどを入力してください。 ※準備中" style="width:100%; height:100%;" ref="spell" disabled></textarea> </div> <div class="right"> <a class="button is-small" action="finishe-impure" onclick="{clickClearButton}" disabled>Clear</a> <span style="flex-grow:1;"></span> <a class="button is-small is-danger" action="finishe-impure" onclick="{clickFinishButton}" disabled>完了</a> </div> </div>', 'impure-card-large_tab_incantation .form-contents { display:flex; width:100%; height:100%; } impure-card-large_tab_incantation .form-contents > .left { flex-grow:1; width:100%; height:100%; } impure-card-large_tab_incantation .form-contents > .right{ padding-left:8px; display:flex; flex-direction: column; }', '', function(opts) {
     this.clickClearButton = (e) => {
         this.refs.spell.value = '';
     }
     this.clickFinishButton = (e) => {
         let target = e.target;
         let spell = this.refs.spell.value.trim();

         this.opts.callback(target.getAttribute('action'), { spell: spell });
     };
});

riot.tag2('impure-card-large_tab_show-description', '', 'impure-card-large_tab_show-description h1 { font-weight: bold; font-size: 20px; margin-top: 11px; text-decoration: underline; } impure-card-large_tab_show-description h1:first-child { margin-top: 0px; } impure-card-large_tab_show-description h2 { font-weight: bold; font-size: 18px; margin-top: 11px; text-decoration: underline; } impure-card-large_tab_show-description h3 { font-weight: bold; font-size: 16px; text-decoration: underline; } impure-card-large_tab_show-description h4 { font-weight: bold; font-size: 14px; } impure-card-large_tab_show-description h5 { font-weight: bold; font-size: 12px; } impure-card-large_tab_show-description * { font-size: 12px; } impure-card-large_tab_show-description table { border-collapse: collapse; } impure-card-large_tab_show-description td { border: solid 1px; padding: 2px 5px; } impure-card-large_tab_show-description th { border: solid 1px; padding: 2px 5px; background: #eeeeee; } impure-card-large_tab_show-description li { list-style-type: square; margin-left: 22px; } impure-card-large_tab_show-description pre { white-space: pre-wrap; }', 'class="hw-markdown"', function(opts) {
     this.on('update', () => {
         this.root.innerHTML = this.opts.contents;
     });

    this.root.innerHTML = opts.contents

});

riot.tag2('impure-card-large_tab_show', '<div style="width:100%; height:100%;"> <div style="flex-grow:1; display:flex; flex-direction:column;"> <p style="font-weight: bold;">{name()}</p> <div class="description" style="padding:11px; overflow:auto;"> <impure-card-large_tab_show-description contents="{this.description()}"></impure-card-large_tab_show-description> </div> </div> </div>', '', '', function(opts) {
     this.name = () => {
         if (!this.opts.data) return '????????'

         return this.opts.data.name;
     };
     this.description = () => {
         if (!this.opts.data || !this.opts.data.description)
             return ''

         let out = '';
         try {
             out = marked(this.opts.data.description)
             out = out.replace(/{/g, '\\{');
             out = out.replace(/}/g, '\\}');
         } catch (e) {
             dump(e);
             console.trace();
         }

         return out;
     };
});

riot.tag2('impure-card-move-icon', '<a href="#" class="card-header-icon" aria-label="more options"> <span class="icon" title="このアイコンを扉へドラッグ&ドロップすると、扉の場所へ移動できます。" draggable="true" dragstart="{dragStart}" dragend="{dragEnd}"> <icon-ranning></icon-ranning> </span> </a>', 'impure-card-move-icon a.card-header-icon { padding: 5px 8px; }', '', function(opts) {
     this.dragStart = (e) => {
         let target = e.target;

         e.dataTransfer.setData('impure', JSON.stringify(this.opts.data));

         this.opts.callback('start-drag');
     };
     this.dragEnd = (e) => {
         this.opts.callback('end-drag');
     };
});

riot.tag2('impure-card-small', '<div class="card hw-box-shadow"> <impure-card-header callback="{opts.callback}" data="{opts.data}"></impure-card-header> <div class="card-content"> <div class="content" style="font-size:12px;"> <p>{name()}</p> </div> </div> <impure-card-footer callback="{this.opts.callback}" status="{opts.status}" mode="small"></impure-card-footer> </div>', 'impure-card-small > .card { width: 188px; height: 188px; float: left; margin-left: 22px; margin-top: 1px; margin-bottom: 22px; border: 1px solid #dddddd; border-radius: 5px; } impure-card-small > .card .card-content{ height: calc(188px - 33px - 33px - 1px); padding: 11px 22px; overflow: auto; word-break: break-all; }', '', function(opts) {
     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };
     this.description = () => {
         if (!this.opts.data) return ''
         return this.opts.data.description;
     };
});

riot.tag2('impure-card', '<impure-card-small data="{opts.data}" status="{status()}" callback="{callback}"></impure-card-small> <impure-card-large data="{opts.data}" status="{status()}" callback="{callback}"></impure-card-large>', 'impure-card.large > impure-card-small { display: none; } impure-card.small > impure-card-large { display: none; } impure-card[status=start] div.card impure-card-header > .card-header { background: rgba(254, 242, 99, 0.888); } impure-card[status=start] impure-card-small > .card .card-content p { font-weight: bold; } impure-card[status=start] .card { box-shadow: 0px 0px 22px rgba(254, 242, 99, 0.666); }', 'class="{cardSize()}" status="{status()}"', function(opts) {
     this.callback = (action, data) => {
         if ('switch-large'==action)
             return this.opts.callbacks.switchSize('large', opts.data);

         if ('switch-small'==action)
             return this.opts.callbacks.switchSize('small', opts.data);

         if ('start-drag'==action)
             ACTIONS.startDragImpureIcon();

         if ('end-drag'==action)
             ACTIONS.endDragImpureIcon();

         if ('start-action'==action)
             ACTIONS.startImpure(this.opts.data);

         if ('stop-action'==action)
             ACTIONS.stopImpure(this.opts.data);

         if ('finishe-impure'==action)
             ACTIONS.finishImpure(this.opts.data, true, data.spell);

         if ('save-impure-contents'==action)
             ACTIONS.saveImpure(data);

         if ('move-2-view'==action)
             location.hash = '#home/impures/' + this.opts.data.id;
     };

     this.cardSize = () => {
         return this.opts.open ? 'large' : 'small';
     };
     this.isStart = () => {
         if (!this.opts.data) return false;
         if (!this.opts.data.purge) return false;

         return true;
     }
     this.status = () => {
         return this.isStart() ? 'start' : '';
     };
});

riot.tag2('modal_request-impure-default-msgs', '<button each="{obj in templates}" class="button is-small" val="{obj.value}" onclick="{clickButton}">{obj.label}</button>', 'modal_request-impure-default-msgs > .button { margin-right: 8px; margin-bottom: 8px; }', '', function(opts) {
     this.templates = [
         { label: '改行',                         value: '\n'},
         { label: 'ご確認よろしくお願いします。(改行付き)', value: 'ご確認よろしくお願いします。\n' },
         { label: 'MRレビューをお願いします。(改行付き)',   value: 'MRレビューをお願いします。\n'  },
         { label: 'ご対応よろしくお願いします。(改行付き)', value: 'ご対応よろしくお願いします。\n'  },
     ];

     this.clickButton = (e) => {
         let target = e.target;
         let msg = target.getAttribute('val') || target.textContent;

         this.opts.callback('add-template-to-msg', { message: msg });
     };
});

riot.tag2('modal_request-impure-detail', '<table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth"> <thead> <tr> <th>Type</th> <th>ID</th> <th>Name</th></tr> </thead> <tbody> <tr> <th>Impure</th> <td>{val(\'impure\', \'id\')}</td> <td>{val(\'impure\', \'name\')}</td> </tr> <tr> <th>Angel</th> <td>{val(\'angel\', \'id\')}</td> <td>{val(\'angel\', \'name\')}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.val = (name, key) => {
         if (!opts.source || !opts.source[name])
             return null;

         let obj = opts.source[name];

         return obj[key];
     };
});

riot.tag2('modal_request-impure', '<div class="modal {opts.source ? \'is-active\' : \'\'}"> <div class="modal-background" onclick="{clickClose}"></div> <div class="modal-content"> <div class="card"> <header class="card-header"> <p class="card-header-title"> Request Impure </p> </header> <div class="card-content"> <div class="content"> <div class="field"> <label class="label">依頼内容</label> <modal_request-impure-detail source="{opts.source}"></modal_request-impure-detail> </div> <div class="field"> <label class="label">お願い文章を書いてください。(必須ではありません)</label> <textarea ref="message" class="textarea is-small" placeholder="一言あるだけで気分が大分変りますので。"></textarea> </div> </div> <div class="field" style="margin-top: -14px; padding-left: 22px;"> <p class="label is-small">お願い文章 の定型文。</p> <modal_request-impure-default-msgs callback="{callback}"></modal_request-impure-default-msgs> </div> <div style="overflow: hidden;"> <a class="button is-danger" style="float:left;" onclick="{clickClose}">Cancel</a> <a class="button is-primary" style="float:right;" onclick="{clickCommit}">Request</a> </div> </div> </div> <button class="modal-close is-large" aria-label="close" onclick="{clickClose}"></button> </div> </div>', '', '', function(opts) {
     this.val = (name, key) => {
         if (!opts.source || !opts.source[name])
             return null;

         let obj = opts.source[name];

         return obj[key];
     };
     this.callback = (action, data) => {
         if (action=='add-template-to-msg') {
             let message_area = this.refs.message;
             let pos = message_area.selectionStart;

             let message = message_area.value;
             var befor = message.substr(0, pos);
             var after = message.substr(pos);

             let message_add = data.message;
             message_area.value = befor + message_add + after;

             let new_post = (befor + message_add).length;

             message_area.selectionStart = new_post;
             message_area.selectionEnd   = new_post;
             message_area.focus();

             return;
         }
     };

     this.clickCommit = () => {
         ACTIONS.transferImpureToAngel(
             this.opts.source.impure,
             this.opts.source.angel,
             this.refs.message.value.trim(),
         );
     };
     this.clickClose = () => {
         ACTIONS.stopTransferImpureToAngel();
     };
});

riot.tag2('home_orthodox-angels', '<nav class="panel hw-box-shadow"> <p class="panel-heading">Exorcists</p> <a class="panel-block"> <orthodox-doropdown></orthodox-doropdown> </a> <a each="{obj in data()}" class="panel-block" angel-id="{obj.id}" style="padding:5px 8px;"> <span style="width:100%;font-size:11px;;" maledict-id="{obj.id}"> {obj.name} </span> <home_emergency-door source="{obj}"></home_emergency-door> </a> </nav>', 'home_orthodox-angels > .panel { width: 188px; margin-top: 22px; border-radius: 4px 4px 0 0; } home_orthodox-angels > .panel > a { background: #ffffff; } home_orthodox-angels > .panel > .panel-heading { font-size:12px; font-weight: bold; }', '', function(opts) {
     this.dragging = false;
     this.exorcists = [];

     this.data = () => {
         return this.exorcists;
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ORTHODOX-EXORCISTS') {
             this.exorcists = action.exorcists

             this.update();
         }
     });

     this.active_maledict = null;
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ANGELS')
             this.update();
     });
});

riot.tag2('orthodox-doropdown', '<div class="dropdown {open ? \'is-active\' : \'\'}" style="width:100%;"> <div class="dropdown-trigger" style="width:100%;"> <button class="button" style="width:100%;height: 33px;" aria-haspopup="true" aria-controls="dropdown-menu" onclick="{clickButton}"> <span style="font-size:11px;">{orthodox ? orthodox.name : \'Choose Orthodox\'}</span> <span class="icon is-small" style="font-size:11px;"> <i class="fas fa-angle-down" aria-hidden="true"></i> </span> </button> </div> <div class="dropdown-menu" style="width:100%" id="dropdown-menu" role="menu"> <div class="dropdown-content"> <a each="{orthodox in orthodoxs()}" class="dropdown-item" orthodox-id="{orthodox.id}" onclick="{selectItem}" style="font-size:11px;"> {orthodox.name} </a> </div> </div> </div>', '', 'style="width:100%;"', function(opts) {
     this.changeOrthodox = (id) => {
         this.open = null;

         this.orthodox = STORE.get('orthodoxs.ht')[id];

         this.update();

         ACTIONS.fetchOrthodoxExorcists(id);
     };

     this.open = null;
     this.orthodox = null;
     this.exorcists = [];

     this.changeOrthodox(STORE.get('profiles.orthodox.id'));

     this.clickButton = () => {
         this.open = !this.open;
         this.update();
     };
     this.selectItem = (e) => {
         let id = e.target.getAttribute('orthodox-id');

         this.open = null;

         this.orthodox = STORE.get('orthodoxs.ht')[id];

         this.update();

         ACTIONS.fetchOrthodoxExorcists(id);
     };

     this.orthodoxs = () => {
         return STORE.get('orthodoxs.list');
     };
});

riot.tag2('home_other-services', '<nav class="panel hw-box-shadow"> <p class="panel-heading">Services</p> <a each="{data()}" class="panel-block" angel-id="{id}" deccot-id="{id}" service="{service}" onclick="{click}" style="font-size:11px;"> <span style="width:100%;" deccot-id="{id}" service="{service}"> {service} </span> <span class="operators"> </span> </a> </nav>', 'home_other-services > .panel { width: 188px; margin-top: 22px; border-radius: 4px 4px 0 0; } home_other-services > .panel > a { background: #ffffff; } home_other-services > .panel > .panel-heading { font-size:12px; font-weight: bold; } home_other-services .move-door.close .opened-door{ display: none; } home_other-services .move-door.open .closed-door{ display: none; }', '', function(opts) {
     this.dragging = false;
     this.active_maledict = null;

     this.data = () => {
         return STORE.get('deccots').list;
     };

     this.click = (e) => {
         let elem = e.target;

         ACTIONS.selectServiceItem({
             service: elem.getAttribute('service'),
             id: elem.getAttribute('deccot-id'),
         })

     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ANGELS')
             this.update();
     });
});

riot.tag2('service-card-small', '<div class="card hw-box-shadow"> <header class="card-header"> <p class="card-header-title"> Gitlab &nbsp; <a href="{url()}" target="_blank">Issues</a> </p> </header> <div class="card-content"> <div class="content" style="font-size:14px;"> <p style="word-break: break-all;">{name()}</p> </div> </div> <footer class="card-footer"> <a class="card-footer-item" href="{assignee_url()}" taget="_blank"> {assignee_name()} </a> </footer> </div>', 'service-card-small > .card { width: 222px; height: 222px; float: left; margin-left: 22px; margin-top: 1px; margin-bottom: 22px; border: 1px solid #dddddd; border-radius: 5px; } service-card-small > .card .card-content{ height: calc(222px - 49px - 48px); padding: 11px 22px; overflow: auto; }', '', function(opts) {
     this.name = () => {
         if (!this.opts.source) return '????????'

         return this.opts.source.title;
     };
     this.url = () => {
         if (!this.opts.source) return ''

         return this.opts.source.web_url;
     };
     this.assignee_name = () => {
         if (!this.opts.source) return '????????'

         return this.opts.source.assignee.username;
     };
     this.assignee_url = () => {
         if (!this.opts.source) return ''

         return this.opts.source.assignee.web_url;
     };
});

riot.tag2('impure_page-tabs', '<div class="tabs is-toggle"> <ul> <li class="is-active"> <a> <span>基本情報</span> </a> </li> <li> <a> <span>浄化履歴</span> </a> </li> <li> <a> <span>Impure の鎖</span> </a> </li> <li> <a> <span>依頼履歴</span> </a> </li> </ul> </div>', 'impure_page-tabs li > a { background: #fff; }', '', function(opts) {
});

riot.tag2('impure_page', '<section class="section" style="padding-bottom: 22px;"> <div class="container"> <h1 class="title hw-text-white">Impure</h1> <h2 class="subtitle hw-text-white"> <section-breadcrumb></section-breadcrumb> </h2> </div> </section> <section class="section" style="padding-top:22px; padding-bottom:22px;"> <div class="container"> <page-tabs core="{page_tabs}" callback="{clickTab}" type="toggle"></page-tabs> </div> </section> <div class="tab-contents-area"> <impure_page_tab-basic class="hide" source="{impure}"></impure_page_tab-basic> <impure_page_tab-purges class="hide" source="{impure}"></impure_page_tab-purges> <impure_page_tab-incantation class="hide" source="{impure}"></impure_page_tab-incantation> <impure_page_tab-requests class="hide" source="{impure}"></impure_page_tab-requests> <impure_page_tab-chains class="hide" source="{impure}"></impure_page_tab-chains> </div>', 'impure_page page-tabs li a{ background: #fff; } impure_page { width: 100%; height: 100%; display: block; overflow: auto; }', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'basic',       label: '基本情報', tag: 'impure_page_tab-basic' },
         {code: 'purges',      label: '浄化履歴', tag: 'impure_page_tab-purges' },
         {code: 'incantation', label: '詠唱履歴', tag: 'impure_page_tab-incantation' },
         {code: 'requests',    label: '依頼履歴', tag: 'impure_page_tab-requests' },
         {code: 'chains',      label: '連鎖',     tag: 'impure_page_tab-chains' },
     ]);

     this.on('mount', () => {
         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };

     this.id = () => {
         return location.hash.split('/').reverse()[0];
     }
     this.name = () => {
         if (this.impure)
             return this.impure.name;

         return '';
     };

     this.impure = null;
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-IMPURE') {
             this.impure = action.impure;
             this.update();
         }
     });
     this.on('mount', () => {
         ACTIONS.fetchImpure(this.id());
     });
});

riot.tag2('impure_page_tab-basic', '<section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white is-4">Name</h1> <div class="contents hw-text-white" style="font-weight:bold;"> <p>{name()}</p> </div> </div> </section> <section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white is-4">Description</h1> <div class="contents hw-text-white" style="font-weight:bold;"> <p><pre>{description()}</pre></p> </div> </div> </section>', '', '', function(opts) {
     this.name = () => {
         let impure = this.opts.source;

         if (!impure)
             return '????????';

         return impure.name;
     };
     this.description = () => {
         let impure = this.opts.source;

         if (!impure)
             return '????????';

         return impure.description;
     };
});

riot.tag2('impure_page_tab-chains', '<section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white">準備中</h1> </div> </section>', '', '', function(opts) {
});

riot.tag2('impure_page_tab-incantation', '<section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white"></h1> <div class="contents"> <request-messages-list sources="{sources()}"></request-messages-list> </div> </div> </section>', '', '', function(opts) {
     this.sources = () => {
         let impure = this.opts.source;

         if (!impure)
             return [];

         return impure.sources;
     };
});

riot.tag2('impure_page_tab-purges', '<section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white"></h1> <div class="contents"> <purges-list data="{purges()}" callback="{callback}"></purges-list> </div> </div> </section>', '', '', function(opts) {
     this.purges = () => {
         if (!this.opts.source)
             return { list: [], ht: {} };

         return { list: this.opts.source.purges, ht: {} };
     };
     this.callback = (action, data) => {
     };
});

riot.tag2('impure_page_tab-requests', '<section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white"></h1> <div class="contents"> <request-messages-list sources="{requests()}"></request-messages-list> </div> </div> </section>', '', '', function(opts) {
     this.requests = () => {
         let impure = this.opts.source;

         if (!impure)
             return [];

         return impure.requests;
     };
});

riot.tag2('exorcists-list', '<table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow"> <thead> <tr> <th>ID</th> <th>Name</th> <th>Ghost ID</th> </tr> </thead> <tbody> <tr each="{orthodox in orthodoxs()}"> <td>{orthodox.id}</td> <td>{orthodox.name}</td> <td>{orthodox.ghost_id}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.orthodoxs = () => {
         return STORE.get('angels.list');
     };
});

riot.tag2('orthodox-list', '<table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow"> <thead> <tr> <th>ID</th> <th>Name</th> <th>Description</th> </tr> </thead> <tbody> <tr each="{orthodox in orthodoxs()}"> <td>{orthodox.id}</td> <td>{orthodox.name}</td> <td>{orthodox.description}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.orthodoxs = () => {
         return STORE.get('orthodoxs.list');
     };
});

riot.tag2('orthodox_page', '<section class="section"> <div class="container"> <h1 class="title hw-text-white">正教会</h1> <h2 class="subtitle hw-text-white">正教会=チーム</h2> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">Orthodoxs</h1> <div class="contents hw-text-white"> <orthodox-list></orthodox-list> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">Exorcists</h1> <div class="contents hw-text-white"> <exorcists-list></exorcists-list> </div> </div> </section> </div> </section>', 'orthodox_page { width: 100%; height: 100%; display: block; overflow: auto; }', '', function(opts) {
     this.orthodoxs = () => {
         return STORE.get('orthodoxs.list');
     };

     this.on('mount', () => {
         ACTIONS.fetchOrthodoxs();
         ACTIONS.fetchOrthodoxAllExorcists();
     });

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ORTHODOXS')
             this.tags['orthodox-list'].update();

         if (action.type=='FETCHED-ORTHODOX-ALL-EXORCISTS')
             this.update();
     });
});

riot.tag2('move-date-operator', '<div class="operator hw-box-shadow"> <div class="befor"> <button class="button" onclick="{clickBefor}"><</button> </div> <div class="trg"> <span>{opts.label}</span> </div> <div class="after"> <button class="button" onclick="{clickAfter}">></button> </div> </div>', 'move-date-operator .operator { display: flex; margin-left:11px; border-radius: 8px; } move-date-operator .operator span { font-size:18px; } move-date-operator .button{ border: none; } move-date-operator .befor, move-date-operator .befor .button{ border-radius: 8px 0px 0px 8px; } move-date-operator .after, move-date-operator .after .button{ border-radius: 0px 8px 8px 0px; } move-date-operator .operator > div { border: 1px solid #dbdbdb; width: 36px; } move-date-operator .operator > div.trg{ padding-top: 5px; padding-left: 8px; border-left: none; border-right: none; background: #ffffff; }', '', function(opts) {
     this.clickBefor = () => {
         this.opts.callback('move-date', {
             unit: this.opts.unit,
             amount: -1,
         });
     }
     this.clickAfter = () => {
         this.opts.callback('move-date', {
             unit: this.opts.unit,
             amount: 1,
         });
     }
});

riot.tag2('purge-result-editor', '<div class="modal {opts.data ? \'is-active\' : \'\'}"> <div class="modal-background"></div> <div class="modal-card"> <header class="modal-card-head"> <p class="modal-card-title">作業時間の変更</p> <button class="delete" aria-label="close" action="close-purge-result-editor" onclick="{clickButton}"></button> </header> <section class="modal-card-body"> <div class="field is-horizontal"> <div class="field-label is-normal"> <label class="label">Impure</label> </div> <div class="field-body"> <div class="field"> <p class="control"> <input class="input is-static" type="text" riot-value="{getVal(\'impure_name\')}" readonly> </p> </div> </div> </div> <div class="field is-horizontal"> <div class="field-label is-normal"> <label class="label">作業時間</label> </div> <div class="field-body"> <div class="field"> <p class="control"> <input class="input is-static" type="text" riot-value="{getVal(\'elapsed-time\')}" readonly> </p> </div> </div> </div> <div class="field is-horizontal"> <div class="field-label is-normal"> <label class="label">Start</label> </div> <div class="field-body"> <div class="field"> <p class="control"> <input class="input" riot-value="{date2str(getVal(\'start\'))}" ref="start" type="{\'datetime\'}"> </p> </div> </div> </div> <div class="field is-horizontal"> <div class="field-label is-normal"> <label class="label">End</label> </div> <div class="field-body"> <div class="field"> <p class="control"> <input class="input" riot-value="{date2str(getVal(\'end\'))}" ref="end" type="{\'datetime\'}"> </p> </div> </div> </div> </section> <footer class="modal-card-foot"> <button class="button is-success" action="save-purge-result-editor" onclick="{clickButton}">Save changes</button> <button class="button" action="close-purge-result-editor" onclick="{clickButton}">Cancel</button> </footer> </div> </div>', '', '', function(opts) {
     this.clickButton = (e) => {
         let action = e.target.getAttribute('action');

         if (action != 'save-purge-result-editor') {
             this.opts.callback(action);
             return;
         }

         let stripper = new TimeStripper();

         this.opts.callback(action, {
             id: this.opts.data.id,
             start: stripper.str2date(this.refs.start.value),
             end: stripper.str2date(this.refs.end.value)
         })
     };

     this.getVal = (key) => {
         let data = this.opts.data;

         if (!data)
             return '';

         if (key=='elapsed-time')
             return new TimeStripper().format_elapsedTime(this.opts.data.start, this.opts.data.end);

         return data[key];
     };
     this.date2str = (date) => {
         if (!date) return '';

         return moment(date).format("YYYY-MM-DD HH:mm:ss");
     };
});

riot.tag2('purges-list', '<table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth hw-box-shadow"> <thead> <tr> <th rowspan="2">Impure</th> <th colspan="5">Purge</th> </tr> <tr> <th>開始</th> <th>終了</th> <th>時間</th> <th>間隔</th> <th>操作</th> </tr> </thead> <tbody> <tr each="{data()}"> <td>{impure_name}</td> <td>{fdt(start)}</td> <td>{fdt(end)}</td> <td style="text-align: right;">{elapsedTime(start, end)}</td> <td>{span(this)}</td> <td><button class="button" data-id="{id}" onclick="{clickEditButton}">変更</button></td> </tr> </tbody> </table>', '', '', function(opts) {
     this.befor_data = null;
     this.span = (d) => {
         if (!this.befor_data) {
             this.befor_data = d;
             return '---';
         }

         let x = new TimeStripper().format_elapsedTime (d.end, this.befor_data.start);

         this.befor_data = d;

         return x;
     };
     this.data = () => {
         this.befor_data = null;

         return opts.data.list.sort((a, b) => {
             return a.start < b.start ? 1 : -1;
         });
     };

     this.clickEditButton = (e) => {
         let target = e.target;

         this.opts.callback('open-purge-result-editor', {
             id: target.getAttribute('data-id')
         })
     };

     this.fdt = (dt) => {
         return new TimeStripper().format(dt);
     }
     this.elapsedTime = (start, end) => {
         return new TimeStripper().format_elapsedTime(start, end);
     };
});

riot.tag2('purges_page', '<div style="padding: 33px 88px 88px 88px;"> <div> <h1 class="title hw-text-white">期間</h1> <purges_page_filter style="margin-bottom:22px; padding-left:33px; padding-right:33px;" from="{from}" to="{to}" callback="{callback}"></purges_page_filter> </div> <div> <h1 class="title hw-text-white">Summary</h1> <div style="display:flex; padding-left:33px; padding-right:33px;"> <div style="margin-right: 88px;"> <purges_page_group-span data="{data()}"></purges_page_group-span> </div> <div> <purges_page_group-span-deamon data="{data()}"></purges_page_group-span-deamon> </div> </div> </div> <div style="margin-top:33px;"> <h1 class="title hw-text-white">Guntt Chart</h1> <div style="padding-left:33px; padding-right:33px;"> <purges_page_guntt-chart data="{data()}"></purges_page_guntt-chart> </div> </div> <div style="margin-top:33px;"> <h1 class="title hw-text-white">Purge hisotry</h1> <div style="display:flex; padding-left:33px; padding-right:33px;"> <purges-list data="{data()}" callback="{callback}"></purges-list> </div> </div> </div> <purge-result-editor data="{edit_target}" callback="{callback}"></purge-result-editor>', 'purges_page { height: 100%; width: 100%; display: block; overflow: auto; } purges_page .card { border-radius: 8px; } purges_page button.refresh{ margin-top:6px; margin-right:8px; }', '', function(opts) {
     this.from = moment().startOf('day');
     this.to   = moment().add(1, 'd').startOf('day');
     this.moveDate = (unit, amount) => {
         this.from = this.from.add(amount, unit);
         this.to   = this.to.add(amount, unit);

         this.tags['purges_page_filter'].update();
     };

     this.edit_target = null;

     this.callback = (action, data) => {
         if ('open-purge-result-editor'==action) {
             this.edit_target = STORE.get('purges').ht[data.id];
             this.tags['purge-result-editor'].update();
             return;
         }

         if ('close-purge-result-editor'==action) {
             this.edit_target = null;
             this.tags['purge-result-editor'].update();
             return;
         }

         if ('save-purge-result-editor'==action)
             ACTIONS.saveActionResult(data);

         if ('move-date'==action)
             this.moveDate(data.unit, data.amount);

         if ('refresh'==action)
             this.refreshData();
     };

     this.refreshData = () => {
         ACTIONS.fetchPurgeHistory(this.from, this.to);
     };
     this.on('mount', () => {
         this.refreshData();
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PURGE-HISTORY')
             this.update();

         if (action.type=='SAVED-ACTION-RESULT') {
             this.edit_target = null;
             ACTIONS.pushSuccessMessage('Purge の実績の変更が完了しました。');
             ACTIONS.fetchPurgeHistory(this.from, this.to);
         }
     });

     this.data = () => {
         let list = STORE.get('purges');

         return list;
     };
});

riot.tag2('purges_page_filter', '<input class="input hw-box-shadow" type="text" placeholder="From" riot-value="{date2str(opts.from)}" readonly> <span style="font-size:24px; margin-left:11px; margin-right:11px;"> 〜 </span> <input class="input hw-box-shadow" type="text" placeholder="To" riot-value="{date2str(opts.to)}" readonly> <div class="operators" style="margin-top:-1px;"> <move-date-operator label="日" unit="d" callback="{callback}"></move-date-operator> <move-date-operator label="週" unit="w" callback="{callback}"></move-date-operator> <move-date-operator label="月" unit="M" callback="{callback}"></move-date-operator> <button class="button refresh hw-box-shadow" style="margin-top:1px; margin-left:11px;" onclick="{clickRefresh}">Refresh</button> </div>', 'purges_page_filter, purges_page_filter .operators { display: flex; } purges_page_filter .input { width: 111px; border: none; }', '', function(opts) {
     this.date2str = (date) => {
         if (!date) return '';
         return date.format('YYYY-MM-DD');
     };

     this.clickRefresh = () => {
         this.opts.callback('refresh');
     };

     this.callback = (action, data) => {
         this.opts.callback('move-date', {
             unit: data.unit,
             amount: data.amount,
         })
     };
});

riot.tag2('purges_page_group-span-deamon', '<p>区分毎の作業時間</p> <table class="table hw-box-shadow" style="margin-top: 33px;"> <thead> <tr> <th>Naem</th> <th>Time</th> <th>Count</th> </tr> </thead> <tbody> <tr each="{deamon in data()}"> <td>{deamon.name}</td> <td>{ts.format_sec(deamon.time)}</td> <td>{deamon.list.length}</td> </tr> </tbody> </table>', 'purges_page_group-span-deamon > p { width: 100%; color: #fff; font-weight: bold; text-shadow: 0px 0px 22px #333333; text-align: center; font-size: 22px; }', '', function(opts) {
     this.hw = new HolyWater();
     this.ts = new TimeStripper();

     this.data = () => {
         return this.hw.summaryPurgesAtDeamons(this.opts.data.list);
     };
});

riot.tag2('purges_page_group-span', '<p class="hw-text-white" style="width:100%; font-weight:bold; text-align: center;font-size: 22px;"> 合計作業時間 </p> <p class="hw-text-white" style="font-size: 111px;"> {sumHours()} </p>', '', '', function(opts) {
     this.sumHours = () => {
         let time_sec = new HolyWater().summaryPurges(this.opts.data.list);

         return new TimeStripper().format_sec(time_sec)
     };
});

riot.tag2('purges_page_guntt-chart', '<div style="overflow:auto; background:#fff; padding:22px;"> <svg class="chart-yabane"></svg> </div>', 'purges_page_guntt-chart { display: block; margin-left: 22px; margin-right: 22px; padding: 22px 11px; background: #fff; border-radius: 3px; } purges_page_guntt-chart > div { width: 100%; border-radius: 3px; } purges_page_guntt-chart > div > svg{ background: #fff; }', '', function(opts) {
     this.on('update', () => {
         let now   = moment().millisecond(0).second(0).minute(0).hour(0);
         let start = moment(now).startOf('d').hour(7);

         let options = {
             scale: {
                 x: {
                     cycle: 'hours',
                     tick:  88,
                     start: start,
                     end:   moment(now).add( 1, 'd').startOf('d').hour(6),
                 }
             },
             stage: {
                 selector: 'svg.chart-yabane',
             }
         }

         let hw = new HolyWater()
         let data = this.opts.data.list.map((d) => {
             return hw.makeGunntChartData(d);
         });

         try {
             new D3jsYabane()
                 .config(options)
                 .makeStage()
                 .data(data)
                 .draw();
         } catch (e) {
             ACTIONS.pushErrorMessage('Guntt Chart の描画に失敗しました。');
             dump(e);
         }
     });
});

riot.tag2('randing', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('randing_page_root', '', '', '', function(opts) {
});

riot.tag2('request-messages-list', '<table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th></th> <th>ID</th> <th>発生日時</th> <th>Impure</th> <th>From</th> <th class="message">Contents</th> </tr> </thead> <tbody> <tr each="{message in sources()}"> <td> <button class="button" message-id="{message.id}" onclick="{clickToReaded}">既読にする</button> </td> <td> {message.id} </td> <td>{dt(message.messaged_at)}</td> <td> <a href="#home/requests/impures/{message.impure_id}"> {message.impure_id} </a> </td> <td>{message.angel_id_from} </td> <td class="message"> <pre>{message.contents}</pre> </td> </tr> </tbody> </table>', '', '', function(opts) {
     this.sources = () => {
         if (this.opts.sources)
             return this.opts.sources;

         return STORE.get('requests.messages.unread.list').sort((a, b) => {
             if (new Date(a.messaged_at) > new Date(b.messaged_at))
                 return -1;
             else
                 return 1;
         });
     };
     this.dt = (v) => {
         if (!v)
             return '---';

         return moment(v).format('YYYY-MM-DD HH:mm')
     };
     this.contents = (v) => {
         let lines = v.split('\n').filter((d) => {
             return d.trim().length > 0;
         });

         let suffix = '';
         if (lines.length>1 || lines[0].length>33)
             suffix = '...';

         let val = lines[0];
         if (val.length>33)
             val = val.substring(0,33);

         return val + suffix;
     };
     this.clickToReaded = (e) => {
         let button = e.target;
         button.setAttribute('disabled', true)

         let id = button.getAttribute('message-id');

         ACTIONS.changeToReadRequestMessage(id);
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-REQUEST-MESSAGES-UNREAD')
             this.update();
     });
});

riot.tag2('request-messages', '<section class="section"> <div class="container"> <h1 class="title hw-text-white">Request</h1> <h2 class="subtitle hw-text-white"> <section-breadcrumb></section-breadcrumb> </h2> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">Messages</h1> <div class="contents hw-text-white"> <request-messages-list></request-messages-list> </div> </div> </section> </div> </section>', 'request-messages { width: 100%; height: 100%; display: block; overflow: auto; }', '', function(opts) {
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-REQUEST-MESSAGES-UNREAD')
             this.update();
     });
});


riot.tag2('war-history_page', '<section class="section"> <div class="container"> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> </div> </section> <div> <war-history_root_tab_days class="hide"></war-history_root_tab_days> <war-history_root_tab_weeks class="hide"></war-history_root_tab_weeks> <war-history_root_tab_month class="hide"></war-history_root_tab_month> </div>', '', '', function(opts) {
     this.default_tag = 'home';
     this.active_tag = null;
     this.page_tabs = new PageTabs([
         {code: 'days',  label: '日', tag: 'war-history_root_tab_days' },
         {code: 'weeks', label: '週', tag: 'war-history_root_tab_weeks' },
         {code: 'month', label: '月', tag: 'war-history_root_tab_month' },
     ]);
     this.on('mount', () => {
         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };
});

riot.tag2('war-history_root_tab_days', '<section class="section"> <div class="container"> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">悪魔別</h1> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">日別</h1> </div> </section> </div> </section> <section class="section"> <div class="container"> <h1 class="title hw-text-white">作業時間統計</h1> <h2 class="subtitle hw-text-white"> Purge の統計情報。どれくらいの作業時間か。とか。 </h2> </div> </section>', '', '', function(opts) {
});

riot.tag2('war-history_root_tab_month', '<section class="section"> <div class="container"> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">悪魔別</h1> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">日別</h1> </div> </section> </div> </section> <section class="section"> <div class="container"> <h1 class="title hw-text-white">作業時間統計</h1> <h2 class="subtitle hw-text-white"> Purge の統計情報。どれくらいの作業時間か。とか。 </h2> </div> </section>', '', '', function(opts) {
});


riot.tag2('war-history_root_tab_weeks', '<section class="section"> <div class="container"> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">悪魔別</h1> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">日別</h1> </div> </section> </div> </section> <section class="section"> <div class="container"> <h1 class="title hw-text-white">作業時間統計</h1> <h2 class="subtitle hw-text-white"> Purge の統計情報。どれくらいの作業時間か。とか。 </h2> </div> </section>', '', '', function(opts) {
});
