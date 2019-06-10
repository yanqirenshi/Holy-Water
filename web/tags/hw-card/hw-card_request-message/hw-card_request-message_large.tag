<hw-card_request-message_large>

    <div class="contents">

        <div>
            <h1 class="title is-6">Message</h1>
            <description-markdown source={opts.source.obj.message_contents}></description-markdown>
        </div>

        <div>
            <div>
                <h1 class="title is-6">Impure</h1>
                <p style="margin-bottom:11px; font-weight:bold;">
                    <a href="#home/impures/{opts.source.obj.impure_id}">
                        {opts.source.obj.impure_name}
                    </a>
                </p>
                <description-markdown source={opts.source.obj.impure_description}></description-markdown>
            </div>

            <div style="margin-top:11px;">
                <h1 class="title is-6">Deamon</h1>
                <p>{this.opts.source.obj.deamon_name} ({this.opts.source.obj.deamon_name_short})</p>
            </div>
        </div>

    </div>

    <style>
     hw-card_request-message_large .contents {
         display: flex;

         height: 331px;
         padding: 11px 22px;
         font-size: 12px;

         word-break: break-all;
     }
     hw-card_request-message_large .contents > * {
         width:50%;
         overflow: auto;
     }
     hw-card_request-message_large .contents .title {
         margin-bottom: 8px;
     }
    </style>

</hw-card_request-message_large>
