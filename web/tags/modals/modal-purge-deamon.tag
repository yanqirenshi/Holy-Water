<modal-purge-deamon>

    <div class="modal {deamon ? 'is-active' : ''}">
        <div class="modal-background"></div>

        <div class="modal-card" style="width: 555px;">

            <header class="modal-card-head" style="padding: 11px 22px;">
                <p class="modal-card-title" style="font-size: 14px;">悪魔の浄化</p>
                <button class="delete"
                        aria-label="close"
                        onclick={clickClose}></button>
            </header>

            <section class="modal-card-body">

                <div class="contents">
                    <p>この悪魔を浄化しますか？</p>
                    <h1 class="title is-6">ID</h1>
                    <p>{deamon ? deamon.id : ''}</p>
                    <h1 class="title is-6">Name</h1>
                    <p>{deamon ? deamon.name : ''}</p>
                    <h1 class="title is-6">Name(Short)</h1>
                    <p>{deamon ? deamon.name_short : ''}</p>
                    <h1 class="title is-6">Description</h1>
                    <p>{deamon ? deamon.description : ''}</p>
                </div>

            </section>

            <footer class="modal-card-foot" style="padding: 11px 22px; display:flex; justify-content: space-between;">
                <button class="button is-small" onclick={clickClose}>Cancel</button>
                <button class="button is-small is-success" onclick={clickPurge}>浄化</button>
            </footer>
        </div>
    </div>

    <script>
     this.deamon = null;

     this.clickPurge = () => {
         ACTIONS.purgeDeamon(this.deamon);
     };
     STORE.subscribe((action)=>{
         if(action.type=='OPEN-MODAL-PUREGE-DEAMON') {
             this.deamon = action.deamon;
             this.update();

             return;
         }
         if(action.type=='PURGE-DEAMON') {
             this.deamon = null;
             this.update();

             return;
         }
     });
     this.clickClose = () => {
         this.deamon = null;
         this.update();

         return;
     };
    </script>

    <style>
     modal-purge-deamon .modal-card-body .contents .title {
         margin-top: 22px;
         margin-bottom: 6px;
     }
     modal-purge-deamon .modal-card-body .contents p {
         padding-left: 11px;
     }
    </style>

</modal-purge-deamon>
