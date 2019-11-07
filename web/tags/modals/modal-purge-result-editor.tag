<modal-purge-result-editor>

    <div class="modal {opts.data ? 'is-active' : ''}">
        <div class="modal-background"></div>
        <div class="modal-card">

            <header class="modal-card-head" style="padding: 11px 22px; font-size: 18px;">
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
                                <input class="input is-static" type="text" value={getVal('elapsed_time')} readonly>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="field is-horizontal">
                    <div class="field-label is-normal">
                        <label class="label">開始</label>
                    </div>
                    <div class="field-body">
                        <div class="field">
                            <p class="control">
                                <input class="input"
                                       type="datetime"
                                       value={date2str(getVal('purge_start'))}
                                       ref="start">
                            </p>
                            <div style="padding-top: 5px;">
                                <modal-purge-result-editor-dtcon source={this.opts.source}
                                                                 code="before-end"
                                                                 target="start"
                                                                 click-set-date={clickSetDate}></modal-purge-result-editor-dtcon>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="field is-horizontal">
                    <div class="field-label is-normal">
                        <label class="label">終了</label>
                    </div>
                    <div class="field-body">
                        <div class="field">
                            <p class="control">
                                <input class="input" type="datetime" value={date2str(getVal('purge_end'))} ref="end">
                            </p>
                            <div style="padding-top: 5px;">
                                <modal-purge-result-editor-dtcon source={this.opts.source}
                                                                 code="before-start"
                                                                 target="end"
                                                                 click-set-date={clickSetDate}></modal-purge-result-editor-dtcon>
                            </div>
                        </div>
                    </div>
                </div>

            </section>

            <footer class="modal-card-foot" style="padding: 11px 22px; display:flex; justify-content: space-between;">
                <button class="button is-small" action="close-purge-result-editor" onclick={clickButton}>Cancel</button>
                <button class="button is-small is-success" action="save-purge-result-editor" onclick={clickButton}>Save</button>
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
             id: this.opts.data.purge_id,
             start: stripper.str2date(this.refs.start.value),
             end: stripper.str2date(this.refs.end.value)
         })
     };
     this.clickSetDate = (e) => {
         let target = e.target;
         let input = this.refs[target.getAttribute('target')];
         let action = target.getAttribute('action');

         let value = () => {
             if (action=='now')
                 return moment();

             if (action=='after-start')
                 return this.opts.source.after_start;

             if (action=='before-end') {
                 return this.opts.source.before_end;
             }

             if (action=='revert-start')
                 return this.opts.data.purge_start;

             if (action=='revert-end') {
                 return this.opts.data.purge_end;
             }

             if (action=='clear-under-hour')
                 return moment(input.value).startOf('hour');

             if (action=='clear-under-minute')
                 return moment(input.value).startOf('minute');

             throw Error('Not Supported yet. action=' + action) ;
         };

         input.value = moment(value()).format('YYYY-MM-DD HH:mm:ss');
     };
    </script>

    <script>
     this.isHide = (code) => {
         if (code=='after-start')
             return this.opts.source.after_start ? '' : 'hide';

         if (code=='before-end')
             return this.opts.source.before_end ? '' : 'hide';
     };
     this.getVal = (key) => {
         let data = this.opts.data;

         if (!data)
             return '';

         if (key=='elapsed_time')
             return new TimeStripper().format_sec(data[key]);

         return data[key];
     };
     this.date2str = (date) => {
         if (!date) return '';

         return moment(date).format("YYYY-MM-DD HH:mm:ss");
     };
    </script>
</modal-purge-result-editor>
