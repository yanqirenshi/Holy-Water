<page-home_card-impure>

    <page-home_card-impure-large if={isOpen()}
                                 source={opts.source}
                                 card_state={opts.card_state}
                                 is_start_action={isStart()}></page-home_card-impure-large>

    <page-home_card-impure-small if={!isOpen()}
                                 source={opts.source}
                                 card_state={opts.card_state}
                                 is_start_action={isStart()}></page-home_card-impure-small>

    <script>
     this.isStart = () => {
         if (!this.opts.source)
             return false;

         if (!this.opts.source.purge_started_at)
             return false;

         return true;
     }
     this.isStartAction = () => {
         if (!this.opts.source)
             return false;

         if (!this.opts.source.purge_started_at)
             return false;

         return true;
     };
     this.isOpen = () => {
         let id = this.opts.source.id;

         let opened = this.opts.card_state.impure.opened;

         return opened[id] ? true : false;
     };
    </script>

</page-home_card-impure>
