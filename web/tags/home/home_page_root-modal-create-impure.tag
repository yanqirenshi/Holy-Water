<home_page_root-modal-create-impure>
    <div class="modal {opts.open ? 'is-active' : ''}">
        <div class="modal-background"></div>
        <div class="modal-card">
            <header class="modal-card-head">
                <p class="modal-card-title">やる事を追加</p>
                <button class="delete" aria-label="close" onclick={clickCloseButton}></button>
            </header>

            <section class="modal-card-body">
                <h4 class="title is-6">場所: {maledictName()}</h4>

                <input class="input" type="text" placeholder="Title" ref="name">

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
     this.maledictName = () => {
         return this.opts.maledict ? this.opts.maledict.name : '';
     }
    </script>

    <script>
     this.clickCreateButton = (e) => {
         this.opts.callback('create-impure', {
             name: this.refs['name'].value,
             description: this.refs['description'].value,
             maledict: this.opts.maledict
         });
     };
     this.clickCloseButton = (e) => {
         this.opts.callback('close-modal-create-impure');
     };
     this.on('update', () => {
         dump(this.opts);
     });
    </script>
</home_page_root-modal-create-impure>
