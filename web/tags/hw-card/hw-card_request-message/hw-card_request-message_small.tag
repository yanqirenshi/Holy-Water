<hw-card_request-message_small>

    <div class="contents" style="padding-top: 6px; overflow:auto">
        <p style="flex-grow:1;">
            {opts.source.obj.message_contents}
        </p>

        <p style="margin-top:22px; font-size:9px; flex-grow:1;">
            <hw-card-label-deamon deamon_id={opts.source.obj.deamon_id}
                                  deamon_name={opts.source.obj.deamon_name}
                                  deamon_name_short={opts.source.obj.deamon_name_short}></hw-card-label-deamon>
            <a href="#home/impures/{opts.source.obj.impure_id}">
                {opts.source.obj.impure_name}
            </a>

        </p>
    </div>

    <style>
     hw-card_request-message_small .contents {
         display: flex;
         flex-direction: column;

         padding: 11px;
         font-size: 12px;

         word-break: break-all;
     }
    </style>

</hw-card_request-message_small>
