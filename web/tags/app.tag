<app>
    <div class="kasumi"></div>

    <menu-bar brand={{label:'RT'}} site={site()} moves={[]}></menu-bar>

    <app-page-area></app-page-area>

    <p class="image-ref" style="">背景画像: <a href="http://joxaren.com/?p=853">旅人の夢</a></p>

    <message-area></message-area>

    <popup-working-action data={impure()}></popup-working-action>

    <menu-add-impure></menu-add-impure>

    <modal-create-impure open={modal_open}
                         maledict={modal_maledict}></modal-create-impure>

    <script>
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
    </script>


    <script>
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
    </script>
</app>
