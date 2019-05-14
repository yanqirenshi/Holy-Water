<modal-change-deamon>

    <div class="modal {isOpen()}">
        <div class="modal-background"></div>

        <div class="modal-content" style="width:888px;">

            <div class="card">
                <header class="card-header">
                    <p class="card-header-title">
                        Change Deamon <span style="margin-left: 22px; color: #f00; font-weight:bold;" >注意: 実装中</span>
                    </p>
                </header>

                <div class="card-content">
                    <div class="content">

                        <div class="flex-contener">
                            <div class="choose-demaon-area">
                                <modal-change-deamon-area source={opts.source}
                                                          callback={callback}></modal-change-deamon-area>
                            </div>

                            <div class="view-impure-area">
                                <modal-change-deamon-impure-area source={opts.source}
                                                                 choosed_deamon={choosed_deamon}
                                                                 callback={callback}></modal-change-deamon-impure-area>
                            </div>
                        </div>

                        <div class="control-area">
                            <button class="button is-small"
                                    onclick={clickCancel}>Cancel</button>

                            <button class="button is-small is-danger"
                                    onclick={clickSave}
                                    disabled={isDisabled()}>Save</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <button class="modal-close is-large"
                aria-label="close"
                onclick={clickCancel}></button>
    </div>

    <script>
     this.isOpen = () => {
         return this.opts.source ? 'is-active' : '';
     };
     this.isDisabled = () => {
         if (!this.opts.source)
             return 'disabled';

         if (this.choosed_deamon.id == this.opts.source.deamon_id)
             return 'disabled';

         return '';
     };
    </script>

    <script>
     this.choosed_deamon = null;
     this.on('update', () => {
         if (!this.opts.source)
             return;

         if (!this.choosed_deamon) {
             let id = this.opts.source.deamon_id;

             if (!id)
                 this.choosed_deamon = { id: null };
             else
                 this.choosed_deamon = STORE.get('deamons.ht')[id];
         }
     });

     this.callback = (action, data) => {
         if (action=='choose-deamon') {
             let deamons = STORE.get('deamons.ht');

             this.choosed_deamon = deamons[data.id];

             if (!this.choosed_deamon)
                 this.choosed_deamon = { id: null };

             this.update();

             return;
         }
         if (action=='remove-deamon') {
             this.choosed_deamon = { id: null };

             this.update();

             return;
         }
     };
     this.clickCancel = () => {
         this.opts.callback('close-modal-change-deamon');
     };
     this.clickSave = () => {
         let impure = { id: this.opts.source.impure_id };
         let deamon = this.choosed_deamon;

         ACTIONS.setImpureDeamon(impure, deamon);
     };
    </script>

    <style>
     modal-change-deamon .flex-contener { display:flex; height:555px; }
     modal-change-deamon .choose-demaon-area { flex-grow: 1; padding: 11px; width: 211px; }
     modal-change-deamon .choose-demaon-area .deamon-item { margin-left: 11px; margin-bottom: 11px; }
     modal-change-deamon .view-impure-area   {
         flex-grow: 1;
         padding: 11px;
         background: rgba(254, 242, 100, 0.08);
         border-radius: 8px;
         box-shadow: 0px 0px 22px rgba(254, 242, 100, 0.08);

         width: 222px;

         display: flex;
         flex-direction: column;
     }
     modal-change-deamon modal-change-deamon-impure-area {
         height: 100%;
     }
     modal-change-deamon .control-area {
         display: flex;
         justify-content: space-between;
         margin-top: 11px;
     }
    </style>
</modal-change-deamon>
