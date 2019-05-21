riot.tag2('angel-page-change-password', '<section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">パスワード変更</h1> <h2 class="subtitle hw-text-white">準備中</h2> </div> </section>', '', '', function(opts) {
});

riot.tag2('angel-page-github', '<section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">Github Token</h1> <div class="contents" style="padding-left:22px;"> <div></div> <div> <input class="input is-small" type="text" placeholder="Text input" style="width:222px;"> <div style="margin-top:11px;"> <button class="button is-small">Save</button> </div> </div> </div> </div> </section>', '', '', function(opts) {
     this.clickSignOut = () => {
         ACTIONS.signOut();
     };
});

riot.tag2('angel-page-gitlab', '<section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">Gitlab Token</h1> <div class="contents" style="padding-left:22px;"> <div></div> <div> <input class="input is-small" type="text" placeholder="Text input" style="width:222px;"> <div style="margin-top:11px;"> <button class="button is-small">Save</button> </div> </div> </div> </div> </section>', '', '', function(opts) {
     this.clickSignOut = () => {
         ACTIONS.signOut();
     };
});

riot.tag2('angel-page-sign-out', '<section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">サインアウト</h1> <h2 class="subtitle hw-text-white"></h2> <div class="contents"> <button class="button is-danger hw-box-shadow" style="margin-left:22px; margin-top:11px;" onclick="{clickSignOut}">Sign Out</button> </div> </div> </section>', '', '', function(opts) {
     this.clickSignOut = () => {
         ACTIONS.signOut();
     };
});

