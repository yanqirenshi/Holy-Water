riot.tag2('angel', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('angel_page_root', '<section class="section"> <div class="container"> <h1 class="title">パスワード変更</h1> <h2 class="subtitle">準備中</h2> </div> </section> <section class="section"> <div class="container"> <h1 class="title" style="text-shadow: 0px 0px 11px #ffffff;">サインアウト</h1> <h2 class="subtitle"></h2> <div class="contents"> <button class="button is-danger" style="margin-left:22px; margin-top:11px;box-shadow: 0px 0px 11px #ffffff;" onclick="{clickSignOut}">Sign Out</button> </div> </div> </section>', '', '', function(opts) {
     this.clickSignOut = () => {
         ACTIONS.signOut();
     };
});

riot.tag2('app', '<div class="kasumi"></div> <menu-bar brand="{{label:\'RT\'}}" site="{site()}" moves="{[]}"></menu-bar> <div ref="page-area" style="padding-left: 55px; width: 100vw; height: 100vh;"></div> <p class="image-ref" style="">背景画像: <a href="http://joxaren.com/?p=853">旅人の夢</a></p> <message-area></message-area>', 'app > .page { width: 100vw; height: 100vh; overflow: hidden; display: block; } app .hide,[data-is="app"] .hide{ display: none; } app > .image-ref { position: fixed; bottom: 3px; right: 22px; font-size: 11px; color: #fff; } app > .image-ref > a:link { color: #fff; } app > .image-ref > a:visited { color: #fff; } app > .image-ref > a:hover { color: #fff; } app > .image-ref > a:active { color: #fff; } app > div.kasumi { position: fixed; top: 0px; left: 0px; width: 100vw; height: 100vh; background: #ffffff; opacity: 0.3; z-index: -888888; }', '', function(opts) {
     this.site = () => {
         return STORE.state().get('site');
     };

     STORE.subscribe((action)=>{
         if (action.type!='MOVE-PAGE')
             return;

         let tags= this.tags;

         tags['menu-bar'].update();
         ROUTER.switchPage(this, this.refs['page-area'], this.site());
     })

     window.addEventListener('resize', (event) => {
         this.update();
     });

     if (location.hash=='')
         location.hash=STORE.get('site.active_page');
});

riot.tag2('cemetery-list', '<table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth"> <thead> <tr> <th colspan="3">Impure</th> <th colspan="2">Purge</th> <th rowspan="2">備考</th> </tr> <tr> <th>ID</th> <th>名称</th> <th>完了</th> <th>開始</th> <th>終了</th> </tr> </thead> <tbody style="font-size:12px;"> <tr each="{impure in opts.data}"> <td nowrap>{impure.id}</td> <td nowrap>{impure.name}</td> <td nowrap>{dt(impure.finished_at)}</td> <td nowrap>{dt(impure.start)}</td> <td nowrap>{dt(impure.end)}</td> <td style="word-break: break-word;">{description(impure.description)}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.dt = (v) => {
         if (!v) return '---'

         return moment(v).format('YYYY-MM-DD HH:mm:ss')
     };

     this.description = (str) => {
         if (str.length<=222)
             return str;

         return str.substring(0, 222) + '........';
     };
});

