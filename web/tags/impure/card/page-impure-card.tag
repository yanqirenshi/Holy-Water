<page-impure-card>

    <page-card_description if={typeIs('IMPURE-DESCRIPTION')}
                           source={description()}
                           callback={callback2}
                           size={descriptionSize()}></page-card_description>

    <page-impure-card-status       if={typeIs('IMPURE-STATUS')}       source={opts.source.contents}></page-impure-card-status>
    <page-impure-card-status-purge if={typeIs('IMPURE-STATUS-PURGE')} source={opts.source.contents}></page-impure-card-status-purge>
    <page-impure-card-angel        if={typeIs('IMPURE-ANGEL')}        source={opts.source.contents}></page-impure-card-angel>

    <page-impure-card-deamon if={typeIs('IMPURE-DEAMON')}
                             source={opts.source.contents}
                             callback={callback2}
                             open={open.deamon}></page-impure-card-deamon>

    <page-impure-card-incantation  if={typeIs('IMPURE-SPELL')}        source={opts.source.contents}></page-impure-card-incantation>
    <page-impure-card-purge        if={typeIs('IMPURE-PURGE')}        source={opts.source.contents}></page-impure-card-purge>
    <page-impure-card-request      if={typeIs('IMPURE-REQUEST')}      source={opts.source.contents}></page-impure-card-request>
    <page-impure-card-network      if={typeIs('IMPURE-NETWORK')}      source={opts.source.contents}></page-impure-card-network>

    <script>
     this.open = {
         deamon: false,
         description: false,
     };
     this.descriptionSize = () => {
         return {
             small: {
                 w: 55,
                 h: 22,
             },
             large: {
                 w: 55,
                 h: 22,
             },
         };
     };
     this.description = () => {
         let impure = opts.source.contents.impure;

         if (!impure)
             return '';

         return impure.description;
     };
     this.layout = () => {
         this.opts.callback('refresh');
         return;
     };
     this.setOpen = (type, state) => {
         if (type=='deamon') {
             this.open.deamon = state;
             this.update();
             this.layout();

             return;
         }
     };
     this.callback2 = (action, data) => {
         if (action=='open-deamon') {
             this.setOpen('deamon', true);
             return;
         }

         if (action=='close-deamon') {
             this.setOpen('deamon', false);

             return;
         }

         if (action=='save-description') {
             ACTIONS.updateImpureDescription(opts.source.contents.impure,
                                             data.contents);
             return;
         }

         if (action=='refresh') {
             this.opts.callback(action);
             return;
         }
     };
     STORE.subscribe ((action) => {
         if (action.type=='SETED-IMPURE-DEAMON') {
             this.setOpen('deamon', false);

             ACTIONS.fetchPagesImpure({ id: action.impure.id });
             return;
         }
     });

    </script>

    <script>
     this.typeIs = (code) => {
         return this.opts.source.type == code;
     };
    </script>

    <style>
     page-impure-card {
         display: block;
         margin-bottom: 11px;
     }
    </style>

</page-impure-card>
