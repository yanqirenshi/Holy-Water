<page-home_card>

    <page-home_card-impure if={draw('IMPURE')} source={source()}></page-home_card-impure>

    <script>
     this.source = () => {
         return this.opts.source;
     };
     this.draw = (key) => {
         let source = this.source();

         if (key=='IMPURE') {
             if (!source)
                 return false;
             dump(source._class == "IMPURE")
             return source._class == "IMPURE";
         }
     };
     this.source = () => {
         return this.opts.source;
     };
    </script>

</page-home_card>
