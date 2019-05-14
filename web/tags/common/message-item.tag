<message-item>
    <article class="message hw-box-shadow is-{opts.data.type}">

        <div class="message-header" style="padding:8px;">
            <p class="is-small" style="font-size:12px;">{opts.data.title}</p>
            <button class="delete"
                    aria-label="delete"
                    onclick={clickCloseButton}></button>
        </div>

        <div class="message-body" style="padding: 8px;">
            <div class="contents" style="overflow: auto;">
                <p each={txt in contents()} class="is-small" style="font-size:12px;">{txt}</p>
            </div>
        </div>

    </article>

    <script>
     this.contents = () => {
         if (!opts.data || !opts.data.contents)
             return [];

         return opts.data.contents.split('\n');
     };
     this.clickCloseButton = () => {
         this.opts.callback('close-message', this.opts.data);
     };
    </script>

    <style>
     message-item > .message{
         min-height: calc(46px + 44px);
         min-width: 111px;
         max-height: 222px;
         max-width: 333px;
     }

     message-item {
         display: block;
     }
    </style>
</message-item>
