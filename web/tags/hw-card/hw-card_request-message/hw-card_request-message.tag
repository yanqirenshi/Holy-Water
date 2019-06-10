<hw-card_request-message class="hw-box-shadow {cardSize()}">

    <hw-card_request-message-header source={opts.source}></hw-card_request-message-header>

    <hw-card_request-message_small if={!opts.source.open} source={opts.source}></hw-card_request-message_small>
    <hw-card_request-message_large if={opts.source.open}  source={opts.source}></hw-card_request-message_large>

    <hw-card_request-message-footer source={opts.source}></hw-card_request-message-footer>

    <script>
     this.cardSize = () => {
         return this.opts.source.open ? 'large' : 'small';
     };
    </script>

    <style>
     hw-card_request-message {
         display: flex;
         flex-direction: column;
         align-items: stretch;

         border-radius: 5px;
         border: 1px solid #dddddd;

         background: #ffffff;
     }
     hw-card_request-message > hw-card_request-message_small {
         flex-grow: 1;
     }
     hw-card_request-message > hw-card_request-message_large {
         flex-grow: 1;
     }
     /* Card Size */
     hw-card_request-message.small {
         width: 188px;
         height: 188px;
     }
     hw-card_request-message.large {
         width: calc(222px + 222px + 222px + 22px + 22px);
         height: calc(188px + 188px + 22px + 1px);
     }
    </style>

</hw-card_request-message>
