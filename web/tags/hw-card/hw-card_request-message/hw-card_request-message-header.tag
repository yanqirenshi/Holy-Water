<hw-card_request-message-header>
    <hw-card-label-angel-from angel_name={opts.source.obj.angel_from_name}></hw-card-label-angel-from>
    <span>{timestamp()}</span>

    <script>
     this.timestamp = () => {
         return moment(opts.source.obj.requested_at).format(
             opts.source.open ? 'YYYY-MM-DD HH:mm:ss dddd' : 'MM-DD HH:mm'
         )
     };
    </script>

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