riot.tag2('cemetery', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('cemetery_page_filter', '<span style="font-size:24px; text-shadow: 0px 0px 11px #fff;">期間：</Span> <input class="input" type="text" placeholder="From" riot-value="{date2str(opts.from)}" readonly> <span style="font-size:24px;"> 〜 </span> <input class="input" type="text" placeholder="To" riot-value="{date2str(opts.to)}" readonly> <div class="operators"> <move-date-operator label="日" unit="d" callback="{callback}"></move-date-operator> <move-date-operator label="週" unit="w" callback="{callback}"></move-date-operator> <move-date-operator label="月" unit="M" callback="{callback}"></move-date-operator> <button class="button refresh" style="margin-top:1px; margin-left:11px;" onclick="{clickRefresh}">Refresh</button> </div>', 'cemetery_page_filter, cemetery_page_filter .operators { display: flex; } cemetery_page_filter .input { width: 111px; border: none; }', '', function(opts) {
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

riot.tag2('cemetery_page_root', '<section class="section"> <div class="container"> <h1 class="title" style="text-shadow: 0px 0px 11px #fff;">自身が Purge(完了) した Impure</h1> <h2 class="subtitle" style="text-shadow: 0px 0px 11px #fff;"></h2> <div> <cemetery_page_filter style="margin-bottom:22px;" from="{from}" to="{to}" callback="{callback}"></cemetery_page_filter> </div> <div style="padding-bottom:22px;"> <cemetery-list data="{impures()}"></cemetery-list> </div> </div> </section>', 'cemetery_page_root { height: 100%; display: block; overflow: scroll; }', '', function(opts) {
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

riot.tag2('page-tabs', '<div class="tabs is-boxed"> <ul> <li each="{opts.core.tabs}" class="{opts.core.active_tab==code ? \'is-active\' : \'\'}"> <a code="{code}" onclick="{clickTab}">{label}</a> </li> </ul> </div>', 'page-tabs li:first-child { margin-left: 22px; }', '', function(opts) {
     this.clickTab = (e) => {
         let code = e.target.getAttribute('code');
         this.opts.callback(e, 'CLICK-TAB', { code: code });
     };
});

riot.tag2('section-breadcrumb', '<section-container data="{path()}"> <nav class="breadcrumb" aria-label="breadcrumbs"> <ul> <li each="{opts.data}"> <a class="{active ? \'is-active\' : \'\'}" href="{href}" aria-current="page">{label}</a> </li> </ul> </nav> </section-container>', 'section-breadcrumb section-container > .section,[data-is="section-breadcrumb"] section-container > .section{ padding-top: 3px; }', '', function(opts) {
     this.path = () => {
         let hash = location.hash;
         let path = hash.split('/');

         if (path[0] && path[0].substr(0,1)=='#')
             path[0] = path[0].substr(1);

         let out = [];
         let len = path.length;
         let href = null;
         for (var i in path) {
             href = href ? href + '/' + path[i] : '#' + path[i];

             if (i==len-1)
                 out.push({
                     label: path[i],
                     href: hash,
                     active: true
                 });

             else
                 out.push({
                     label: path[i],
                     href: href,
                     active: false
                 });
         }
         return out;
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

riot.tag2('sections-list', '<table class="table"> <tbody> <tr each="{opts.data}"> <td><a href="{hash}">{name}</a></td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('deamons', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('deamons_page_root', '<section class="section"> <div class="container"> <h1 class="title hw-text-white">Deamons</h1> <h2 class="subtitle"></h2> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-3 hw-text-white">List</h1> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow"> <thead> <tr> <th>ID</th> <th>Name</th> <th>Name(Short)</th> </tr> </thead> <tbody> <tr each="{deamon in deamons()}"> <td>{deamon.id}</td> <td>{deamon.name}</td> <td>{deamon.name_short}</td> </tr> </tbody> </table> </div> </div> </section>', '', '', function(opts) {
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

riot.tag2('help', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('help_page_root', '', '', '', function(opts) {
});

riot.tag2('home', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('home_page_root-angels', '<nav class="panel hw-box-shadow"> <p class="panel-heading">Angels</p> <a each="{data()}" class="panel-block" angel-id="{id}"> <span style="width: 205px;" maledict-id="{id}"> {name} </span> <span class="operators"> <icon-door-closed></icon-door-closed> </span> </a> </nav>', 'home_page_root-angels > .panel { width: 255px; margin-top: 22px; border-radius: 4px 4px 0 0; } home_page_root-angels > .panel > a { background: #ffffff; } home_page_root-angels .move-door.close .opened-door{ display: none; } home_page_root-angels .move-door.open .closed-door{ display: none; }', '', function(opts) {
     this.dragging = false;

     this.data = () => {
         return STORE.get('angels').list;
     };

     this.active_maledict = null;
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ANGELS')
             this.update();
     });
});

riot.tag2('home_page_root-close-impure-area', '<div> <p>Close Impure. Drag & Drop here</p> </div>', 'home_page_root-close-impure-area > div{ background: #fefefe; padding: 5px; border-radius: 5px; } home_page_root-close-impure-area > div > p{ border: 1px dashed #f0f0f0; border-radius: 5px; padding: 5px 11px; background: #fcfcfc; }', '', function(opts) {
});

riot.tag2('home_page_root-impures', '<div style="padding-left:22px;">Debug: maledict={this.opts.maledict ? this.opts.maledict.name : \'\'}</div> <div class="flex-parent" style="height:100%; margin-top: -8px;"> <div class="card-container"> <div style="overflow: hidden; padding-bottom: 222px; padding-top: 22px;"> <impure-card each="{impure in impures()}" data="{impure}"></impure-card> </div> </div> </div>', 'home_page_root-impures .flex-parent { display: flex; flex-direction: column; } home_page_root-impures .card-container { padding-right: 22px; display: block; overflow: auto; overflow-x: hidden; flex-grow: 1; }', '', function(opts) {
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
             'STARTED-ACTION',
             'STOPED-ACTION',
             'SAVED-IMPURE',
         ]

         if (update_only.indexOf(action.type)>=0)
             this.update();

         if (action.type=='CREATED-MALEDICT-IMPURES')
             if (this.opts.maledict.id == action.maledict.id)
                 ACTIONS.fetchMaledictImpures(this.opts.maledict.id);

         if (action.type=='MOVED-IMPURE')
             ACTIONS.fetchMaledictImpures(this.opts.maledict.id);

         if (action.type=='FINISHED-IMPURE')
             ACTIONS.fetchMaledictImpures(this.opts.maledict.id);
     });
});

riot.tag2('home_page_root-maledicts', '<nav class="panel hw-box-shadow"> <p class="panel-heading">Maledicts</p> <a each="{data()}" class="panel-block {isActive(id)}" onclick="{clickItem}" maledict-id="{id}" style=""> <span style="width: 177px;" maledict-id="{id}"> {name} </span> <span class="operators"> <span class="icon" title="ここに「やること」を追加する。" maledict-id="{id}" maledict-name="{name}" onclick="{clickAddButton}"> <i class="far fa-plus-square" maledict-id="{id}"></i> </span> <span class="move-door {dragging ? \'open\' : \'close\'}" ref="move-door" dragover="{dragover}" drop="{drop}"> <span class="icon closed-door"> <i class="fas fa-door-closed"></i> </span> <span class="icon opened-door" maledict-id="{id}"> <i class="fas fa-door-open" maledict-id="{id}"></i> </span> </span> </span> </a> </nav>', 'home_page_root-maledicts > .panel { width: 255px; border-radius: 4px 4px 0 0; } home_page_root-maledicts .panel-block { background:#fff; } home_page_root-maledicts .panel-block.is-active { background:#eaf4fc; } home_page_root-maledicts .move-door.close .opened-door { display: none; } home_page_root-maledicts .move-door.open .closed-door { display: none; } home_page_root-maledicts .operators { width: 53px; } home_page_root-maledicts .operators .icon { color: #cccccc; } home_page_root-maledicts .operators .icon:hover { color: #880000; } home_page_root-maledicts .operators .move-door.open .icon { color: #880000; }', '', function(opts) {
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
         this.opts.callback('select-bucket', maledict)
     };
     this.clickAddButton = (e) => {
         let target = e.target;
         let maledict = this.opts.data.ht[target.getAttribute('maledict-id')];

         this.opts.callback('open-modal-create-impure', maledict);

         e.stopPropagation();
     };

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

riot.tag2('home_page_root-modal-create-impure', '<div class="modal {opts.open ? \'is-active\' : \'\'}"> <div class="modal-background"></div> <div class="modal-card"> <header class="modal-card-head"> <p class="modal-card-title">やる事を追加</p> <button class="delete" aria-label="close" onclick="{clickCloseButton}"></button> </header> <section class="modal-card-body"> <h4 class="title is-6">場所: {maledictName()}</h4> <div> <span>接頭文字:</span> <button each="{prefixes}" class="button is-small" style="margin-left: 8px;" onclick="{clickTitlePrefix}" riot-value="{label}">{label}</button> </div> <input class="input" type="text" placeholder="Title" ref="name" style="margin-top:11px;"> <textarea class="textarea" placeholder="Description" rows="6" style="margin-top:11px;" ref="description"></textarea> </section> <footer class="modal-card-foot"> <button class="button" onclick="{clickCloseButton}">Cancel</button> <button class="button is-success" onclick="{clickCreateButton}">Create!</button> </footer> </div> </div>', '', '', function(opts) {
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

riot.tag2('home_page_root-other-services', '<nav class="panel hw-box-shadow"> <p class="panel-heading">Services</p> <a each="{data()}" class="panel-block" angel-id="{id}"> <span style="width: 205px;" maledict-id="{id}"> {name} </span> <span class="operators"> </span> </a> </nav>', 'home_page_root-other-services > .panel { width: 255px; margin-top: 22px; border-radius: 4px 4px 0 0; } home_page_root-other-services > .panel > a { background: #ffffff; } home_page_root-other-services .move-door.close .opened-door{ display: none; } home_page_root-other-services .move-door.open .closed-door{ display: none; }', '', function(opts) {
     this.dragging = false;

     this.data = () => {
         return [
             { name: 'Gitlab' },
             { name: 'Redmine' },
             { name: 'Backlog' },
             { name: 'Jira' },
         ];
     };

     this.active_maledict = null;
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ANGELS')
             this.update();
     });
});

riot.tag2('home_page_root-tabs', '<div class="tabs is-boxed"> <ul> <li class="is-active" style="margin-left:22px;"> <a> <span class="icon is-small"><i class="fas fa-image" aria-hidden="true"></i></span> <span>Tasks</span> </a> </li> </ul> </div>', '', '', function(opts) {
});

riot.tag2('home_page_root-working-action', '<button class="button is-small" style="margin-right:11px;" onclick="{clickStop}">Stop</button> <span>{name()}</span> <div style="margin-top: 8px;"> <p style="display:inline; font-size:12px; margin-right:22px;"> <span style="width:88px;display:inline-block;">経過: {distance()}</span> <span>開始: </span> <span>{start()}</span> </p> <button class="button is-small" onclick="{clickStopAndClose}">Stop & Close</button> </div>', 'home_page_root-working-action { display: block; position: fixed; bottom: 33px; right: 33px; background: #fff; padding: 11px 22px; border-radius: 8px; }', 'class="hw-box-shadow {hide()}"', function(opts) {

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

riot.tag2('home_page_root', '<div class="bucket-area"> <home_page_root-maledicts data="{STORE.get(\'maledicts\')}" select="{maledict}" callback="{callback}" dragging="{dragging}"></home_page_root-maledicts> <home_page_root-angels></home_page_root-angels> <home_page_root-other-services></home_page_root-other-services> </div> <div class="contetns-area"> <div style="display:flex;"> <home_page_squeeze-area callback="{callback}"></home_page_squeeze-area> <home_page_root-close-impure-area style="margin-left:88px;margin-top:-5px;"></home_page_root-close-impure-area> </div> <home_page_root-impures maledict="{maledict}" callback="{callback}" filter="{squeeze_word}"></home_page_root-impures> </div> <home_page_root-working-action data="{impure()}"></home_page_root-working-action> <home_page_root-modal-create-impure open="{modal_open}" callback="{callback}" maledict="{modal_maledict}"></home_page_root-modal-create-impure>', 'home_page_root { height: 100%; width: 100%; padding: 22px 0px 0px 22px; display: flex; } home_page_root > .contetns-area { height: 100%; margin-left: 11px; flex-grow: 1; }', '', function(opts) {
     this.modal_open = false;
     this.modal_maledict = null;
     this.maledict = null;
     this.squeeze_word = null;

     this.impure = () => {
         return STORE.get('purging.impure');
     }

     this.callback = (action, data) => {
         if ('select-bucket'==action) {
             this.maledict = data;

             this.update();

             ACTIONS.fetchMaledictImpures(data.id);
         }

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
             this.tags['home_page_root-impures'].update();
         }
     };

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-MALEDICTS')
             this.update();

         if (action.type=='CREATED-MALEDICT-IMPURES')
             this.closeModal();

         if (action.type=='FETCHED-IMPURE-PURGING')
             this.tags['home_page_root-working-action'].update();
     });

     this.on('mount', () => {
         ACTIONS.fetchMaledicts();
         ACTIONS.fetchAngels();
     });

     this.openModal = (maledict) => {
         this.modal_open = true;
         this.modal_maledict = maledict;

         this.tags['home_page_root-modal-create-impure'].update();
     };
     this.closeModal = () => {
         this.modal_open = false;
         this.tags['home_page_root-modal-create-impure'].update();
     };
});

riot.tag2('home_page_squeeze-area', '<div style="width:444px; margin-bottom:22px; margin-left:22px;"> <div class="control has-icons-left has-icons-right"> <input class="input is-rounded" type="text" placeholder="Squeeze Impure※ まだ表示のみで機能しません。" onkeyup="{onKeyUp}" ref="word"> <span class="icon is-left"> <i class="fas fa-search" aria-hidden="true"></i> </span> </div> </div> <button class="button" onclick="{clickClearButton}"> <i class="fas fa-times-circle"></i> </button>', 'home_page_squeeze-area { display: flex; } home_page_squeeze-area .button{ padding: 0px; margin-left: 8px; background: none; border: none; color: #ffff; } home_page_squeeze-area .button:hover{ color: #880000; } home_page_squeeze-area .button i{ font-size: 33px; }', '', function(opts) {
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

riot.tag2('impure-card-large', '<div class="card hw-box-shadow"> <header class="card-header"> <p class="card-header-title"> やること </p> <a href="#" class="card-header-icon" aria-label="more options"> <span class="icon" draggable="true" dragstart="{dragStart}" dragend="{dragEnd}"> <icon-ranning></icon-ranning> </span> </a> </header> <div class="card-content"> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div style="margin-top: 11px;"> <impure-card-large_tab_actions class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_actions> <impure-card-large_tab_edit class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_edit> <impure-card-large_tab_hisotry class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_hisotry> <impure-card-large_tab_show class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_show> <impure-card-large_tab_finish class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_finish> </div> </div> <footer class="card-footer"> <span class="card-footer-item start" action="start-action" onclick="{clickButton}">Start</span> <span class="card-footer-item stop" action="stop-action" onclick="{clickButton}">Stop</span> <span class="card-footer-item open" action="switch-small" onclick="{clickButton}">Small</span> </footer> </div>', 'impure-card-large > .card { width: calc(222px + 222px + 22px); height: calc(222px + 222px + 22px); float: left; margin-left: 22px; margin-top: 1px; margin-bottom: 22px; border: 1px solid #dddddd; border-radius: 5px; } impure-card-large > .card .card-content{ height: calc(222px + 222px + 22px - 49px - 48px); padding: 11px 22px; overflow: auto; }', '', function(opts) {
     this.clickButton = (e) => {
         let target = e.target;
         let action = target.getAttribute('action');

         if (action=='start-action' && this.opts.status)
             return;

         if (action=='stop-action' && !this.opts.status)
             return;

         this.opts.callback(action);
     };
     this.dragStart = (e) => {
         this.opts.callback('start-drag');
     };
     this.dragEnd = (e) => {
         this.opts.callback('end-drag');
     };

     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };

     this.page_tabs = new PageTabs([
         {code: 'show',    label: '照会',     tag: 'impure-card-large_tab_show' },
         {code: 'edit',    label: '編集',     tag: 'impure-card-large_tab_edit' },
         {code: 'actions', label: '実績',     tag: 'impure-card-large_tab_actions' },
         {code: 'history', label: '移動履歴', tag: 'impure-card-large_tab_hisotry' },
         {code: 'finish',  label: '完了',     tag: 'impure-card-large_tab_finish' },
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

riot.tag2('impure-card-large_tab_actions', '<table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth"> <thead> <tr> <th>担当</th> <th>開始</th> <th>終了</th> <th>時間</th> </tr> </thead> <tbody> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('impure-card-large_tab_edit', '<div> <input class="input" type="text" placeholder="Text input" riot-value="{name()}" ref="name"> <textarea class="textarea description" placeholder="10 lines of textarea" rows="10" style="height: 411px;" ref="description">{description()}</textarea> <div> <button class="button" onclick="{clickSave}">Save</button> </div> </div>', 'impure-card-large_tab_edit > div { height:295px; overflow:auto; display:flex; flex-direction:column; } impure-card-large_tab_edit > description { margin-top:11px; flex-grow:1; } impure-card-large_tab_edit > div > * { margin-top: 11px; } impure-card-large_tab_edit > div > *:first-child { margin-top: 0px; }', '', function(opts) {
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
         return this.opts.data.description;
     };
});

riot.tag2('impure-card-large_tab_finish', '<a class="button is-danger" action="finishe-impure">完了</a>', '', '', function(opts) {
});

riot.tag2('impure-card-large_tab_hisotry', '<table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth"> <thead> <tr> <th>担当</th> <th>Maledict</th> <th>開始</th> <th>終了</th> <th>時間</th> </tr> </thead> <tbody> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('impure-card-large_tab_show-description', '', 'impure-card-large_tab_show-description h1 { font-weight: bold; font-size: 20px; margin-top: 11px; text-decoration: underline; } impure-card-large_tab_show-description h1:first-child { margin-top: 0px; } impure-card-large_tab_show-description h2 { font-weight: bold; font-size: 18px; margin-top: 11px; text-decoration: underline; } impure-card-large_tab_show-description h3 { font-weight: bold; font-size: 16px; text-decoration: underline; } impure-card-large_tab_show-description h4 { font-weight: bold; font-size: 14px; } impure-card-large_tab_show-description h5 { font-weight: bold; font-size: 12px; } impure-card-large_tab_show-description * { font-size: 12px; } impure-card-large_tab_show-description table { border-collapse: collapse; } impure-card-large_tab_show-description td { border: solid 1px; padding: 2px 5px; } impure-card-large_tab_show-description th { border: solid 1px; padding: 2px 5px; background: #eeeeee; } impure-card-large_tab_show-description li { list-style-type: square; margin-left: 22px; }', 'class="hw-markdown"', function(opts) {
     this.on('update', () => {
         this.root.innerHTML = this.opts.contents;
     });

    this.root.innerHTML = opts.contents

});

riot.tag2('impure-card-large_tab_show', '<div> <p style="font-weight: bold;">{name()}</p> <p class="description" style="padding:11px;"> <impure-card-large_tab_show-description contents="{marked(this.description())}"></impure-card-large_tab_show-description> </p> <div> <a class="button is-danger" action="finishe-impure" onclick="{clickButton}">完了</a> </div> </div>', 'impure-card-large_tab_show > div { height:295px; overflow:auto; display:flex; flex-direction:column; } impure-card-large_tab_show .description { margin-top:11px; flex-grow:1; }', '', function(opts) {
     this.clickButton = (e) => {
         let target = e.target;

         this.opts.callback(target.getAttribute('action'));
     };

     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };
     this.description = () => {
         if (!this.opts.data) return ''
         return this.opts.data.description;
     };
});

riot.tag2('impure-card-small', '<div class="card hw-box-shadow"> <header class="card-header"> <p class="card-header-title"> やること </p> <a href="#" class="card-header-icon" aria-label="more options"> <span class="icon" title="このアイコンを扉へドラッグ&ドロップすると、扉の場所へ移動できます。" draggable="true" dragstart="{dragStart}" dragend="{dragEnd}"> <icon-ranning></icon-ranning> </span> </a> </header> <div class="card-content"> <div class="content"> <p>{name()}</p> </div> </div> <footer class="card-footer"> <span class="card-footer-item start" action="start-action" onclick="{clickButton}">Start</span> <span class="card-footer-item stop" action="stop-action" onclick="{clickButton}">Stop</span> <span class="card-footer-item open" action="switch-large" onclick="{clickButton}">Open</span> </footer> </div>', 'impure-card-small > .card { width: 222px; height: 222px; float: left; margin-left: 22px; margin-top: 1px; margin-bottom: 22px; border: 1px solid #dddddd; border-radius: 5px; } impure-card-small > .card .card-content{ height: calc(222px - 49px - 48px); padding: 11px 22px; overflow: auto; }', '', function(opts) {
     this.clickButton = (e) => {
         let target = e.target;
         let action = target.getAttribute('action');

         if (action=='start-action' && this.opts.status)
             return;

         if (action=='stop-action' && !this.opts.status)
             return;

         this.opts.callback(action);
     };
     this.dragStart = (e) => {
         let target = e.target;

         e.dataTransfer.setData('impure', JSON.stringify(this.opts.data));

         this.opts.callback('start-drag');
     };
     this.dragEnd = (e) => {
         this.opts.callback('end-drag');
     };

     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };
     this.description = () => {
         if (!this.opts.data) return ''
         return this.opts.data.description;
     };
});

riot.tag2('impure-card', '<impure-card-small data="{opts.data}" status="{status()}" callback="{callback}"></impure-card-small> <impure-card-large data="{opts.data}" status="{status()}" callback="{callback}"></impure-card-large>', 'impure-card.large > impure-card-small { display: none; } impure-card.small > impure-card-large { display: none; } impure-card span.card-footer-item.start { color: inherit; } impure-card[status=start] span.card-footer-item.start { color: #aaaaaa; } impure-card span.card-footer-item.stop { color: #aaaaaa; } impure-card[status=start] span.card-footer-item.stop { color: inherit; } impure-card[status=start] div.card { background: #eaedf7; }', 'class="small" status="{status()}"', function(opts) {
     this.callback = (action, data) => {
         if ('switch-large'==action)
             this.root.setAttribute('class', 'large');

         if ('switch-small'==action)
             this.root.setAttribute('class', 'small');

         if ('start-drag'==action)
             ACTIONS.startDragImpureIcon();

         if ('end-drag'==action)
             ACTIONS.endDragImpureIcon();

         if ('start-action'==action)
             ACTIONS.startImpure(this.opts.data);

         if ('stop-action'==action)
             ACTIONS.stopImpure(this.opts.data);

         if ('finishe-impure'==action)
             ACTIONS.finishImpure(this.opts.data);

         if ('save-impure-contents'==action)
             ACTIONS.saveImpure(data);
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

riot.tag2('page03', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('page03_page_root', '', '', '', function(opts) {
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

riot.tag2('purges', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
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

         let d3yabane = new D3jsYabane()
             .config(options)
             .makeStage()
             .data(data)
             .draw();
     });
});

riot.tag2('purges_page_root', '<div style="padding: 33px 88px 88px 88px;"> <div> <h1 class="title hw-text-white">期間</h1> <purges_page_filter style="margin-bottom:22px; padding-left:33px; padding-right:33px;" from="{from}" to="{to}" callback="{callback}"></purges_page_filter> </div> <div> <h1 class="title hw-text-white">Summary</h1> <div style="display:flex; padding-left:33px; padding-right:33px;"> <div style="margin-right: 88px;"> <purges_page_group-span data="{data()}"></purges_page_group-span> </div> <div> <purges_page_group-span-deamon data="{data()}"></purges_page_group-span-deamon> </div> </div> </div> <div style="margin-top:33px;"> <h1 class="title hw-text-white">Guntt Chart</h1> <div style="padding-left:33px; padding-right:33px;"> <purges_page_guntt-chart data="{data()}"></purges_page_guntt-chart> </div> </div> <div style="margin-top:33px;"> <h1 class="title hw-text-white">Purge hisotry</h1> <div style="display:flex; padding-left:33px; padding-right:33px;"> <purges-list data="{data()}" callback="{callback}"></purges-list> </div> </div> </div> <purge-result-editor data="{edit_target}" callback="{callback}"></purge-result-editor>', 'purges_page_root { height: 100%; width: 100%; display: block; overflow: auto; } purges_page_root .card { border-radius: 8px; } purges_page_root button.refresh{ margin-top:6px; margin-right:8px; }', '', function(opts) {
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

riot.tag2('randing', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('randing_page_root', '', '', '', function(opts) {
});

riot.tag2('war-history', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('war-history_page_root', '<section class="section"> <div class="container"> <h1 class="title hw-text-white">エクソシスト実績</h1> <h2 class="subtitle hw-text-white"> 悪魔毎についやした工数 </h2> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">悪魔別</h1> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4 hw-text-white">日別</h1> </div> </section> </div> </section> <section class="section"> <div class="container"> <h1 class="title hw-text-white">作業時間統計</h1> <h2 class="subtitle hw-text-white"> Purge の統計情報。どれくらいの作業時間か。とか。 </h2> </div> </section>', '', '', function(opts) {
});
