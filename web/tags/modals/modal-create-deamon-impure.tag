<modal-create-deamon-impure>

    <div class="modal  {deamon ? 'is-active' : ''}">
        <div class="modal-background"></div>
        <div class="modal-card">

            <header class="modal-card-head" style="padding: 11px 22px;">
                <p class="modal-card-title" style="font-size:16px;">Create Impure of Deamon</p>
                <button class="delete" aria-label="close" onclick={clickClose}></button>
            </header>

            <section class="modal-card-body">

                <div>
                    <p>悪魔：{deamonName()}</p>
                </div>

                <input class="input is-small"
                       type="text"
                       placeholder="Title"
                       style="margin-top:22px;"
                       ref="name">

                <textarea class="textarea is-small martin-top"
                          placeholder="Description"
                          rows="6"
                          style="height: 222px; margin-top:11px;"
                          ref="description"></textarea>

            </section>

            <footer class="modal-card-foot"
                    style="padding: 11px 22px; display: flex; justify-content: space-between;">

                <button class="button is-small" onclick={clickClose}>Cancel</button>
                <button class="button is-success is-small" onclick={clickCreate}>Create</button>
            </footer>
        </div>
    </div>

    <script>
     this.deamonName = () => {
         if (!this.deamon)
             return '';

         return this.deamon.name + "(" + this.deamon.name_short + ")"
     };
    </script>

    <script>
     this.clickCreate = (e) => {
         let params = {
             name: this.refs.name.value.trim(),
             description: this.refs.description.value.trim(),
         }

         ACTIONS.createImpureDeamonImpure(this.deamon, params);
     };
     this.clickClose = (e) => {
         this.deamon = null;
         this.update();
     };
    </script>

    <script>
     this.deamon   = null;
     STORE.subscribe((action) => {
         if (action.type=='OPEN-MODAL-CREATE-DEAMON-IMPURE') {
             this.deamon = action.deamon;
             this.update();

             return;
         }

         let list = [
             'CREATED-IMPURE-DEAMON-IMPURE',
         ];
         if (list.find((d) => { return action.type == d;})) {
             this.deamon = null;
             this.update();

             return;
         }
     });
    </script>

</modal-create-deamon-impure>
