<hw-card_request-message-header>
    <hw-card-label-angel-from angel_name={opts.source.obj.angel_from_name}></hw-card-label-angel-from>
    <span>{moment(opts.source.obj.requested_at).format('MM-DD HH:mm')}</span>

    <style>
     hw-card_request-message-header {
         display: flex;
         justify-content: space-between;

         padding: 6px;
         font-size: 12px;
         border-bottom: 1px solid #eeeeee;
     }
    </style>
</hw-card_request-message-header>
