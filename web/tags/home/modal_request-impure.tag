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

                            <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
                                <thead>
                                    <tr> <th>Type</th> <th>ID</th> <th>Name</th></tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Impure</th>
                                        <td>{val('impure', 'id')}</td>
                                        <td>{val('impure', 'name')}</td>
                                    </tr>
                                    <tr>
                                        <th>Angel</th>
                                        <td>{val('angel', 'id')}</td>
                                        <td>{val('angel', 'name')}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="field">
                                <label class="label">お願い文章を書いてください。(必須ではありません)</label>
                                <textarea ref="message"
                                          class="textarea"
                                          placeholder="一言あるだけで気分が大分変りますので。"></textarea>
                        </div>

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
