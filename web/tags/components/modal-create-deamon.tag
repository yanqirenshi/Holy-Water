<modal-create-deamon>

    <div class="modal {isOpen()}">
        <div class="modal-background"></div>

        <div class="modal-content" style="width:888px;">

            <div class="card">
                <header class="card-header">
                    <p class="card-header-title">Create Deamon</p>
                </header>

                <div class="card-content">
                    <div class="content">

                        <div style="margin-bottom:22px;">
                            <input class="input"
                                   type="text"
                                   placeholder="Name"
                                   style="margin-bottom:11px;"
                                   ref="deamon_name"
                                   onkeyup={keyUP}>

                            <input class="input"
                                   type="text"
                                   placeholder="Short Name"
                                   style="margin-bottom:11px;"
                                   ref="deamon_name_short"
                                   onkeyup={keyUP}>

                            <textarea class="textarea"
                                      placeholder="Description"
                                      rows="10"
                                      ref="description"></textarea>
                        </div>

                        <div class="control-area">
                            <button class="button is-small"
                                    onclick={clickClose}>Cancel</button>

                            <button class="button is-small is-danger"
                                    onclick={clickCreate}
                                    disabled={isDisabled()}>Save</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <button class="modal-close is-large"
                aria-label="close"
                onclick={clickClose}></button>
    </div>

    <script>
     this.open = false;
     this.isOpen = () => {
         return this.open ? 'is-active' : '';
     };
     this.isDisabled = () => {
         if (this.refs.deamon_name.value.trim().length==0 ||
             this.refs.deamon_name_short.value.trim().length==0)
             return 'disabled'

         return '';
     };
     this.clickCreate = () => {
         ACTIONS.createDeamon(
             this.refs.deamon_name.value.trim(),
             this.refs.deamon_name_short.value.trim(),
             this.refs.description.value.trim(),
         );
     };
     this.keyUP = () => {
         this.update();
     }
     this.clickClose = () => {
         this.open = false;
         this.update();
     };

     STORE.subscribe((action) => {
         if (action.type=='OPEN-MODAL-CREATE-DEAMON') {
             this.open = true;
             this.update();

             return;
         }

         if (action.type=='CREATED-DEAMON') {
             this.open = false;
             this.update();

             return;
         }
     });
    </script>

</modal-create-deamon>
