<app>
    <div class="kasumi"></div>

    <menu-bar brand={{label:'RT'}} site={site()} moves={[]}></menu-bar>

    <div ref="page-area"></div>

    <p class="image-ref" style="">背景画像: <a href="http://joxaren.com/?p=853">旅人の夢</a></p>

    <message-area></message-area>

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

     this.on('mount', () => {
         ACTIONS.movePage(STORE.get('site'));
     });
    </script>
</app>
