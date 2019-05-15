<modal-create-after-impure>

    <div class="modal {opts.impure ? 'is-active' : ''}">
        <div class="modal-background"></div>
        <div class="modal-card" style="width:999px;">

            <header class="modal-card-head" style="padding: 11px 22px;">
                <p class="modal-card-title" style="font-size:16px;">後続の Impure を作成</p>
                <button class="delete" aria-label="close" onclick={clickCloseButton}></button>
            </header>

            <section class="modal-card-body" style="display:flex;">
                <div style="flex-grow:1;">
                    <input class="input is-small"
                           type="text"
                           placeholder="Title"
                           ref="name">

                    <textarea class="textarea is-small"
                              placeholder="Description"
                              rows="6"
                              style="margin-top:11px; height: 333px;"
                              ref="description"></textarea>

                    <h1 class="title is-6" style="margin-bottom: 3px; margin-top:11px;">Deamon:</h1>
                    <div style="margin-left:11px;">
                        <p style="margin-bottom:11px;">なし</p>

                        <input class="input is-small"
                               type="text"
                               placeholder="Search Deamon"
                               ref="name">

                        <div style="margin-top:11px;">
                            <button class="button is-small">Deamon 1</button>
                            <button class="button is-small">Deamon 2</button>
                            <button class="button is-small">Deamon 3</button>
                        </div>
                    </div>
                </div>

                <div style="padding-left: 22px; padding-right: 22px; display:flex; flex-direction: column; justify-content: center;;">
                    <h1 class="title is-6">Copy</h1>
                    <button class="button is-small">←</button>
                </div>

                <div style="flex-grow:1;padding: 11px;background: #eeeeee;border-radius: 3px;">
                    <h1 class="title is-6" style="margin-bottom: 3px;">Title:</h1>
                    <p style="padding-left:11px;">title ....</p>

                    <h1 class="title is-6" style="margin-bottom: 3px; margin-top: 11px;">description:</h1>
                    <p style="padding-left:11px;">markdon -> html ....</p>

                    <h1 class="title is-6" style="margin-bottom: 3px; margin-top: 11px;">Deamon:</h1>
                    <p style="padding-left:11px;">Deamon...</p>
                </div>

            </section>

            <footer class="modal-card-foot"
                    style="padding: 11px 22px; display: flex; justify-content: space-between;">
                <button class="button is-small" onclick={clickCloseButton}>Cancel</button>
                <button class="button is-small is-success" onclick={clickCreateButton}>Create!</button>
            </footer>
        </div>
    </div>

    <script>
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
    </script>

    <script>
     this.maledictName = () => {
         return this.maledict ? this.maledict.name : '';
     }
    </script>

    <script>
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
    </script>

</modal-create-after-impure>
