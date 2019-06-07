<hw-card_impure-waiting-for class="hw-box-shadow {cardSize()}">

    <hw-card_impure-waiting-for_small source={opts.source}></hw-card_impure-waiting-for_small>

    <script>
     this.cardSize = () => {
         return this.opts.open ? 'large' : 'small';
     };
    </script>

    <style>
     hw-card_impure-waiting-for {
         display: flex;
         flex-direction: column;
         align-items: stretch;

         border-radius: 5px;
         border: 1px solid #dddddd;

         background: #ffffff;
     }
     /* Card Size */
     hw-card_impure-waiting-for.small {
         width: 188px;
         height: 188px;
     }
     hw-card_impure-waiting-for.large {
         width: calc(222px + 222px + 222px + 22px + 22px);
         height: calc(188px + 188px + 22px + 1px);
     }
    </style>

</hw-card_impure-waiting-for>
