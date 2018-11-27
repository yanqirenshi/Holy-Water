<message-item>
    <article class="message is-{opts.data.type}">
        <div class="message-header">
            <p>{opts.data.title}</p>
            <button class="delete"
                    aria-label="delete"
                    onclick={clickCloseButton}></button>
        </div>
        <div class="message-body" style="padding: 11px 22px;">
            <div class="contents" style="overflow: auto;">
                <p>{opts.data.contents}</p>
            </div>
        </div>
    </article>

    <script>
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
