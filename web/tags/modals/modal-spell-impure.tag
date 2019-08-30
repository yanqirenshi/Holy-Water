<modal-spell-impure>

    <div class="modal {impure ? 'is-active' : ''}">
        <div class="modal-background"></div>

        <div class="modal-card" style="width: 555px;">

            <header class="modal-card-head" style="padding: 11px 22px;">
                <p class="modal-card-title" style="font-size: 14px;">呪文詠唱</p>
                <button class="delete"
                        aria-label="close"
                        onclick={clickClose}></button>
            </header>

            <section class="modal-card-body">

                <div class="contents">
                    <p><b>ID</b></p>
                    <p style="padding-left:22px;">{impure ? impure.id : ''}</p>
                    <p><b>Name</b></p>
                    <p style="padding-left:22px;">{impure ? impure.name : ''}</p>

                    <p style="margin-top:22px;"><b>呪文</b></p>
                    <div style="padding-left:22px;">
                        <textarea class="textarea"
                                  placeholder="必須入力項目"
                                  ref="spell"></textarea>
                    </div>
                </div>

            </section>

            <footer class="modal-card-foot" style="padding: 11px 22px; display:flex; justify-content: space-between;">
                <button class="button is-small" onclick={clickClose}>Cancel</button>
                <button class="button is-small is-success" onclick={clickSpell}>詠唱</button>
            </footer>
        </div>
    </div>

    <script>
     this.clickSpell = () => {
         ACTIONS.saveImpureIncantationSolo(this.impure,
                                           this.refs.spell.value.trim());
     };
     this.clickClose = () => {
         this.impure = null;
         this.update();
         return;
     };
    </script>

    <script>
     this.impure = null;
     STORE.subscribe((action) => {
         if (action.type=='OPEN-MODAL-SPELL-IMPURE') {
             this.impure = action.impure;
             this.update();
             return;
         }

         if (action.type=='SAVED-IMPURE-INCANTATION-SOLO') {
             this.impure = null;
             this.update();
             return;
         }
     });
    </script>

</modal-spell-impure>
