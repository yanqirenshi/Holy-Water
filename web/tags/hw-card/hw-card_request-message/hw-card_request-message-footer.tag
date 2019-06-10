<hw-card_request-message-footer class="{this.opts.source.open ? 'large' : 'small'}">
    <button if={this.opts.source.open}
            class="button is-small is-danger"
            onclick={clickToReaded}>
        既読にする
    </button>

    <button class="button is-small" onclick={switchOpen}>
        {this.opts.source.open ? '閉じる' : '開く'}
    </button>

    <script>
     this.clickToReaded = () => {
         ACTIONS.changeToReadRequestMessage(opts.source.obj.message_id)
     };
     this.switchOpen = () => {
         let callback = this.opts.source.callbacks.switchSize;
         let obj = this.opts.source.obj;
         let open = this.opts.source.open;

         if (open)
             callback('small', obj);
         else
             callback('large', obj);
     };
    </script>

    <style>
     hw-card_request-message-footer {
         display: flex;

         padding-top:8px;
         padding-right:11px;
         padding-left: 11px;
     }
     hw-card_request-message-footer.large { justify-content: space-between; }
     hw-card_request-message-footer.small { justify-content: flex-end;}
     hw-card_request-message-footer .button {
         border: none;
     }
    </style>
</hw-card_request-message-footer>
