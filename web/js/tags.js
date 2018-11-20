riot.tag2('app', '<menu-bar brand="{{label:\'RT\'}}" site="{site()}" moves="{[]}"></menu-bar> <div ref="page-area" style="padding-left: 55px; width: 100vw; height: 100vh;"></div> <p class="image-ref" style="">背景画像: <a href="http://joxaren.com/?p=853">旅人の夢</a></p>', 'app > .page { width: 100vw; height: 100vh; overflow: hidden; display: block; } app .hide,[data-is="app"] .hide{ display: none; } app > .image-ref { position: fixed; bottom: 3px; right: 22px; font-size: 11px; color: #fff; } app > .image-ref > a:link { color: #fff; } app > .image-ref > a:visited { color: #fff; } app > .image-ref > a:hover { color: #fff; } app > .image-ref > a:active { color: #fff; }', '', function(opts) {
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

riot.tag2('menu-bar', '<aside class="menu"> <p ref="brand" class="menu-label" onclick="{clickBrand}"> {opts.brand.label} </p> <ul class="menu-list"> <li each="{opts.site.pages}"> <a class="{opts.site.active_page==code ? \'is-active\' : \'\'}" href="{\'#\' + code}"> {menu_label} </a> </li> </ul> </aside> <div class="move-page-menu hide" ref="move-panel"> <p each="{moves()}"> <a href="{href}">{label}</a> </p> </div>', 'menu-bar .move-page-menu { z-index: 666665; background: #ffffff; position: fixed; left: 55px; top: 0px; min-width: 111px; height: 100vh; box-shadow: 2px 0px 8px 0px #e0e0e0; padding: 22px 55px 22px 22px; } menu-bar .move-page-menu.hide { display: none; } menu-bar .move-page-menu > p { margin-bottom: 11px; } menu-bar > .menu { z-index: 666666; height: 100vh; width: 55px; padding: 11px 0px 11px 11px; position: fixed; left: 0px; top: 0px; background: #e198b4; } menu-bar .menu-label, menu-bar .menu-list a { padding: 0; width: 33px; height: 33px; text-align: center; margin-top: 8px; border-radius: 3px; background: none; color: #ffffff; font-weight: bold; padding-top: 7px; font-size: 14px; } menu-bar .menu-label,[data-is="menu-bar"] .menu-label{ background: #ffffff; color: #e198b4; } menu-bar .menu-label.open,[data-is="menu-bar"] .menu-label.open{ background: #ffffff; color: #e198b4; width: 44px; border-radius: 3px 0px 0px 3px; text-shadow: 0px 0px 1px #eee; padding-right: 11px; } menu-bar .menu-list a.is-active { width: 44px; padding-right: 11px; border-radius: 3px 0px 0px 3px; background: #ffffff; color: #333333; }', '', function(opts) {
     this.moves = () => {
         let moves = [
             { code: 'link-a', href: '', label: 'Link A' },
             { code: 'link-b', href: '', label: 'Link B' },
             { code: 'link-c', href: '', label: 'Link C' },
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

riot.tag2('page-tabs', '<div class="tabs is-boxed"> <ul> <li each="{opts.core.tabs}" class="{opts.core.active_tab==code ? \'is-active\' : \'\'}"> <a code="{code}" onclick="{clickTab}">{label}</a> </li> </ul> </div>', 'page-tabs li:first-child { margin-left: 55px; }', '', function(opts) {
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

riot.tag2('home', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('home_page_root-buckets', '<nav class="panel" style="width: 255px;"> <p class="panel-heading">Buckets</p> <a each="{opts.data.list}" class="panel-block {isActive(id)}" onclick="{clickItem}" maledict-id="{id}" style="background:#fff;"> <span style="width: 177px;" maledict-id="{id}"> {name} </span> <span style="width: 53px;"> <span class="move-door {dragging ? \'open\' : \'close\'}" ref="move-door" dragover="{mouseOver}" dragenter="{dragEnter}" dragleave="{dragLeave}"> <span class="icon" title="ここに「やること」を追加する。"> <i class="far fa-plus-square"></i> </span> <span class="icon closed-door"> <i class="fas fa-door-closed"></i> </span> <span class="icon opened-door"> <i class="fas fa-door-open"></i> </span> </span> </span> </a> </nav>', 'home_page_root-buckets .move-door.close .opened-door{ display: none; } home_page_root-buckets .move-door.open .closed-door{ display: none; }', '', function(opts) {
     this.dragging = false;

     this.active_maledict = null;
     this.isActive = (id) => {
         return id==opts.select ? 'is-active' : ''
     }
     this.clickItem = (e) => {
         this.opts.callback('select-bucket', e.target.getAttribute('maledict-id') * 1)
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

riot.tag2('home_page_root-impures', '<div class="flex-parent" style="height:100%; margin-top: -8px;"> <div class="card-container"> <div style="overflow: hidden; padding-bottom: 222px; padding-top: 8px;"> <impure-card each="{impure in impures()}" data="{impure}"></impure-card> </div> </div> </div>', 'home_page_root-impures .flex-parent { display: flex; flex-direction: column; } home_page_root-impures .card-container { padding-right: 22px; display: block; overflow: auto; overflow-x: hidden; flex-grow: 1; }', '', function(opts) {
     this.impures = () => {
         return STORE.get('impures').list;
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-MALEDICT-IMPURES')
             this.update();
         if (action.type=='CREATED-MALEDICT-IMPURES')
             this.update();
         if (action.type=='STARTED-ACTION')
             this.update();
         if (action.type=='STOPED-ACTION')
             this.update();
     });
});

riot.tag2('home_page_root-members', '<nav class="panel" style="width: 255px; margin-top: 22px;"> <p class="panel-heading">Members</p> <a each="{data()}" class="panel-block {isActive(id)}" maledict-id="{id}"> <span style="width: 177px;" maledict-id="{id}"> {name} </span> </a> </nav>', 'home_page_root-members home_page_root-buckets .move-door.close .opened-door,[data-is="home_page_root-members"] home_page_root-buckets .move-door.close .opened-door{ display: none; } home_page_root-members home_page_root-buckets .move-door.open .closed-door,[data-is="home_page_root-members"] home_page_root-buckets .move-door.open .closed-door{ display: none; }', '', function(opts) {
     this.dragging = false;

     this.data = () => {
         return opts.data ? opts.data.list : [];
     };

     this.active_maledict = null;
     this.isActive = (id) => {
         return id==opts.select ? 'is-active' : ''
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

riot.tag2('home_page_root-modal-create-impure', '<div class="modal {opts.open ? \'is-active\' : \'\'}"> <div class="modal-background"></div> <div class="modal-card"> <header class="modal-card-head"> <p class="modal-card-title">やる事を追加</p> <button class="delete" aria-label="close" onclick="{clickCloseButton}"></button> </header> <section class="modal-card-body"> <input class="input" type="text" placeholder="Title" ref="name"> <textarea class="textarea" placeholder="Description" rows="6" style="margin-top:11px;" ref="description"></textarea> </section> <footer class="modal-card-foot"> <button class="button is-success" onclick="{clickCreateButton}">Create!</button> <button class="button" onclick="{clickCloseButton}">Cancel</button> </footer> </div> </div>', '', '', function(opts) {
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

riot.tag2('home_page_root-operators', '<div> <button class="button is-danger {isHide()}" action="open-modal-create-impure" onclick="{clickButton}"> 「やること」を追加 </button> </div>', 'home_page_root-operators { position: fixed; bottom: 22px; right: 33px; } home_page_root-operators .button { border-radius: 3px; margin-left: 11px; }', '', function(opts) {
     this.isHide = () => {
         return this.opts.maledict ? '' : 'hide'
     };
     this.findUp = (element, nodeName) => {
         if (!element) return null;

         if (element.nodeName == nodeName)
             return element;

         return this.findUp(element.parentElement, nodeName);
     };
     this.clickButton = (e) => {
         let button = this.findUp(e.target, 'BUTTON');

         opts.callback(button.getAttribute('action'));
     };
});

riot.tag2('home_page_root-tabs', '<div class="tabs is-boxed"> <ul> <li class="is-active" style="margin-left:22px;"> <a> <span class="icon is-small"><i class="fas fa-image" aria-hidden="true"></i></span> <span>Tasks</span> </a> </li> </ul> </div>', '', '', function(opts) {
});

riot.tag2('home_page_root', '<div class="bucket-area"> <home_page_root-buckets data="{STORE.get(\'maledicts\')}" select="{maledict}" callback="{callback}" dragging="{dragging}"></home_page_root-buckets> <home_page_root-members></home_page_root-members> </div> <div class="contetns-area"> <home_page_root-impures maledict="{maledict}" callback="{callback}"></home_page_root-impures> </div> <home_page_root-operators callback="{callback}" maledict="{maledict}"></home_page_root-operators> <home_page_root-modal-create-impure open="{modal_open}" callback="{callback}" maledict="{maledict}"></home_page_root-modal-create-impure>', 'home_page_root { height: 100%; width: 100%; padding: 22px 0px 0px 22px; display: flex; } home_page_root > .contetns-area { height: 100%; margin-left: 11px; flex-grow: 1; }', '', function(opts) {
     this.modal_open = false;
     this.maledict = null;

     this.callback = (action, data) => {
         if (action=='select-bucket') {
             let id = data;
             this.maledict = id;

             this.update();

             ACTIONS.fetchMaledictImpures(id);
         }

         if (action=='open-modal-create-impure')
             this.openModal();

         if (action=='close-modal-create-impure')
             this.closeModal();

         if (action=='create-impure')
             ACTIONS.createMaledictImpures(data.maledict, {
                 name: data.name,
                 description: data.description,
             });

     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-MALEDICTS') {
             this.update();
         }
         if (action.type=='CREATED-MALEDICT-IMPURES') {
             this.closeModal();
         }
     });
     this.on('mount', () => {
         ACTIONS.fetchMaledicts();
     });

     this.openModal = () => {
         this.modal_open = true;
         this.tags['home_page_root-modal-create-impure'].update();
     };
     this.closeModal = () => {
         this.modal_open = false;
         this.tags['home_page_root-modal-create-impure'].update();
     };
});

riot.tag2('impure-card-large', '<div class="card" style="box-shadow: 0px 0px 8px #eeeeee;"> <header class="card-header"> <p class="card-header-title"> やること </p> <a href="#" class="card-header-icon" aria-label="more options"> <span class="icon" draggable="true" dragstart="{dragStart}" dragend="{dragEnd}"> <i class="fas fa-running"></i> </span> </a> </header> <div class="card-content"> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div style="margin-top: 11px;"> <impure-card-large_tab_actions class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_actions> <impure-card-large_tab_edit class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_edit> <impure-card-large_tab_hisotry class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_hisotry> <impure-card-large_tab_show class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_show> <impure-card-large_tab_finish class="hide" data="{opts.data}" callback="{opts.callback}"></impure-card-large_tab_finish> </div> </div> <footer class="card-footer"> <span class="card-footer-item start" action="start-action" onclick="{clickButton}">Start</span> <span class="card-footer-item stop" action="stop-action" onclick="{clickButton}">Stop</span> <span class="card-footer-item open" action="switch-large" onclick="{clickButton}">Close</span> </footer> </div>', 'impure-card-large > .card { width: calc(222px + 222px + 222px + 22px); height: calc(222px + 222px + 222px + 22px); float: left; margin-left: 22px; margin-top: 1px; margin-bottom: 22px; box-shadow: 0px 0px 8px #ffffff; border: 1px solid #dddddd; border-radius: 5px; } impure-card-large > .card .card-content{ height: calc(222px + 222px + 222px + 22px - 49px - 48px); padding: 11px 22px; overflow: auto; }', '', function(opts) {
     this.clickButton = (e) => {
         let target = e.target;
         let action = target.getAttribute('action');

         this.opts.callback('switch-small');
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

riot.tag2('impure-card-large_tab_edit', '<input class="input" type="text" placeholder="Text input" riot-value="{name()}"> <textarea class="textarea" placeholder="10 lines of textarea" rows="10" style="height: 411px;">{description()}</textarea> <button class="button">Save</button>', 'impure-card-large_tab_edit > *{ margin-bottom: 11px; } impure-card-large_tab_edit > *:last-child{ margin-bottom: 0px; }', '', function(opts) {
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

riot.tag2('impure-card-large_tab_show', '<div style="height:422px; height:505px; overflow:auto;"> <p style="font-weight: bold;">{name()}</p> <p style="margin-top:11px;">{description()}</p> <div> <a class="button is-danger" action="finishe-impure" onclick="{clickButton}">完了</a> </div> </div>', '', '', function(opts) {
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

riot.tag2('impure-card-small', '<div class="card"> <header class="card-header"> <p class="card-header-title"> やること </p> <a href="#" class="card-header-icon" aria-label="more options"> <span class="icon" title="このアイコンを扉へドラッグ&ドロップすると、扉の場所へ移動できます。" draggable="true" dragstart="{dragStart}" dragend="{dragEnd}"> <i class="fas fa-running"></i> </span> </a> </header> <div class="card-content"> <div class="content"> <p>{name()}</p> </div> </div> <footer class="card-footer"> <span class="card-footer-item start" action="start-action" onclick="{clickButton}">Start</span> <span class="card-footer-item stop" action="stop-action" onclick="{clickButton}">Stop</span> <span class="card-footer-item open" action="switch-large" onclick="{clickButton}">Open</span> </footer> </div>', 'impure-card-small > .card { width: 222px; height: 222px; float: left; margin-left: 22px; margin-top: 1px; margin-bottom: 22px; box-shadow: 0px 0px 8px #ffffff; border: 1px solid #dddddd; border-radius: 5px; } impure-card-small > .card .card-content{ height: calc(222px - 49px - 48px); padding: 11px 22px; overflow: auto; }', '', function(opts) {
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
     this.description = () => {
         if (!this.opts.data) return ''
         return this.opts.data.description;
     };
});

riot.tag2('impure-card', '<impure-card-small data="{opts.data}" status="{status()}" callback="{callback}"></impure-card-small> <impure-card-large data="{opts.data}" status="{status()}" callback="{callback}"></impure-card-large>', 'impure-card.large > impure-card-small { display: none; } impure-card.small > impure-card-large { display: none; } impure-card span.card-footer-item.start { color: inherit; } impure-card[status=start] span.card-footer-item.start { color: #eeeeee; } impure-card span.card-footer-item.stop { color: #eeeeee; } impure-card[status=start] span.card-footer-item.stop { color: inherit; }', 'class="small" status="{status()}"', function(opts) {
     this.callback = (action) => {
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

riot.tag2('page01', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('page01_page1', '<section-header-with-breadcrumb title="Page01 Sec 1"></section-header-with-breadcrumb>', '', '', function(opts) {
});

riot.tag2('page01_page2', '<section-header-with-breadcrumb title="Page01 Sec 2"></section-header-with-breadcrumb>', '', '', function(opts) {
});

riot.tag2('page01_page3', '<section-header-with-breadcrumb title="Page01 Sec 3"></section-header-with-breadcrumb>', '', '', function(opts) {
});

riot.tag2('page01_page_root', '<section-header title="Page01"></section-header> <section-container title="セクション" data="{sections()}"> <sections-list data="{opts.data}"> </sections-list> </section-container> <section-footer></section-footer>', '', '', function(opts) {
     this.sections = () => {
         let pages = STORE.get('site').pages;
         let page = pages.find((d) => { return d.code=='page01'; });

         return page.sections;
     }
});

riot.tag2('page02', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('page02_page_root', '<section-header title="Page02"></section-header> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div> <page02_page_tab_readme class="hide"></page02_page_tab_readme> <page02_page_tab_tab1 class="hide"></page02_page_tab_tab1> <page02_page_tab_tab2 class="hide"></page02_page_tab_tab2> <page02_page_tab_tab3 class="hide"></page02_page_tab_tab3> <page02_page_tab_help class="hide"></page02_page_tab_help> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'readme', label: 'README', tag: 'page02_page_tab_readme' },
         {code: 'tab1',   label: 'TAB1',   tag: 'page02_page_tab_tab1' },
         {code: 'tab2',   label: 'TAB2',   tag: 'page02_page_tab_tab2' },
         {code: 'tab3',   label: 'TAB3',   tag: 'page02_page_tab_tab3' },
         {code: 'help',   label: 'HELP',   tag: 'page02_page_tab_help' },
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

riot.tag2('page02_page_tab_help', '<section class="section"> <div class="container"> <h1 class="title">HELP</h1> <h2 class="subtitle"> </h2> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page02_page_tab_readme', '<section class="section"> <div class="container"> <h1 class="title">README</h1> <h2 class="subtitle"> </h2> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page02_page_tab_tab1', '<section class="section"> <div class="container"> <h1 class="title">TAB1</h1> <h2 class="subtitle"> </h2> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page02_page_tab_tab2', '<section class="section"> <div class="container"> <h1 class="title">TAB2</h1> <h2 class="subtitle"> </h2> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page02_page_tab_tab3', '<section class="section"> <div class="container"> <h1 class="title">TAB3</h1> <h2 class="subtitle"> </h2> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('page03', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('page03_page_root', '<section-header title="Page03"></section-header> <section-footer></section-footer>', '', '', function(opts) {
});
