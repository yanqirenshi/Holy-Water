<modal-create-impure>

    <div class="modal {maledict ? 'is-active' : ''}">
        <div class="modal-background"></div>
        <div class="modal-card">
            <header class="modal-card-head">
                <p class="modal-card-title">やる事を追加</p>
                <button class="delete" aria-label="close" onclick={clickCloseButton}></button>
            </header>

            <section class="modal-card-body">
                <h4 class="title is-6">場所: {maledictName()}</h4>

                <div>
                    <span>接頭文字:</span>
                    <button each={prefixes}
                            class="button is-small"
                            style="margin-left: 8px;"
                            onclick={clickTitlePrefix}
                            value={label}>{label}</button>
                </div>

                <input class="input"
                       type="text"
                       placeholder="Title"
                       ref="name" style="margin-top:11px;">

                <textarea class="textarea"
                          placeholder="Description"
                          rows="6"
                          style="margin-top:11px;"
                          ref="description"></textarea>
            </section>

            <footer class="modal-card-foot">
                <button class="button" onclick={clickCloseButton}>Cancel</button>
                <button class="button is-success" onclick={clickCreateButton}>Create!</button>
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
     this.prefixes = [
         { label: 'RBP：' },
         { label: 'RBR：' },
         { label: 'GLPGSH：' },
         { label: 'HW：' },
         { label: 'WBS：' },
         { label: 'TER：' },
         { label: '人事：' },
         { label: 'Ill：' },
     ];
     this.clickTitlePrefix = (e) => {
         let prefix = e.target.getAttribute('value');

         let elem = this.refs.name
         let name = elem.value;


         let pos = name.indexOf('：');
         if (pos==-1) {
             elem.value = prefix + name;
             return;
         }

         for (let item of this.prefixes) {
             let l = item.label;
             let label_length = l.length;

             if (label_length > name.length)
                 continue;

             if (name.substring(0, label_length)==l) {
                 elem.value = prefix + name.substring(label_length);
                 return;
             }
         }

         elem.value = prefix + name;
     };
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
</modal-create-impure>
