<deamon-page-card_description>

    <deamon-page-card_description-small if={!open} source={opts.source} callback={callback}></deamon-page-card_description-small>
    <deamon-page-card_description-large if={open}  source={opts.source} callback={callback}></deamon-page-card_description-large>

    <script>
     this.open = false;
     this.callback = (action) => {
         if (action=='open') {
             this.open = true;

             this.update();

             this.opts.callback('refresh');
             return;
         }

         if (action=='close') {
             this.open = false;

             this.update();

             this.opts.callback('refresh');
             return;
         }
     };
    </script>

</deamon-page-card_description>
