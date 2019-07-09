<page-card_description>

    <page-card_description-small if={!open} source={opts.source} callback={callback} size={opts.size.small}></page-card_description-small>
    <page-card_description-large if={open}  source={opts.source} callback={callback} size={opts.size.large}></page-card_description-large>

    <script>
     this.open = false;
     this.callback = (action, data) => {
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

         if (action=='save') {
             this.opts.callback('save-description', data);

             return;
         }
     };
    </script>

    <style>
     /* See: index.css, Section: page-card_description */
    </style>

</page-card_description>
