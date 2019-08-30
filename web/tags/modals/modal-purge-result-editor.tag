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
                                <input class="input" type="datetime" value={date2str(getVal('purge_start'))} ref="start">
                            </p>
                            <div style="padding-top: 5px;">
                                <button class="button is-small"                        action="now"                onclick={clickSetDate}>今</button>
                                <button class="button is-small {isHide('before-end')}" action="before-end"         onclick={clickSetDate}>前の作業の終了</button>
                                <button class="button is-small"                        action="clear-under-hour"   onclick={clickSetDate}>分と秒をクリア</button>
                                <button class="button is-small"                        action="clear-under-minute" onclick={clickSetDate}>秒をクリア</button>
                                <button class="button is-small is-warging"             action="revert-start"       onclick={clickSetDate}>元に戻す</button>
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
                                <div style="padding-top: 5px;">
                                    <button class="button is-small"                         action="now"                onclick={clickSetDate}>今</button>
                                    <button class="button is-small {isHide('after-start')}" action="after-start"        onclick={clickSetDate}>後の作業の開始</button>
                                    <button class="button is-small"                         action="clear-under-hour"   onclick={clickSetDate}>分と秒をクリア</button>
                                    <button class="button is-small"                         action="clear-under-minute" onclick={clickSetDate}>秒をクリア</button>
                                    <button class="button is-small is-warging"              action="revert-end"         onclick={clickSetDate}>元に戻す</button>
                                </div>
                            </p>
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
         // TODO: 手抜きです。汎用性はないっす。あ
         let input = target.parentNode.parentNode.firstElementChild.firstElementChild;
         let action = target.getAttribute('action');

         let value = () => {
             if (action=='now')
                 return moment();

             if (action=='after-start')
                 return this.opts.source.after_start;

             if (action=='before-end')
                 return this.opts.source.before_end;

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
