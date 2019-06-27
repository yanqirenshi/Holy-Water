<modal-create-after-impure>

    <div class="modal {impure ? 'is-active' : ''}">
        <div class="modal-background"></div>
        <div class="modal-card" style="width:999px;">

            <header class="modal-card-head" style="padding: 11px 22px;">
                <p class="modal-card-title" style="font-size:16px;">後続の Impure を作成</p>
                <button class="delete" aria-label="close" onclick={clickClose}></button>
            </header>

            <section class="modal-card-body" style="display:flex;">
                <div class="left">
                    <input class="input is-small"
                           type="text"
                           placeholder="Title"
                           ref="name">

                    <textarea class="textarea is-small martin-top"
                              placeholder="Description"
                              rows="6"
                              style="height: 222px;"
                              ref="description"></textarea>

                    <h1 class="title is-6 martin-top"
                        style="margin-bottom: 3px;">Deamon:</h1>

                    <div class="martin-top">
                        <modal-create-after-impure-left-deamon source={deamon}
                                                               callback={callback}></modal-create-after-impure-left-deamon>

                        <modal-create-after-impure-left-deamons callback={callback}></modal-create-after-impure-left-deamons>
                    </div>
                </div>

                <modal-create-after-impure-center source={impure} callback={callback}></modal-create-after-impure-center>
                <modal-create-after-impure-right  source={impure}></modal-create-after-impure-right>
            </section>

            <footer class="modal-card-foot"
                    style="padding: 11px 22px; display: flex; justify-content: space-between;">

                <button class="button is-small"
                        onclick={clickClose}>Cancel</button>

                <button class="button is-small is-success"
                        onclick={clickCreate}>Create!</button>
            </footer>
        </div>
    </div>

    <script>
     this.callback = (action, data) => {
         if (action=='copy') {
             this.refs.name.value = this.impure.name;
             this.refs.description.value = this.impure.description;
             this.deamon = this.impure.deamon;
             this.update();

             return;
         }

         if (action=='select-deamon') {
             this.deamon = data;
             this.update();
         }
     };
    </script>

    <script>
     this.impure   = null;
     this.maledict = null;
     this.deamon   = null;
     STORE.subscribe((action) => {
         if (action.type=='OPEN-MODAL-CREATE-AFTER-IMPURE') {
             this.impure = action.impure;
             this.update();

             return;
         }

         let list = [
             'CREATED-IMPURE-AFTER-IMPURE',
             'CLOSE-MODAL-CREATE-IMPURE',
             'CREATED-MALEDICT-IMPURE',
         ];
         if (list.find((d) => { return action.type == d;})) {
             this.impure = null;
             this.maledict = null;
             this.update();

             return;
         }
     });
    </script>

    <script>
     this.clickCreate = (e) => {
         let params = {
             name: this.refs.name.value.trim(),
             description: this.refs.description.value.trim(),
         }

         if (this.deamon)
             params.deamon_id = this.deamon.id

         ACTIONS.createImpureAfterImpure(this.impure, params);
     };
     this.clickClose = (e) => {
         ACTIONS.closeModalCreateImpure();
     };
    </script>

    <style>
     modal-create-after-impure .left {
         flex-grow: 1;
         display: flex;
         flex-direction: column;
         width:45%;
     }
     modal-create-after-impure .left .martin-top {
         margin-top:11px;
     }
    </style>

</modal-create-after-impure>
