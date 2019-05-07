<modal_request-impure>

    <div class="modal {opts.source ? 'is-active' : ''}">
        <div class="modal-background"
             onclick={clickClose}></div>

        <div class="modal-content">

            <div class="card">
                <header class="card-header">
                    <p class="card-header-title">
                        Request Impure
                    </p>
                </header>

                <div class="card-content">
                    <div class="content">

                        <div class="field">
                            <label class="label">依頼内容</label>

                            <modal_request-impure-detail source={opts.source}></modal_request-impure-detail>
                        </div>

                        <div class="field">
                                <label class="label">お願い文章を書いてください。(必須ではありません)</label>
                                <textarea ref="message"
                                          class="textarea is-small"
                                          placeholder="一言あるだけで気分が大分変りますので。"></textarea>
                        </div>

                    </div>

                    <div class="field" style="margin-top: -14px; padding-left: 22px;">
                        <p class="label is-small">お願い文章 の定型文。</p>
                        <modal_request-impure-default-msgs callback={callback}></modal_request-impure-default-msgs>
                    </div>


                    <div style="overflow: hidden;">
                        <a class="button is-danger"
                           style="float:left;"
                           onclick={clickClose}>Cancel</a>

                        <a class="button is-primary"
                           style="float:right;"
                           onclick={clickCommit}>Request</a>
                    </div>

                </div>
            </div>

            <button class="modal-close is-large"
                    aria-label="close"
                    onclick={clickClose}></button>
        </div>

    </div>

    <script>
     this.val = (name, key) => {
         if (!opts.source || !opts.source[name])
             return null;

         let obj = opts.source[name];

         return obj[key];
     };
     this.callback = (action, data) => {
         if (action=='add-template-to-msg') {
             let message_area = this.refs.message;
             let pos = message_area.selectionStart;

             let message = message_area.value;
             var befor = message.substr(0, pos);
             var after = message.substr(pos);

             let message_add = data.message;
             message_area.value = befor + message_add + after;

             let new_post = (befor + message_add).length;

             message_area.selectionStart = new_post;
             message_area.selectionEnd   = new_post;
             message_area.focus();

             return;
         }
     };
    </script>

    <script>
     this.clickCommit = () => {
         ACTIONS.transferImpureToAngel(
             this.opts.source.impure,
             this.opts.source.angel,
             this.refs.message.value.trim(),
         );
     };
     this.clickClose = () => {
         ACTIONS.stopTransferImpureToAngel();
     };
    </script>
</modal_request-impure>
