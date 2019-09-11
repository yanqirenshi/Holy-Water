<deamon-page-card_elapsed-time>

    <deamon-page-card_elapsed-time-small if={!open} source={opts.source} callback={callback}></deamon-page-card_elapsed-time-small>
    <deamon-page-card_elapsed-time-large if={open}  source={opts.source} callback={callback}></deamon-page-card_elapsed-time-large>

    <script>
     this.open = false;
     this.callback = (action) => {
         if (action=='switch-small') {
             this.open = false;
             this.update();

             this.opts.callback('refresh')
             return;
         }
         if (action=='switch-large') {
             this.open = true;
             this.update();

             this.opts.callback('refresh')
             return;
         }
     };
    </script>

</deamon-page-card_elapsed-time>
