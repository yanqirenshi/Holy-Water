<deamon-page-card>

    <page-card_description         if={typeIs('DEAMON-DESCRIPTION')} source={description()}        callback={childrenCallback}></page-card_description>
    <deamon-page-card_name-short   if={typeIs('DEAMON-CODE')}        source={opts.source.contents} callback={opts.callback}></deamon-page-card_name-short>
    <deamon-page-card_elapsed-time if={typeIs('ELAPSED-TIME')}       source={opts.source.contents} callback={opts.callback}></deamon-page-card_elapsed-time>
    <deamon-page-card_impure       if={typeIs('IMPURES')}            source={opts.source.contents} callback={opts.callback}></deamon-page-card_impure>
    <!-- <deamon-page-card_purges      if={} source={opts.source}></deamon-page-card_purges> -->

    <script>
     this.description = () => {
         let deamon = opts.source.contents.deamon;

         if (!deamon)
             return '';

         return deamon.description;
     };
     this.childrenCallback = (action, data) => {
         if (action=='save-description') {
             ACTIONS.updateDeamonDescription(opts.source.contents.deamon,
                                             data.contents);

             return;
         }
         if (action=='refresh') {
             this.opts.callback('refresh');

             return;
         }
     };
    </script>


    <script>
     this.typeIs = (code) => {
         return this.opts.source.type == code;
     };
    </script>

</deamon-page-card>
