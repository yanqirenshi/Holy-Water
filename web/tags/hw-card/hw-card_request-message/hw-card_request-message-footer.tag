<hw-card_request-message-footer>
    <button class="button is-small" onclick={switchOpen}>
        {this.opts.source.open ? '閉じる' : '開く'}
    </button>

    <script>
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
         justify-content: flex-end;

         padding-top:8px;
         padding-right:11px;
     }
     hw-card_request-message-footer .button {
         border: none;
     }
    </style>
</hw-card_request-message-footer>
