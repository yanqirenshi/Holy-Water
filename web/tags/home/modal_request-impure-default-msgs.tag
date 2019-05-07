<modal_request-impure-default-msgs>

    <button each={obj in templates}
            class="button is-small"
            val={obj.value}
            onclick={clickButton}>{obj.label}</button>

    <script>
     this.templates = [
         { label: '改行',                         value: '\n'},
         { label: 'ご確認よろしくお願いします。(改行付き)', value: 'ご確認よろしくお願いします。\n' },
         { label: 'MRレビューをお願いします。(改行付き)',   value: 'MRレビューをお願いします。\n'  },
         { label: 'ご対応よろしくお願いします。(改行付き)', value: 'ご対応よろしくお願いします。\n'  },
     ];

     this.clickButton = (e) => {
         let target = e.target;
         let msg = target.getAttribute('val') || target.textContent;

         this.opts.callback('add-template-to-msg', { message: msg });
     };
    </script>

    <style>
     modal_request-impure-default-msgs > .button {
         margin-right: 8px;
         margin-bottom: 8px;
     }
    </style>

</modal_request-impure-default-msgs>
