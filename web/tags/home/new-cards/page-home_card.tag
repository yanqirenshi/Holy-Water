<page-home_card>

    <page-home_card-impure if={draw('IMPURE')}
                           source={source()}
                           card_state={cardState()}></page-home_card-impure>

    <script>
     this.cardState = () => {
         return this.opts.card_state;
     };
     this.source = () => {
         return this.opts.source;
     };
     this.draw = (key) => {
         let source = this.source();

         if (key=='IMPURE') {
             if (!source)
                 return false;

             return source._class == "IMPURE";
         }
     };
     this.source = () => {
         return this.opts.source;
     };
    </script>

</page-home_card>
