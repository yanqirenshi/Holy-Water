<app>
    <div class="kasumi"></div>

    <menu-bar brand={{label:'RT'}} site={site()} moves={[]}></menu-bar>

    <div ref="page-area"></div>

    <p class="image-ref" style="">背景画像: <a href="http://joxaren.com/?p=853">旅人の夢</a></p>

    <message-area></message-area>

    <style>
     app > .page {
         width: 100vw;
         height: 100vh;
         overflow: hidden;
         display: block;
     }
     .hide { display: none; }

     app > .image-ref {
         position: fixed;
         bottom: 3px;
         right: 22px;
         font-size: 11px;
         color: #fff;
     }
     app > .image-ref > a:link    { color: #fff; }
     app > .image-ref > a:visited { color: #fff; }
     app > .image-ref > a:hover   { color: #fff; }
     app > .image-ref > a:active  { color: #fff; }
    </style>

    <script>
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
    </script>

    <style>
     app > div.kasumi {
         position: fixed;
         top: 0px;
         left: 0px;
         width: 100vw;
         height: 100vh;
         background: #ffffff;
         opacity: 0.3;
         z-index: -888888;
     }
     app > div[ref=page-area] {
         padding-left: 55px;
         width: 100vw;
         height: 100vh;
     }
    </style>
</app>
