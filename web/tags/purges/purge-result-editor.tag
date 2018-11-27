<purge-result-editor>
    <div class="modal {opts.data ? 'is-active' : ''}">
        <div class="modal-background"></div>
        <div class="modal-card">
            <header class="modal-card-head">
                <p class="modal-card-title">作業時間の変更</p>
                <button class="delete"
                        aria-label="close"
                        action="close-purge-result-editor"
                        onclick={clickButton}></button>
            </header>

            <section class="modal-card-body">

                <div class="field is-horizontal">
                    <div class="field-label is-normal">
                        <label class="label">Impure</label>
                    </div>
                    <div class="field-body">
                        <div class="field">
                            <p class="control">
                                <input class="input is-static" type="text" value={getVal('impure_name')} readonly>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="field is-horizontal">
                    <div class="field-label is-normal">
                        <label class="label">作業時間</label>
                    </div>
                    <div class="field-body">
                        <div class="field">
                            <p class="control">
                                <input class="input is-static" type="text" value={getVal('elapsed-time')} readonly>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="field is-horizontal">
                    <div class="field-label is-normal">
                        <label class="label">Start</label>
                    </div>
                    <div class="field-body">
                        <div class="field">
                            <p class="control">
                                <input class="input" type="datetime" value={date2str(getVal('start'))} ref="start">
                            </p>
                        </div>
                    </div>
                </div>

                <div class="field is-horizontal">
                    <div class="field-label is-normal">
                        <label class="label">End</label>
                    </div>
                    <div class="field-body">
                        <div class="field">
                            <p class="control">
                                <input class="input" type="datetime" value={date2str(getVal('end'))} ref="end">
                            </p>
                        </div>
                    </div>
                </div>

            </section>

            <footer class="modal-card-foot">
                <button class="button is-success" action="save-purge-result-editor" onclick={clickButton}>Save changes</button>
                <button class="button" action="close-purge-result-editor" onclick={clickButton}>Cancel</button>
            </footer>
        </div>
    </div>

    <script>
     this.clickButton = (e) => {
         let action = e.target.getAttribute('action');

         if (action != 'save-purge-result-editor') {
             this.opts.callback(action);
             return;
         }

         let stripper = new TimeStripper();

         this.opts.callback(action, {
             id: this.opts.data.id,
             start: stripper.str2date(this.refs.start.value),
             end: stripper.str2date(this.refs.end.value)
         })
     };
    </script>

    <script>
     this.getVal = (key) => {
         let data = this.opts.data;

         if (!data)
             return '';

         if (key=='elapsed-time')
             return new TimeStripper().format_elapsedTime(this.opts.data.start, this.opts.data.end);

         return data[key];
     };
     this.date2str = (date) => {
         if (!date) return '';

         return moment(date).format("YYYY-MM-DD HH:mm:ss");
     };
    </script>
</purge-result-editor>