riot.tag2('angel_page', '<section class="section"> <div class="container"> </div> </section>', '', 'class="page-contents"', function(opts) {
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

riot.tag2('app', '<div class="kasumi"></div> <menu-bar brand="{{label:\'RT\'}}" site="{site()}" moves="{[]}"></menu-bar> <app-page-area></app-page-area> <p class="image-ref" style="">背景画像: <a href="http://joxaren.com/?p=853">旅人の夢</a></p> <message-area></message-area> <popup-working-action data="{impure()}"></popup-working-action> <menu-add-impure></menu-add-impure> <modal-create-impure open="{modal_open}" maledict="{modal_maledict}"></modal-create-impure> <modal-create-after-impure></modal-create-after-impure>', '', '', function(opts) {
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
             this.tags['popup-working-action'].update();
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

riot.tag2('cemetery-daily-list', '<table class="table is-bordered is-striped is-narrow is-hoverable" style="font-size:12px;"> <thead> <tr> <th>Date</th> <th>Deamon</th> <th>Action Count</th> </tr> </thead> <tbody> <tr each="{cemetry in daily()}"> <td>{cemetry.finished_at}</td> <td>{cemetry.deamon_name_short}</td> <td>{cemetry.purge_count}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.daily = () => {
         return this.opts.source.sort((a, b) => {
             return (a.finished_at < b.finished_at) ? 1 : -1;
         });
     };

});

riot.tag2('cemetery-list', '<table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth" style="font-size:12px;"> <thead> <tr> <th colspan="1" rowspan="2">Deamon</th> <th colspan="5">Impure</th> </tr> <tr> <th>ID</th> <th>Name</th> <th>Finish Purge</th> <th>Action Count</th> <th>Total Time</th> </tr> </thead> <tbody> <tr each="{cemetry in cemeteries()}"> <td> <a href="#cemeteries/deamons/{cemetry.deamon_id}">{cemetry.deamon_name_short}</a> </td> <td nowrap> <a href="#cemeteries/impures/{cemetry.impure_id}"> {cemetry.impure_id} </a> </td> <td>{cemetry.impure_name}</td> <td>{dt(cemetry.impure_finished_at)}</td> <td style="text-align: right;">{cemetry.purge_count}</td> <td style="text-align: right;">{cemetry.elapsed_time}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.cemeteries = () => {
         return opts.data.sort((a, b) => {
             return (a.impure_finished_at < b.impure_finished_at) ? 1 : -1;
         });
     };
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

riot.tag2('cemetery_page', '<section class="section"> <div class="container"> <div> <cemetery_page_filter style="margin-bottom:22px;" from="{from}" to="{to}" callback="{callback}"></cemetery_page_filter> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">日別推移</h1> <div style="padding-bottom:22px;"> <cemetery-daily-list source="{daily}"></cemetery-daily-list> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">明細</h1> <div style="padding-bottom:22px;"> <cemetery-list data="{cemeteries}"></cemetery-list> </div> </div> </section>', 'cemetery_page { height: 100%; display: block; overflow: scroll; }', 'class="page-contents"', function(opts) {
     this.from = moment().add(-7, 'd').startOf('day');
     this.to   = moment().add(1,  'd').startOf('day');
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

     this.cemeteries = [];
     this.daily      = [];
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-DONE-IMPURES')
             this.update();

         if (action.type=='FETCHED-PAGES-CEMETERIES') {
             this.cemeteries = action.response.cemeteries;
             this.daily      = action.response.daily;

             this.update();
         }
     });

     this.on('mount', () => {
         ACTIONS.fetchDoneImpures(this.from, this.to);
         ACTIONS.fetchPagesCemeteries(this.from, this.to);
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

riot.tag2('menu-bar', '<aside class="menu"> <p ref="brand" class="menu-label" onclick="{clickBrand}"> {opts.brand.label} </p> <ul class="menu-list"> <li each="{opts.site.pages}"> <a class="{opts.site.active_page==code ? \'is-active\' : \'\'}" href="{\'#\' + code}"> {menu_label} </a> </li> </ul> </aside> <div class="move-page-menu hide" ref="move-panel"> <p each="{moves()}"> <a href="{href}">{label}</a> </p> </div>', 'menu-bar .move-page-menu { z-index: 666665; background: #ffffff; position: fixed; left: 55px; top: 0px; min-width: 111px; height: 100vh; box-shadow: 2px 0px 8px 0px #e0e0e0; text-shadow: 0px 0px 11px rgb(254, 242, 99); padding: 22px 55px 22px 22px; } menu-bar .move-page-menu.hide { display: none; } menu-bar .move-page-menu > p { margin-bottom: 11px; } menu-bar > .menu { z-index: 666666; height: 100vh; width: 55px; padding: 11px 0px 11px 11px; position: fixed; left: 0px; top: 0px; background: rgb(254, 242, 99); } menu-bar .menu-label, menu-bar .menu-list a { padding: 0; width: 33px; height: 33px; margin-top: 8px; padding-top: 7px; border-radius: 3px; background: none; color: #333333; text-align: center; text-shadow: 0px 0px 11px #ffffff; font-size: 14px; font-weight: bold; } menu-bar .menu-label,[data-is="menu-bar"] .menu-label{ background: #ffffff; color: #333333; } menu-bar .menu-label.open,[data-is="menu-bar"] .menu-label.open{ background: #ffffff; color: rgb(254, 242, 99); width: 44px; border-radius: 3px 0px 0px 3px; text-shadow: 0px 0px 1px #eee; padding-right: 11px; } menu-bar .menu-list a:hover { width: 44px; border-radius: 5px 0px 0px 5px; background: #ffffff; } menu-bar .menu-list a.is-active { width: 55px; border-radius: 5px 0px 0px 5px; background: #ffffff; color: #333333; }', '', function(opts) {
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

riot.tag2('message-area', '<message-item each="{msg in messages()}" data="{msg}" callback="{callback}"></message-item>', 'message-area { position: fixed; right: 22px; top: calc(22px + 49px - 11px); z-index: 666666; } message-area > message-item { margin-bottom: 11px; } message-area > message-item:last-child { margin-bottom: 0px; }', '', function(opts) {
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

riot.tag2('message-item', '<article class="message hw-box-shadow is-{opts.data.type}"> <div class="message-header" style="padding:8px;"> <p class="is-small" style="font-size:12px;">{opts.data.title}</p> <button class="delete" aria-label="delete" onclick="{clickCloseButton}"></button> </div> <div class="message-body" style="padding: 8px;"> <div class="contents" style="overflow: auto;"> <p each="{txt in contents()}" class="is-small" style="font-size:12px;">{txt}</p> </div> </div> </article>', 'message-item > .message{ min-height: calc(46px + 44px); min-width: 111px; max-height: 222px; max-width: 333px; } message-item { display: block; }', '', function(opts) {
     this.contents = () => {
         if (!opts.data || !opts.data.contents)
             return [];

         return opts.data.contents.split('\n');
     };
     this.clickCloseButton = () => {
         this.opts.callback('close-message', this.opts.data);
     };
});

riot.tag2('page-tabs', '<div class="tabs is-{type()}"> <ul> <li each="{opts.core.tabs}" class="{opts.core.active_tab==code ? \'is-active\' : \'\'}"> <a code="{code}" onclick="{clickTab}">{label}</a> </li> </ul> </div>', 'page-tabs .is-boxed li:first-child { margin-left: 22px; } page-tabs .is-toggle li a { background: #ffffff; } page-tabs .tabs.is-toggle li.is-active a { background-color: RGB(254, 242, 99); border-color: RGB(254, 242, 99); font-weight: bold; }', '', function(opts) {
     this.clickTab = (e) => {
         let code = e.target.getAttribute('code');
         this.opts.callback(e, 'CLICK-TAB', { code: code });
     };
     this.type = () => {
         return this.opts.type ? this.opts.type : 'boxed';
     };
});

riot.tag2('section-breadcrumb', '<nav class="breadcrumb" aria-label="breadcrumbs"> <ul> <li each="{path()}" class="{active ? \'is-active\' : \'\'}"> <a href="{href}" aria-current="page">{label}</a> </li> </ul> </nav>', 'section-breadcrumb .breadcrumb a { font-weight: bold; text-shadow: 0px 0px 22px #ffffff; color: rgba(254, 242, 1); } section-breadcrumb .breadcrumb a:hover { text-shadow: 0px 0px 22px #333333; color: #ffffff; } section-breadcrumb .breadcrumb li.is-active a { color: #ffffff; text-shadow: 0px 0px 22px rgba(254, 242, 1); }', '', function(opts) {
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

riot.tag2('description-markdown', '<p> <pre ref="markdown-html" style=" background: none;"></pre> </p>', '', '', function(opts) {
     this.on('update', () => {
         this.refs['markdown-html'].innerHTML = '';
     });
     this.on('updated', () => {
         if (!this.opts.source)
             return;

         let html = marked(this.opts.source);

         this.refs['markdown-html'].innerHTML = html;
     });
});

riot.tag2('hw-page-header', '<section class="section" style="padding-bottom: 22px;"> <div class="container"> <h1 class="title hw-text-white">{opts.title}</h1> <h2 class="subtitle hw-text-white"> <p>{opts.subtitle}</p> <section-breadcrumb class="{isHide()}"></section-breadcrumb> </h2> </div> </section>', '', '', function(opts) {
     this.isHide = () => {
         if (!this.opts || !this.opts.type)
             return 'hide';
         dump(this.opts.type);
         if (this.opts.type=='child')
             return '';

         return 'hide';
     };
});

riot.tag2('hw-section-subtitle', '<h2 class="subtitle hw-text-white">{opts.contents}</h2>', '', '', function(opts) {
});

riot.tag2('hw-section-title', '<h1 class="title hw-text-white is-{opts.lev ? opts.lev : 3}">{opts.title}</h1>', '', '', function(opts) {
});

riot.tag2('menu-add-impure', '<div style="position:fixed; right: 33px; top: 22px; "> <button class="button add-impure is-small hw-button" onclick="{clickButton}">add Impure</button> </div>', '', '', function(opts) {
     this.maledict = () => {
         let maledict = STORE.get('maledicts.list').find((d) => {
             return d['maledict-type'].NAME == 'In Box';
         });

         return maledict
     };
     this.clickButton = () => {
         ACTIONS.openModalCreateImpure(this.maledict());
     };
});

riot.tag2('modal-change-deamon-area', '<h1 class="title is-4">Deamons</h1> <p class="control has-icons-left has-icons-right"> <input class="input is-small" type="text" placeholder="Search" onkeyup="{keyUp}"> <span class="icon is-small is-left"> <i class="fas fa-search"></i> </span> </p> <div> <button each="{deamon in deamons()}" class="button is-small deamon-item" deamon-id="{deamon.id}" onclick="{clickDeamon}"> {deamon.name} ({deamon.name_short}) </button> </div>', '', '', function(opts) {
     this.clickDeamon = (e) => {
         let deamon_id = e.target.getAttribute('deamon-id');

         this.opts.callback('choose-deamon', { id: deamon_id });
     };

     this.filter = null;

     this.keyUp = (e) => {
         let str = e.target.value;

         if (str.length==0)
             this.filter = null;
         else
             this.filter = str

         this.update();
     };

     this.deamons = () => {
         let filter = this.filter;
         let deamons = STORE.get('deamons.list');

         if (!this.filter)
             return deamons

         filter = filter.toLowerCase();

         let out = deamons.filter((d) => {

             return (d.id + '').toLowerCase().indexOf(filter) >= 0
                 || d.name.toLowerCase().indexOf(filter) >= 0
                 || d.name_short.toLowerCase().indexOf(filter) >= 0
         });

         return out;
     };
});

riot.tag2('modal-change-deamon-impure-area', '<div class="root-container"> <h1 class="title is-4">Impure</h1> <div class="basic-info-area" style="font-size:12px;"> <p>{val(\'impure_name\')} (ID: {val(\'impure_id\')})</p> <p style="background:#fff; flex-grow: 1; overflow: auto;"> <description-markdown source="{val(\'impure_description\')}"></description-markdown> </p> </div> <div class="deamon-area"> <h1 class="title is-6" style="margin-bottom: 8px;">Deamon</h1> <div style="padding-left:11px;"> <p>{val(\'impure_deamon\')}</p> <button class="button is-small deamon-item {impureDeamon() ? \'\' : \'hide\'}" onclick="{clickRemove}"> 削除 </button> </div> </div> </div>', 'modal-change-deamon-impure-area .root-container { height: 100%; display: flex; flex-direction: column; } modal-change-deamon-impure-area .basic-info-area { padding-left:11px; flex-grow: 1; display: flex; flex-direction: column; } modal-change-deamon-impure-area .deamon-area { height:99px; margin-top:11px; }', '', function(opts) {
     this.clickRemove = (e) => {
         this.opts.callback('remove-deamon');
     }

     this.val = (name) => {
         if (!this.opts.source)
             return '';

         if ('impure_deamon'!=name)
             return this.opts.source[name];

         let deamon = this.opts.choosed_deamon;

         if (!deamon || deamon.id===null)
             return 'なし';

         return deamon.name + ' (ID:' + deamon.id + ')';
     };
     this.impureDeamon = () => {
         if (!this.opts.source)
             return null;

         let deamon = this.opts.choosed_deamon;

         if (!deamon || deamon.id===null)
             return null;

         return deamon;
     };
     this.deamons = () => {
         return STORE.get('deamons.list');
     };
});

riot.tag2('modal-change-deamon', '<div class="modal {isOpen()}"> <div class="modal-background"></div> <div class="modal-content" style="width:888px;"> <div class="card"> <header class="card-header"> <p class="card-header-title"> Change Deamon <span style="margin-left: 22px; color: #f00; font-weight:bold;">注意: 実装中</span> </p> </header> <div class="card-content"> <div class="content"> <div class="flex-contener"> <div class="choose-demaon-area"> <modal-change-deamon-area source="{opts.source}" callback="{callback}"></modal-change-deamon-area> </div> <div class="view-impure-area"> <modal-change-deamon-impure-area source="{opts.source}" choosed_deamon="{choosed_deamon}" callback="{callback}"></modal-change-deamon-impure-area> </div> </div> <div class="control-area"> <button class="button is-small" onclick="{clickCancel}">Cancel</button> <button class="button is-small is-danger" onclick="{clickSave}" disabled="{isDisabled()}">Save</button> </div> </div> </div> </div> </div> <button class="modal-close is-large" aria-label="close" onclick="{clickCancel}"></button> </div>', 'modal-change-deamon .flex-contener { display:flex; height:555px; } modal-change-deamon .choose-demaon-area { flex-grow: 1; padding: 11px; width: 211px; } modal-change-deamon .choose-demaon-area .deamon-item { margin-left: 11px; margin-bottom: 11px; } modal-change-deamon .view-impure-area { flex-grow: 1; padding: 11px; background: rgba(254, 242, 100, 0.08); border-radius: 8px; box-shadow: 0px 0px 22px rgba(254, 242, 100, 0.08); width: 222px; display: flex; flex-direction: column; } modal-change-deamon modal-change-deamon-impure-area { height: 100%; } modal-change-deamon .control-area { display: flex; justify-content: space-between; margin-top: 11px; }', '', function(opts) {
     this.isOpen = () => {
         return this.opts.source ? 'is-active' : '';
     };
     this.isDisabled = () => {
         if (!this.opts.source)
             return 'disabled';

         if (this.choosed_deamon.id == this.opts.source.deamon_id)
             return 'disabled';

         return '';
     };

     this.choosed_deamon = null;
     this.on('update', () => {
         if (!this.opts.source)
             return;

         if (!this.choosed_deamon) {
             let id = this.opts.source.deamon_id;

             if (!id)
                 this.choosed_deamon = { id: null };
             else
                 this.choosed_deamon = STORE.get('deamons.ht')[id];
         }
     });

     this.callback = (action, data) => {
         if (action=='choose-deamon') {
             let deamons = STORE.get('deamons.ht');

             this.choosed_deamon = deamons[data.id];

             if (!this.choosed_deamon)
                 this.choosed_deamon = { id: null };

             this.update();

             return;
         }
         if (action=='remove-deamon') {
             this.choosed_deamon = { id: null };

             this.update();

             return;
         }
     };
     this.clickCancel = () => {
         this.opts.callback('close-modal-change-deamon');
     };
     this.clickSave = () => {
         let impure = { id: this.opts.source.impure_id };
         let deamon = this.choosed_deamon;

         ACTIONS.setImpureDeamon(impure, deamon);
     };
});

riot.tag2('modal-create-after-impure', '<div class="modal {opts.impure ? \'is-active\' : \'\'}"> <div class="modal-background"></div> <div class="modal-card" style="width:999px;"> <header class="modal-card-head" style="padding: 11px 22px;"> <p class="modal-card-title" style="font-size:16px;">後続の Impure を作成</p> <button class="delete" aria-label="close" onclick="{clickCloseButton}"></button> </header> <section class="modal-card-body" style="display:flex;"> <div style="flex-grow:1;"> <input class="input is-small" type="text" placeholder="Title" ref="name"> <textarea class="textarea is-small" placeholder="Description" rows="6" style="margin-top:11px; height: 333px;" ref="description"></textarea> <h1 class="title is-6" style="margin-bottom: 3px; margin-top:11px;">Deamon:</h1> <div style="margin-left:11px;"> <p style="margin-bottom:11px;">なし</p> <input class="input is-small" type="text" placeholder="Search Deamon" ref="name"> <div style="margin-top:11px;"> <button class="button is-small">Deamon 1</button> <button class="button is-small">Deamon 2</button> <button class="button is-small">Deamon 3</button> </div> </div> </div> <div style="padding-left: 22px; padding-right: 22px; display:flex; flex-direction: column; justify-content: center;;"> <h1 class="title is-6">Copy</h1> <button class="button is-small">←</button> </div> <div style="flex-grow:1;padding: 11px;background: #eeeeee;border-radius: 3px;"> <h1 class="title is-6" style="margin-bottom: 3px;">Title:</h1> <p style="padding-left:11px;">title ....</p> <h1 class="title is-6" style="margin-bottom: 3px; margin-top: 11px;">description:</h1> <p style="padding-left:11px;">markdon -> html ....</p> <h1 class="title is-6" style="margin-bottom: 3px; margin-top: 11px;">Deamon:</h1> <p style="padding-left:11px;">Deamon...</p> </div> </section> <footer class="modal-card-foot" style="padding: 11px 22px; display: flex; justify-content: space-between;"> <button class="button is-small" onclick="{clickCloseButton}">Cancel</button> <button class="button is-small is-success" onclick="{clickCreateButton}">Create!</button> </footer> </div> </div>', '', '', function(opts) {
     this.maledict = null;
     STORE.subscribe((action) => {
         if (action.type=='OPEN-MODAL-CREATE-IMPURE') {
             this.maledict = action.maledict;
             this.update();

             return;
         }

         if (action.type=='CLOSE-MODAL-CREATE-IMPURE') {
             this.maledict = null;
             this.update();

             return;
         }

         if (action.type=='CREATED-MALEDICT-IMPURE') {
             this.maledict = null;
             this.update();

             return;
         }
     });

     this.maledictName = () => {
         return this.maledict ? this.maledict.name : '';
     }

     this.clickCreateButton = (e) => {
         ACTIONS.createMaledictImpure (this.maledict, {
             name: this.refs['name'].value,
             description: this.refs['description'].value,
             maledict: this.opts.maledict
         });
     };
     this.clickCloseButton = (e) => {
         ACTIONS.closeModalCreateImpure();
     };
});

riot.tag2('modal-create-impure', '<div class="modal {maledict ? \'is-active\' : \'\'}"> <div class="modal-background"></div> <div class="modal-card"> <header class="modal-card-head"> <p class="modal-card-title">やる事を追加</p> <button class="delete" aria-label="close" onclick="{clickCloseButton}"></button> </header> <section class="modal-card-body"> <h4 class="title is-6">場所: {maledictName()}</h4> <div> <span>接頭文字:</span> <button each="{prefixes}" class="button is-small" style="margin-left: 8px;" onclick="{clickTitlePrefix}" riot-value="{label}">{label}</button> </div> <input class="input" type="text" placeholder="Title" ref="name" style="margin-top:11px;"> <textarea class="textarea" placeholder="Description" rows="6" style="margin-top:11px;" ref="description"></textarea> </section> <footer class="modal-card-foot"> <button class="button" onclick="{clickCloseButton}">Cancel</button> <button class="button is-success" onclick="{clickCreateButton}">Create!</button> </footer> </div> </div>', '', '', function(opts) {
     this.maledict = null;
     STORE.subscribe((action) => {
         if (action.type=='OPEN-MODAL-CREATE-IMPURE') {
             this.maledict = action.maledict;
             this.update();

             return;
         }

         if (action.type=='CLOSE-MODAL-CREATE-IMPURE') {
             this.maledict = null;
             this.update();

             return;
         }

         if (action.type=='CREATED-MALEDICT-IMPURE') {
             this.maledict = null;
             this.update();

             return;
         }
     });

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
         return this.maledict ? this.maledict.name : '';
     }

     this.clickCreateButton = (e) => {
         ACTIONS.createMaledictImpure (this.maledict, {
             name: this.refs['name'].value,
             description: this.refs['description'].value,
             maledict: this.opts.maledict
         });
     };
     this.clickCloseButton = (e) => {
         ACTIONS.closeModalCreateImpure();
     };
});

riot.tag2('modal-purge-result-editor', '<div class="modal {opts.data ? \'is-active\' : \'\'}"> <div class="modal-background"></div> <div class="modal-card"> <header class="modal-card-head" style="padding: 11px 22px; font-size: 18px;"> <p class="modal-card-title">作業時間の変更</p> <button class="delete" aria-label="close" action="close-purge-result-editor" onclick="{clickButton}"></button> </header> <section class="modal-card-body"> <div class="field is-horizontal"> <div class="field-label is-normal"> <label class="label">Impure</label> </div> <div class="field-body"> <div class="field"> <p class="control"> <input class="input is-static" type="text" riot-value="{getVal(\'impure_name\')}" readonly> </p> </div> </div> </div> <div class="field is-horizontal"> <div class="field-label is-normal"> <label class="label">作業時間</label> </div> <div class="field-body"> <div class="field"> <p class="control"> <input class="input is-static" type="text" riot-value="{getVal(\'elapsed_time\')}" readonly> </p> </div> </div> </div> <div class="field is-horizontal"> <div class="field-label is-normal"> <label class="label">開始</label> </div> <div class="field-body"> <div class="field"> <p class="control"> <input class="input" riot-value="{date2str(getVal(\'purge_start\'))}" ref="start" type="{\'datetime\'}"> </p> <div style="padding-top: 5px;"> <button class="button is-small" action="now" onclick="{clickSetDate}">今</button> <button class="button is-small {isHide(\'before-end\')}" action="before-end" onclick="{clickSetDate}">前の作業の終了</button> <button class="button is-small" action="clear-under-hour" onclick="{clickSetDate}">分と秒をクリア</button> <button class="button is-small" action="clear-under-minute" onclick="{clickSetDate}">秒をクリア</button> <button class="button is-small is-warging" action="revert-start" onclick="{clickSetDate}">元に戻す</button> </div> </div> </div> </div> <div class="field is-horizontal"> <div class="field-label is-normal"> <label class="label">終了</label> </div> <div class="field-body"> <div class="field"> <p class="control"> <input class="input" riot-value="{date2str(getVal(\'purge_end\'))}" ref="end" type="{\'datetime\'}"> <div style="padding-top: 5px;"> <button class="button is-small" action="now" onclick="{clickSetDate}">今</button> <button class="button is-small {isHide(\'after-start\')}" action="after-start" onclick="{clickSetDate}">後の作業の開始</button> <button class="button is-small" action="clear-under-hour" onclick="{clickSetDate}">分と秒をクリア</button> <button class="button is-small" action="clear-under-minute" onclick="{clickSetDate}">秒をクリア</button> <button class="button is-small is-warging" action="revert-end" onclick="{clickSetDate}">元に戻す</button> </div> </p> </div> </div> </div> </section> <footer class="modal-card-foot" style="padding: 11px 22px; display:flex; justify-content: space-between;"> <button class="button is-small" action="close-purge-result-editor" onclick="{clickButton}">Cancel</button> <button class="button is-small is-success" action="save-purge-result-editor" onclick="{clickButton}">Save</button> </footer> </div> </div>', '', '', function(opts) {
     this.clickButton = (e) => {
         let action = e.target.getAttribute('action');

         if (action != 'save-purge-result-editor') {
             this.opts.callback(action);
             return;
         }

         let stripper = new TimeStripper();

         this.opts.callback(action, {
             id: this.opts.data.purge_id,
             start: stripper.str2date(this.refs.start.value),
             end: stripper.str2date(this.refs.end.value)
         })
     };
     this.clickSetDate = (e) => {
         let target = e.target;

         let input = target.parentNode.parentNode.firstElementChild.firstElementChild;
         let action = target.getAttribute('action');

         let value = () => {
             if (action=='now')
                 return moment();

             if (action=='after-start')
                 return this.opts.source.after_start;

             if (action=='before-end')
                 return this.opts.source.before_end;

             if (action=='revert-start')
                 return this.opts.data.purge_start;

             if (action=='revert-end') {
                 return this.opts.data.purge_end;
             }

             if (action=='clear-under-hour')
                 return moment(input.value).startOf('hour');

             if (action=='clear-under-minute')
                 return moment(input.value).startOf('minute');

             throw Error('Not Supported yet. action=' + action) ;
         };

         input.value = moment(value()).format('YYYY-MM-DD HH:mm:ss');
     };

     this.isHide = (code) => {
         if (code=='after-start')
             return this.opts.source.after_start ? '' : 'hide';

         if (code=='before-end')
             return this.opts.source.before_end ? '' : 'hide';
     };
     this.getVal = (key) => {
         let data = this.opts.data;

         if (!data)
             return '';

         if (key=='elapsed_time')
             return new TimeStripper().format_sec(data[key]);

         return data[key];
     };
     this.date2str = (date) => {
         if (!date) return '';

         return moment(date).format("YYYY-MM-DD HH:mm:ss");
     };
});

riot.tag2('popup-working-action', '<button class="button is-small hw-button" style="margin-right:11px;" onclick="{clickStop}">Stop</button> <span style="font-size:12px;">{name()}</span> <div style="margin-top: 8px;"> <p style="display:inline; font-size:12px; margin-right:22px;"> <span style="font-size:12px;width:88px;display:inline-block;">経過: {distance()}</span> <span style="font-size:12px;">開始: </span> <span style="font-size:12px;">{start()}</span> </p> <button class="button is-small hw-button" onclick="{clickStopAndClose}">Stop & Close</button> </div>', 'popup-working-action { display: block; position: fixed; bottom: 33px; right: 33px; background: #fff; padding: 11px 22px; border: 1px solid #ededed; border-radius: 8px; box-shadow: 0px 0px 22px rgba(254, 242, 99, 0.666); } popup-working-action .hw-button { background: #fff; box-shadow: none; }', 'class="{hide()}"', function(opts) {

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

riot.tag2('deamon-page', '<section class="section" style="padding-bottom: 22px;"> <div class="container"> <h1 class="title hw-text-white">悪魔</h1> <h2 class="subtitle hw-text-white"> <section-breadcrumb></section-breadcrumb> </h2> </div> </section>', '', '', function(opts) {
});

riot.tag2('deamons-page', '<section class="section" style="padding-top: 22px;"> <div class="container"> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white"></h1> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow"> <thead> <tr> <th>ID</th> <th>Name</th> <th>Name(Short)</th> </tr> </thead> <tbody> <tr each="{deamon in deamons()}"> <td><a href="{idLink(deamon)}">{deamon.id}</a></td> <td>{deamon.name}</td> <td>{deamon.name_short}</td> </tr> </tbody> </table> </div> </div> </section> </div> </section>', '', 'class="page-contents"', function(opts) {
     this.idLink = (deamon) => {
         return '#deamons/' + deamon.id;
     };
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

riot.tag2('exorcist-page', '<section class="section" style="padding-bottom: 22px;"> <div class="container"> <h1 class="title hw-text-white">祓魔師</h1> <h2 class="subtitle hw-text-white"> <section-breadcrumb></section-breadcrumb> </h2> </div> </section>', '', 'class="page-contents"', function(opts) {
});

riot.tag2('help_page', '<section class="section"> <div class="container"> <h2 class="subtitle hw-text-white">ヘルプ的ななにか</h2> <div class="contents hw-text-white"> <p>準備中</p> </div> </div> </section>', '', 'class="page-contents"', function(opts) {
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
         if (action.type=='FETCHED-MALEDICT-IMPURES') {
             this.update();

             return;
         }

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

riot.tag2('home_maledicts', '<nav class="panel hw-box-shadow"> <p class="panel-heading">Maledicts</p> <a each="{data()}" class="panel-block {isActive(id)}" onclick="{clickItem}" maledict-id="{id}" style="padding: 5px 8px;"> <span style="width:120px; font-size:11px;" maledict-id="{id}"> {name} </span> <span class="operators" style="font-size:14px;"> <span class="icon" title="ここに「やること」を追加する。" maledict-id="{id}" maledict-name="{name}" onclick="{clickAddButton}"> <i class="far fa-plus-square" maledict-id="{id}"></i> </span> <span class="move-door {dragging ? \'open\' : \'close\'}" ref="move-door" dragover="{dragover}" drop="{drop}"> <span class="icon closed-door"> <i class="fas fa-door-closed"></i> </span> <span class="icon opened-door" maledict-id="{id}"> <i class="fas fa-door-open" maledict-id="{id}"></i> </span> </span> </span> </a> <a class="panel-block" style="padding: 5px 8px; height:35px;"> <span style="width:120px; font-size:11px;" maledict-id="{id}">Waiting for ... (実装中)</span> </a> </nav>', 'home_maledicts > .panel { width: 188px; border-radius: 4px 4px 0 0; } home_maledicts > .panel > .panel-heading{ font-size:12px; font-weight:bold; } home_maledicts .panel-block { background:#fff; } home_maledicts .panel-block:hover { background:rgb(255, 255, 236); } home_maledicts .panel-block.is-active { background:rgb(254, 242, 99); } home_maledicts .panel-block.is-active { border-left-color: rgb(254, 224, 0); } home_maledicts .move-door.close .opened-door { display: none; } home_maledicts .move-door.open .closed-door { display: none; } home_maledicts .operators { width: 53px; } home_maledicts .operators .icon { color: #cccccc; } home_maledicts .operators .icon:hover { color: #880000; } home_maledicts .operators .move-door.open .icon { color: #880000; }', '', function(opts) {
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

riot.tag2('home_page', '<div class="bucket-area"> <home_maledicts data="{STORE.get(\'maledicts\')}" select="{maledict()}" callback="{callback}" dragging="{dragging}"></home_maledicts> <home_orthodox-angels></home_orthodox-angels> <home_other-services></home_other-services> </div> <div class="contetns-area"> <div style="display:flex;"> <home_squeeze-area callback="{callback}"></home_squeeze-area> <home_request-area></home_request-area> </div> <home_impures maledict="{maledict()}" callback="{callback}" filter="{squeeze_word}"></home_impures> <home_servie-items></home_servie-items> </div> <home_modal-create-impure open="{modal_open}" callback="{callback}" maledict="{modal_maledict}"></home_modal-create-impure> <modal_request-impure source="{request_impure}"></modal_request-impure>', 'home_page { height: 100%; width: 100%; padding: 22px 0px 0px 22px; display: flex; } home_page > .contetns-area { height: 100%; margin-left: 11px; flex-grow: 1; } home_page home_squeeze-area { margin-right: 55px; }', '', function(opts) {
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
         if ('open-modal-create-impure'==action) {
             let maledict = data;

             ACTIONS.openModalCreateImpure(maledict);
         }

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

         if (action.type=='CREATED-MALEDICT-IMPURE') {
             let maledict_selected = this.maledict();

             if (action.maledict.id == maledict_selected.id)
                 ACTIONS.fetchMaledictImpures(maledict_selected.id);
         }

         if (action.type=='FETCHED-MALEDICTS')
             this.update();

         if (action.type=='START-TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = action.contents;
             this.update();

         }

         if (action.type=='STOP-TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = null;
             this.update();

         }

         if (action.type=='TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = null;

             if (this.tags['modal_request-impure'])
                 this.tags['modal_request-impure'].update();
             else
                 this.update();
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

         this.update();
     };
});

riot.tag2('home_request-area', '<p class="{isHide()}"> 依頼メッセージ未読: <a href="#home/requests"><span class="count">{count()}</span></a> 件 </p>', 'home_request-area > p { color: #fff; font-weight: bold; font-size: 14px; line-height: 38px; } home_request-area .count { color: #f00; font-size: 21px; }', '', function(opts) {
     this.isHide = () => {
         return this.count()==0 ? 'hide' : '';
     };
     this.count = () => {
         let list = STORE.get('requests.messages.unread.list');

         if (!list)
             return 0;

         return list.length;
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

riot.tag2('impure-card-footer', '<footer class="card-footer" style="font-size:14px; height:33px;"> <span class="card-footer-item action {opts.status}" action="{startStopAction()}" onclick="{clickButton}">{startStopLabel()}</span> <span class="card-footer-item view" action="move-2-view" onclick="{clickButton}">照会</span> <span class="card-footer-item open" action="{changeSizeAction()}" onclick="{clickButton}">{changeSizeLabel()}</span> </footer>', 'impure-card-footer .action.start { border-radius: 0px 0px 0px 5px; background-color: #FEF264; } impure-card-footer .action.start:hover { font-weight: bold; }', '', function(opts) {
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
         {code: 'incantation',  label: '呪文',           tag: 'impure-card-large_tab_incantation' },
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

riot.tag2('impure-card-large_tab_create-after', '<div class="form-contents"> <div class="left"> <input class="input is-small" type="text" placeholder="Title" ref="name" onkeyup="{keyUpTitle}"> <textarea class="textarea is-small" placeholder="Description" rows="6" style="margin-top:11px; flex-grow:1;" ref="description"></textarea> </div> <div class="right"> <button class="button is-small" onclick="{clickReset}">Set Contents</button> <button class="button is-small" onclick="{clickClear}">Clear</button> <span style="flex-grow:1;"></span> <button class="button is-small is-success" onclick="{clickCreate}" disabled="{isDisable()}">Create!</button> </div> </div>', 'impure-card-large_tab_create-after .form-contents { display:flex; width:100%; height:100%; } impure-card-large_tab_create-after .form-contents > .left { flex-grow:1; display:flex; flex-direction:column; } impure-card-large_tab_create-after .form-contents > .right{ padding-left:8px; display:flex; flex-direction: column; } impure-card-large_tab_create-after .form-contents > .right > * { margin-bottom: 8px; }', '', function(opts) {
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
         if (!this.refs.name || !this.refs.description) {
             console.wan('TODO: なんで refs がないん？');
             console.wan(this.refs);
         } else {
             this.refs.name.value = '';
             this.refs.description.value = '';
         }

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

riot.tag2('impure-card-large_tab_incantation', '<div class="form-contents"> <div class="left"> <textarea class="textarea is-small" placeholder="作業中のメモなどを入力してください。 ※準備中" style="width:100%; height:100%;" ref="spell"></textarea> </div> <div class="right"> <a class="button is-small" action="finishe-impure" onclick="{clickClearButton}">Clear</a> <span style="flex-grow:1;"></span> <a class="button is-small is-danger" action="incantation" onclick="{clickIncantationButton}">詠唱</a> </div> </div>', 'impure-card-large_tab_incantation .form-contents { display:flex; width:100%; height:100%; } impure-card-large_tab_incantation .form-contents > .left { flex-grow:1; width:100%; height:100%; } impure-card-large_tab_incantation .form-contents > .right{ padding-left:8px; display:flex; flex-direction: column; }', '', function(opts) {
     this.clickClearButton = (e) => {
         this.refs.spell.value = '';
     }
     this.clickIncantationButton = (e) => {
         let target = e.target;
         let spell = this.refs.spell.value.trim();

         this.opts.callback(target.getAttribute('action'), { spell: spell });
     };
     STORE.subscribe((action) => {
         if (action.type=='SAVED-IMPURE-INCANTATION-SOLO')
             if (this.opts.data.id==action.impure.id)
                 this.clickClearButton();
     });
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

         if ('incantation'==action)
             ACTIONS.saveImpureIncantationSolo(this.opts.data, data.spell);
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

riot.tag2('home_orthodox-angels', '<nav class="panel hw-box-shadow"> <p class="panel-heading">Exorcists</p> <a class="panel-block"> <orthodox-doropdown></orthodox-doropdown> </a> <a each="{obj in data()}" class="panel-block" angel-id="{obj.id}" style="padding:5px 8px;"> <span style="width:100%;font-size:11px;;" maledict-id="{obj.id}"> {obj.name} </span> <home_emergency-door source="{obj}"></home_emergency-door> </a> </nav>', 'home_orthodox-angels > .panel { width: 188px; margin-top: 22px; border-radius: 4px 4px 0 0; } home_orthodox-angels > .panel > a { background: #ffffff; } home_orthodox-angels > .panel > .panel-heading { font-size:12px; font-weight: bold; } home_orthodox-angels .panel-block:hover { background:rgb(255, 255, 236); } home_orthodox-angels .panel-block.is-active { border-left-color: rgb(254, 224, 0); }', '', function(opts) {
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

riot.tag2('service-card-small', '<div class="card hw-box-shadow"> <header class="card-header"> <p class="card-header-title"> Gitlab &nbsp; <a href="{url()}" target="_blank">Issues</a> </p> </header> <div class="card-content"> <div class="content" style="font-size:14px;"> <p style="word-break: break-all;">{name()}</p> </div> </div> <footer class="card-footer"> <a class="card-footer-item" href="{assignee_url()}" taget="_blank"> {assignee_name()} </a> </footer> </div>', 'service-card-small > .card { width: 222px; height: 222px; float: left; margin-left: 22px; margin-top: 1px; margin-bottom: 22px; border: 1px solid #dddddd; border-radius: 5px; } service-card-small > .card .card-content{ height: calc(222px - 49px - 48px); padding: 11px 22px; overflow: auto; } service-card-small .panel-block:hover { background:rgb(255, 255, 236); } service-card-small .panel-block.is-active { background:rgb(254, 242, 99); } service-card-small .panel-block.is-active { border-left-color: rgb(254, 224, 0); }', '', function(opts) {
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

riot.tag2('impure_page-controller', '<div class="controller-container" style=""> <p>期間</p> <input class="input is-small" type="text" placeholder="YYYY-MM-DD"> <p>〜</p> <input class="input is-small" type="text" placeholder="YYYY-MM-DD"> <button class="button is-small" disabled>Refresh ※準備中</button> </div>', 'impure_page-controller > .controller-container { display:flex; background: #FEF264; padding: 11px 22px; border-radius: 3px; } impure_page-controller > .controller-container > * { margin-right: 11px; } impure_page-controller > .controller-container > p { font-weight: bold; } impure_page-controller > .controller-container > input.input { border-radius: 3px; width: 111px; }', '', function(opts) {
});

riot.tag2('impure_page-tabs', '<div class="tabs is-toggle"> <ul> <li class="is-active"> <a> <span>基本情報</span> </a> </li> <li> <a> <span>浄化履歴</span> </a> </li> <li> <a> <span>Impure の鎖</span> </a> </li> <li> <a> <span>依頼履歴</span> </a> </li> </ul> </div>', 'impure_page-tabs li > a { background: #fff; }', '', function(opts) {
});

riot.tag2('impure_page', '<section class="section" style="padding-bottom: 22px;"> <div class="container"> <h1 class="title hw-text-white">Impure</h1> <h2 class="subtitle hw-text-white"> <section-breadcrumb></section-breadcrumb> </h2> </div> </section> <section class="section" style="padding-top:22px; padding-bottom:22px;"> <div class="container"> <div class="contents"> <impure_page-controller></impure_page-controller> </div> </div> </section> <section class="section" style="padding-top:22px; padding-bottom:22px;"> <div class="container"> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> </div> </section> <div class="tab-contents-area"> <impure_page_tab-basic class="hide" source="{source.impure}"></impure_page_tab-basic> <impure_page_tab-purges class="hide" source="{source.purges}"></impure_page_tab-purges> <impure_page_tab-incantation class="hide" source="{source.spells}"></impure_page_tab-incantation> <impure_page_tab-requests class="hide" source="{source.requests}"></impure_page_tab-requests> <impure_page_tab-chains class="hide" source="{[]}"></impure_page_tab-chains> </div>', 'impure_page page-tabs li a{ background: #fff; } impure_page { width: 100%; height: 100%; display: block; overflow: auto; } impure_page .tabs ul { border-bottom-color: rgb(254, 242, 99); border-bottom-width: 2px; } impure_page .tabs.is-boxed li.is-active a { background-color: rgba(254, 242, 99, 1); border-color: rgb(254, 242, 99); text-shadow: 0px 0px 11px #fff; color: #333; font-weight: bold; } impure_page .tabs.is-boxed li { margin-left: 8px; } impure_page .tabs.is-boxed a { text-shadow: 0px 0px 8px #fff; font-weight: bold; }', '', function(opts) {
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
     this.source = {
         impure: null,
         purges: [],
         spells: [],
         requests: [],
     };

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-IMPURE') {
             this.source = action.response;

             this.update();
         }
     });
     this.on('mount', () => {
         let id = this.id();

         ACTIONS.fetchPagesImpure({ id: id });
         ACTIONS.fetchImpure(id);
     });
});

riot.tag2('impure_page_tab-basic', '<section class="section" style="padding-top: 22px; padding-bottom:22px;"> <div class="container"> <h1 class="title hw-text-white is-4">Name</h1> <div class="contents hw-text-white" style="font-weight:bold; padding-left:22px;"> <p>{name()}</p> </div> </div> </section> <section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white is-4">Description</h1> <div class="contents description" style="margin-left: 22px;"> <description-markdown source="{description()}"></description-markdown> </div> </div> </section>', 'impure_page_tab-basic .description { background: #fff; border-radius: 3px; line-height: 14px; }', '', function(opts) {
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

riot.tag2('impure_page_tab-incantation', '<section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white"></h1> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th rowspan="2">ID</th> <th rowspan="2" colspan="2">Date</th> <th colspan="2">祓魔師</th> <th rowspan="2">Spell</th> </tr> <tr> <th>ID</th> <th>Name</th> </tr> </thead> <tbody> <tr each="{rec in opts.source}"> <td>{rec.id}</td> <td>{dt(rec.incantation_at)}</td> <td>{week(rec.incantation_at)}</td> <td>{rec.angel_id}</td> <td>{rec.angel_name}</td> <td>{contents(rec.spell)}</td> </tbody> </table> </div> </div> </section>', '', '', function(opts) {
     let hw = new HolyWater();

     this.dt   = (v) => { return hw.str2yyyymmddhhmmss(v); };
     this.week = (v) => { return hw.str2week(v); };
     this.contents = (v) => { return hw.descriptionViewShort(v); };
});

riot.tag2('impure_page_tab-purges', '<section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white"></h1> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th colspan="6">Purge</th> <th colspan="2">祓魔師</th> </tr> <tr> <th>ID</th> <th colspan="2">Start</th> <th colspan="2">End</th> <th>Elapsed Time [s]</th> <th>ID</th> <th>Name</th> </tr> </thead> <tbody> <tr each="{rec in opts.source}"> <td>{rec.id}</td> <td>{dt(rec.start)}</td> <td>{week(rec.start)}</td> <td>{dt(rec.end)}</td> <td>{week(rec.end)}</td> <td style="text-align:right;">{time(rec.elapsed_time)}</td> <td>{rec.angel_id}</td> <td>{rec.angel_name}</td> </tr> </tbody> </table> </div> </div> </section>', '', '', function(opts) {
     let hw = new HolyWater();

     this.dt   = (v) => { return hw.str2yyyymmddhhmmss(v); };
     this.week = (v) => { return hw.str2week(v); };
     this.time = (v) => { return hw.int2hhmmss(v); };
});

riot.tag2('impure_page_tab-requests', '<section class="section" style="padding-top: 22px;"> <div class="container"> <h1 class="title hw-text-white"></h1> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th rowspan="2" colspan="2">Date</th> <th colspan="2">From</th> <th colspan="2">To</th> <th rowspan="2">Message</th> </tr> <tr> <th>ID</th> <th>Name</th> <th>ID</th> <th>Name</th> </tr> </thead> <tbody> <tr each="{rec in opts.source}" request-message-id="{rec.id}" angel-from-id="{rec.angel_from_id}" angel-to-id="{rec.angel_to_id}" impure-id="{rec.impure_id}"> <td> {dt(rec.messaged_at)} </td> <td> {week(rec.messaged_at)} </td> <td> {rec.angel_from_id} </td> <td>{rec.angel_from_name}</td> <td> {rec.angel_to_id} </td> <td>{rec.angel_to_name}</td> <td>{contents(rec.contents)}</td> </tr> </tbody> </table> </div> </div> </section>', '', '', function(opts) {
     let hw = new HolyWater();

     this.dt   = (v) => { return hw.str2yyyymmddhhmmss(v); };
     this.week = (v) => { return hw.str2week(v); };
     this.contents = (v) => { return hw.descriptionViewShort(v); };
});

riot.tag2('orthodox-page', '<hw-page-header title="正教会" type="child"></hw-page-header> <section class="section" style="padding-top: 11px; padding-bottom: 11px;"> <div class="container"> <page-tabs core="{page_tabs}" type="toggle" callback="{clickTab}"></page-tabs> </div> </section> <div> <orthodox-page_tab-basic class="hide"></orthodox-page_tab-basic> <orthodox-page_tab-members class="hide"></orthodox-page_tab-members> <orthodox-page_tab-paladin class="hide"></orthodox-page_tab-paladin> <orthodox-page_tab-primate class="hide"></orthodox-page_tab-primate> </div>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'basic',   label: '基本情報', tag: 'orthodox-page_tab-basic' },
         {code: 'members', label: '祓魔師',   tag: 'orthodox-page_tab-members' },
         {code: 'paladin', label: '聖騎士',   tag: 'orthodox-page_tab-paladin' },
         {code: 'primate', label: '首座主教', tag: 'orthodox-page_tab-primate' },
     ]);
     this.on('mount', () => {
         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };

     this.orthodox = () => {
         let id = location.hash.split('/').reverse()[0];

         return STORE.get('orthodoxs.ht.' + id);
     };

     ACTIONS.fetchPagesOrthodox(this.orthodox());
});

riot.tag2('orthodox-page_tab-basic', '<section class="section"> <div class="container"> <hw-section-title title="概要"></hw-section-title> <h2 class="subtitle"></h2> </div> </section> <section class="section"> <div class="container"> <hw-section-title title="組織"></hw-section-title> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th>役職</th> <th>概要</th> </tr> </thead> <tbody> <tr> <th>首座主教</th> <td>XXX, YYY, ZZZ</td> </tr> <tr> <th>聖騎士</th> <td>PPP</td> </tr> <tr> <th>祓魔師</th> <td> 9999 名</td> </tr> </tbody> </table> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('orthodox-page_tab-members', '<section class="section"> <div class="container"> <hw-section-title title="準備中。。。"></hw-section-title> <div class="contents"> <p>表示したり、追加したり。</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('orthodox-page_tab-paladin', '<section class="section"> <div class="container"> <hw-section-title title="準備中。。。"></hw-section-title> <div class="contents"> <p>表示したり、選出したり。</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('orthodox-page_tab-primate', '<section class="section"> <div class="container"> <hw-section-title title="準備中。。。"></hw-section-title> <div class="contents"> <p>表示したり、選出したり。</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('exorcists-list', '<table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow"> <thead> <tr> <th>ID</th> <th>Name</th> <th>Ghost ID</th> </tr> </thead> <tbody> <tr each="{exorcist in exorcists()}"> <td><a href="{idLink(exorcist)}">{exorcist.id}</a></td> <td>{exorcist.name}</td> <td>{exorcist.ghost_id}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.idLink = (exorcist) => {
         return '#orthodoxs/exorcists/' + exorcist.id;
     };
     this.exorcists = () => {
         return STORE.get('angels.list');
     };
});

riot.tag2('orthodox-list', '<table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow"> <thead> <tr> <th>ID</th> <th>Name</th> <th>Description</th> </tr> </thead> <tbody> <tr each="{orthodox in orthodoxs()}"> <td><a href="{idLink(orthodox)}">{orthodox.id}</a></td> <td>{orthodox.name}</td> <td>{orthodox.description}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.idLink = (orthodox) => {
         return '#orthodoxs/' + orthodox.id;
     };
     this.orthodoxs = () => {
         return STORE.get('orthodoxs.list');
     };
});

riot.tag2('orthodoxs-page', '<section class="section" style="padding-top: 55px; padding-bottom: 11px;"> <div class="container"> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> </div> </section> <div> <orthodoxs-page_tab-orthdoxs class="hide"></orthodoxs-page_tab-orthdoxs> <orthodoxs-page_tab-exorcists class="hide"></orthodoxs-page_tab-exorcists> </div>', 'orthodoxs-page { width: 100%; height: 100%; display: block; overflow: auto; } orthodoxs-page .tabs ul { border-bottom-color: rgb(254, 242, 99); border-bottom-width: 2px; } orthodoxs-page .tabs.is-boxed li.is-active a { background-color: rgba(254, 242, 99, 1); border-color: rgb(254, 242, 99); text-shadow: 0px 0px 11px #fff; color: #333; font-weight: bold; } orthodoxs-page .tabs.is-boxed a { text-shadow: 0px 0px 8px #fff; font-weight: bold; }', 'class="page-contents"', function(opts) {
     this.default_tag = 'home';
     this.active_tag = null;
     this.page_tabs = new PageTabs([
         {code: 'orthdoxs',  label: '正教会', tag: 'orthodoxs-page_tab-orthdoxs' },
         {code: 'exorcists', label: '祓魔師', tag: 'orthodoxs-page_tab-exorcists' },
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

riot.tag2('orthodoxs-page_tab-exorcists', '<section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white"></h1> <div class="contents hw-text-white"> <exorcists-list></exorcists-list> </div> </div> </section>', '', '', function(opts) {
     this.on('mount', () => {
         ACTIONS.fetchOrthodoxAllExorcists();
     });

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ORTHODOX-ALL-EXORCISTS')
             this.update();
     });
});

riot.tag2('orthodoxs-page_tab-orthdoxs', '<section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white"></h1> <div class="contents hw-text-white"> <orthodox-list></orthodox-list> </div> </div> </section>', '', '', function(opts) {
     this.on('mount', () => {
         ACTIONS.fetchOrthodoxs();
     });

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ORTHODOXS')
             this.tags['orthodox-list'].update();
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

riot.tag2('page-purges', '<div style="padding: 33px 88px 88px 88px;"> <div> <h1 class="title hw-text-white">期間</h1> <purges_page_filter style="margin-bottom:22px; padding-left:33px; padding-right:33px;" from="{from}" to="{to}" callback="{callback}"></purges_page_filter> </div> <div> <h1 class="title hw-text-white">Summary</h1> <div style="display:flex; padding-left:33px; padding-right:33px;"> <div style="margin-right: 88px;"> <purges_page_group-span source="{this.summary.deamons}"></purges_page_group-span> </div> <div> <purges_page_group-span-deamon source="{this.summary.deamons}"></purges_page_group-span-deamon> </div> </div> </div> <div style="margin-top:33px;"> <h1 class="title hw-text-white">Guntt Chart</h1> <div style="padding-left:33px; padding-right:33px;"> <purges_page_guntt-chart source="{purges}" from="{from}" to="{to}"></purges_page_guntt-chart> </div> </div> <div style="margin-top:33px;"> <h1 class="title hw-text-white">Purge hisotry</h1> <div style="display:flex; padding-left:33px; padding-right:33px;"> <purges-list source="{purges}" callback="{callback}"></purges-list> </div> </div> </div> <modal-purge-result-editor data="{edit_target}" source="{edit_data}" callback="{callback}"></modal-purge-result-editor> <modal-change-deamon source="{modal_data}" callback="{callback}"></modal-change-deamon> <div style="height:111px;"></div>', 'page-purges { height: 100%; width: 100%; display: block; overflow: auto; } page-purges .card { border-radius: 8px; } page-purges button.refresh{ margin-top:6px; margin-right:8px; }', 'class="page-contents"', function(opts) {
     this.purges = [];
     this.summary = { deamons: [] };

     this.from = moment().hour(7).startOf('hour');
     this.to   = moment(this.from).add(1, 'd');
     this.moveDate = (unit, amount) => {
         this.from = this.from.add(amount, unit);
         this.to   = this.to.add(amount, unit);

         this.tags['purges_page_filter'].update();
     };

     this.edit_target = null;
     this.edit_data   = { before_end: null, after_start: null };
     this.modal_data = null;
     this.callback = (action, data) => {
         if ('open-modal-change-deamon'==action) {

             this.modal_data = this.purges.find((d) => {
                 return d.purge_id == data.purge_id;
             });

             if (this.modal_data==null)
                 return;

             this.update();

             return;
         }
         if ('close-modal-change-deamon'==action) {
             this.modal_data = null;
             this.update();

             return;
         }

         if ('open-purge-result-editor'==action) {
             this.edit_target = this.purges.find((d) => {
                 return d.purge_id == data.id;
             });
             this.edit_data = {
                 before_end: data.before_end,
                 after_start: data.after_start,
             }
             this.tags['modal-purge-result-editor'].update();

             return;
         }

         if ('close-purge-result-editor'==action) {
             this.edit_target = null;
             this.tags['modal-purge-result-editor'].update();
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
         ACTIONS.fetchPagesPurges(this.from, this.to);
     };
     this.on('mount', () => {
         this.refreshData();
     });
     STORE.subscribe((action) => {
         if (action.type=='SETED-IMPURE-DEAMON') {
             this.modal_data = null;
             this.update();

             ACTIONS.fetchPagesPurges(this.from, this.to);
         };

         if (action.type=='FETCHED-PAGES-PURGES') {
             this.summary = action.response.summary;

             this.purges = action.response.purges.map((d) => {
                 d.purge_start = moment(d.purge_start);
                 d.purge_end   = moment(d.purge_end);
                 return d;
             });

             this.update();

             return;
         }

         if (action.type=='SAVED-ACTION-RESULT') {
             this.edit_target = null;
             ACTIONS.fetchPagesPurges(this.from, this.to);

             return;
         }
     });

     this.data = () => {
         let list = STORE.get('purges');

         return list;
     };
});

riot.tag2('purges-list', '<table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth hw-box-shadow" style="font-size:12px;"> <thead> <tr> <th colspan="2">Deamon</th> <th rowspan="2">Impure</th> <th colspan="4">Purge</th> <th colspan="3">作業間隔</th> </tr> <tr> <th>Name</th> <th>操作</th> <th>開始</th> <th>終了</th> <th>時間</th> <th>操作</th> <th>後作業</th> <th>前作業</th> <th>操作</th> </tr> </thead> <tbody> <tr each="{rec in data()}" purge_id="{rec.purge_id}" impure_id="{rec.impure_id}" deamon_id="{rec.deamon_id}"> <td> <a href="#purges/deamons/{rec.deamon_id}"> {rec.deamon_name_short} </a> </td> <td> <button class="button is-small" onclick="{clickChangeDemon}">変</button> </td> <td> <a href="#purges/impures/{rec.impure_id}"> {rec.impure_name} </a> </td> <td>{fdt(rec.purge_start)}</td> <td>{fdt(rec.purge_end)}</td> <td style="text-align: right;">{elapsedTime(rec.purge_start, rec.purge_end)}</td> <td> <button class="button is-small" data-id="{rec.purge_id}" before-end="{beforEnd(rec)}" after-start="{afterStart(rec)}" onclick="{clickEditTermButton}">変</button> </td> <td style="text-align:right;">{fmtSpan(rec.distance.after)}</td> <td style="text-align:right;">{fmtSpan(rec.distance.befor)}</td> <td> <button class="button is-small" disabled>変</button> </td> </tr> </tbody> </table>', 'purges-list .table tbody td { vertical-align: middle; }', '', function(opts) {
     this.ts = new TimeStripper();
     this.befor_data = null;
     this.fmtSpan = (v) => {
         if (!v && v!=0)
             return '';

         let ms = v % 1000;
         let sec = (v - ms) / 1000

         return this.ts.format_sec(Math.floor(sec));
     };
     this.data = () => {
         if (!this.opts.source)
             return [];

         let out = this.opts.source.sort((a, b) => {

             return a.purge_start < b.purge_start ? 1 : -1;
         });

         let befor = null;
         let after = null;
         for (let rec of out) {
             rec.distance = { befor: null, after: null };

             if (after) {
                 let distance = after.purge_start.diff(rec.purge_end);
                 rec.after = after;
                 after.before = rec;

                 rec.distance.after = distance;
                 after.distance.befor = distance;
             }

             after = rec;
         }

         return out;
     };

     this.clickEditTermButton = (e) => {
         let target = e.target;

         this.opts.callback('open-purge-result-editor', {
             id: target.getAttribute('data-id'),
             before_end: target.getAttribute('before-end'),
             after_start: target.getAttribute('after-start'),
         })
     };
     this.clickChangeDemon = (e) => {
         let tr = e.target.parentNode.parentNode;

         this.opts.callback('open-modal-change-deamon', {
             purge_id: tr.getAttribute('purge_id'),
             impure_id: tr.getAttribute('impure_id'),
             deamon_id: tr.getAttribute('deamon_id'),
         })
     };

     this.beforEnd = (rec) => {
         if (!rec.before || !rec.before.purge_end)
             return null;

         return rec.before.purge_end.format('YYYY-MM-DD HH:mm:ss');
     };
     this.afterStart = (rec) => {
         if (!rec.after || !rec.after.purge_start)
             return null;

         return rec.after.purge_start.format('YYYY-MM-DD HH:mm:ss');
     };
     this.fdt = (dt) => {
         return dt.format('MM-DD HH:mm:ss')
     }
     this.elapsedTime = (start, end) => {
         return new TimeStripper().format_elapsedTime(start, end);
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

riot.tag2('purges_page_group-span-deamon', '<p>区分毎の作業時間</p> <table class="table is-bordered is-striped is-narrow is-hoverable" style="margin-top: 33px;"> <thead> <tr> <th colspan="2">Deamon</th> <th colspan="2">Action Results</th> </tr> <tr> <th>Code</th> <th>Name</th> <th>Elapsed Time</th> <th>Count</th> </tr> </thead> <tbody> <tr each="{rec in data()}"> <td>{rec.deamon_name_short}</td> <td>{rec.deamon_name}</td> <td style="text-align:right;">{ts.format_sec(rec.elapsed_time)}</td> <td style="text-align:right;">{rec.purge_count}</td> </tr> </tbody> </table>', 'purges_page_group-span-deamon > p { width: 100%; color: #fff; font-weight: bold; text-shadow: 0px 0px 22px #333333; text-align: center; font-size: 22px; }', '', function(opts) {
     this.hw = new HolyWater();
     this.ts = new TimeStripper();

     this.data = () => {
         return this.opts.source
     };
});

riot.tag2('purges_page_group-span', '<p class="hw-text-white" style="width:100%; font-weight:bold; text-align: center;font-size: 22px;"> 合計作業時間 </p> <p class="hw-text-white" style="font-size: 111px;"> {sumHours()} </p>', '', '', function(opts) {
     this.sumHours = () => {
         let time_sec = new HolyWater().summaryPurges(this.opts.source);

         return new TimeStripper().format_sec(time_sec)
     };
});

riot.tag2('purges_page_guntt-chart', '<div style="overflow:auto; background:#fff; padding:22px;"> <svg class="chart-yabane" ref="chart"></svg> </div>', 'purges_page_guntt-chart { display: block; margin-left: 22px; margin-right: 22px; padding: 22px 11px; background: #fff; border-radius: 3px; } purges_page_guntt-chart > div { width: 100%; border-radius: 3px; } purges_page_guntt-chart > div > svg{ background: #fff; }', '', function(opts) {
     this.on('update', () => {
         let options = {
             scale: {
                 x: {
                     cycle: 'hours',
                     tick:  88,
                     start: this.opts.from,
                     end:   this.opts.to,
                 }
             },
             stage: {
                 selector: 'svg.chart-yabane',
             }
         }

         let hw = new HolyWater()
         let data = this.opts.source.map((d) => {
             return hw.makeGunntChartData(d);
         });

         let element = this.refs.chart;
         while (element.firstChild) element.removeChild(element.firstChild);

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
     let hw = new HolyWater();
     this.contents = (v) => {
         return hw.descriptionViewShort(v);
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

riot.tag2('war-history-page-controller', '<section class="section"> <div class="container"> <div class="contents"> <div class="condition"> <p class="text is-small" style="margin-right:8px;">期間: </p> <input class="input is-small" type="text" placeholder="From" riot-value="{this.from}" ref="from"> <p class="text">〜</p> <input class="input is-small" type="text" placeholder="To" riot-value="{this.to}" ref="to"> </div> <div class="condition"> <p class="text is-small" style="margin-left: 22px; margin-right:8px;">集計単位:</p> <div class="select is-small"> <select> <option>Daily</option> </select> </div> </div> <div class="operator"> <button class="button is-small" onclick="{clickRefresh}">Refresh</button> </div> </div> </div> </section>', 'war-history-page-controller > .section { padding-top:0px; padding-bottom:11px; } war-history-page-controller > .section > .container > .contents{ display: flex; width: 577px; background: rgb(254, 242, 99, 0.55); padding: 11px 22px; border-radius: 8px; } war-history-page-controller .condition { display: flex; } war-history-page-controller .operator { margin-left: 22px; } war-history-page-controller .condition > .input { width: 111px; } war-history-page-controller .condition > p { margin-top: 1px; margin-top: 1px; text-shadow: 0px 0px 8px #fff; color: #333; font-weight: bold; word-break:keep-all; }', '', function(opts) {
     this.from = this.opts.term.from.format('YYYY-MM-DD');
     this.to   = this.opts.term.to.format('YYYY-MM-DD');

     this.clickRefresh = () => {
         let from = moment(this.refs.from.value);
         let to   = moment(this.refs.to.value);

         this.opts.callback('refresh', { from: from, to: to });
     };
});

riot.tag2('war-history-page_tab_days', '<section class="section" style="padding-top:22px;"> <div class="container"> <hw-section-title title="グラフ" lev="4"></hw-section-title> <div class="contents"> <p class="hw-text-white is-4" style="margin-left:22px;">準備中</p> </div> </div> </section> <section class="section" style="padding-top:22px;"> <div class="container"> <hw-section-title title="明細" lev="4"></hw-section-title> <div class="contents" style="margin-top: 22px; padding-left: 22px;"> <table class="table is-bordered is-striped is-narrow is-hoverable" style="font-size: 12px;"> <thead> <tr> <th rowspan="2">Date</th> <th colspan="2">Deamon</th> <th rowspan="2">Elapsed Time [sec]</th> </tr> <tr> <th>ID</th> <th>Name</th> </tr> </thead> <tbody> <tr each="{rec in opts.source.summary.deamons}"> <td>{dateVal(rec)}</td> <td> <a href="#war-history/deamons/{rec.deamon_id}">{rec.deamon_id}</a> </td> <td>{rec.deamon_name}</td> <td style="text-align: right;">{elapseTimeVal(rec)}</td> </tr> </tbody> </table> </div> </div> </section>', '', '', function(opts) {
     this.dateVal = (rec) => {
         return moment(rec.date).format('YYYY-MM-DD ddd');
     }
     this.elapseTimeVal = (rec) => {
         let t = rec.elapsed_time;

         let sec = t % 60;
         t = t - sec;

         let min = (t % (60 * 60)) / 60;
         t = t - min * 60;

         let hour = t / (60 * 60);

         let twoChar = (v) => {
             if (v<10)
                 return '0' + v;

             return '' + v;
         };

         return [hour, min, sec].map(twoChar).join(':');
     }
});

riot.tag2('war-history-page_tab_month', '<section class="section"> <div class="container"> <hw-section-title title="準備中。。。"></hw-section-title> <h2 class="subtitle hw-text-white"> </h2> </div> </section>', '', '', function(opts) {
});

riot.tag2('war-history-page_tab_weeks', '<section class="section"> <div class="container"> <hw-section-title title="準備中。。。"></hw-section-title> <h2 class="subtitle hw-text-white"> </h2> </div> </section>', '', '', function(opts) {
});


riot.tag2('war-history-page', '<div style="margin-top:22px;"></div> <war-history-page-controller term="{term}" callback="{controllerCallbak}"></war-history-page-controller> <war-history-page_tab_days source="{page_data}"></war-history-page_tab_days>', 'war-history-page .tabs ul { border-bottom-color: rgb(254, 242, 99); border-bottom-width: 2px; } war-history-page .tabs.is-boxed li.is-active a { background-color: rgba(254, 242, 99, 0.55); border-color: rgb(254, 242, 99); text-shadow: 0px 0px 11px #fff; color: #333; font-weight: bold; } war-history-page .tabs.is-boxed a { text-shadow: 0px 0px 8px #fff; font-weight: bold; }', 'class="page-contents"', function(opts) {
     this.page_data = { summary: { deamons: [] } };

     let end = moment().startOf();
     let start = moment(end).add(-7, 'd');
     this.term = { from: start, to: end };

     this.on('mount', () => {
         ACTIONS.fetchPagesWarHistory(this.term.from, this.term.to);
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-WAR-HISTORY') {
             this.page_data = action.response;
             this.update();
             return;
         }
     });

     this.controllerCallbak = (action, data) => {
         this.term.from = data.from;
         this.term.to   = data.to;

         ACTIONS.fetchPagesWarHistory(this.term.from, this.term.to);
     };
});
