<deamon-page-card_elapsed-time>

    <deamon-page-card_elapsed-time-small if={!open} source={opts.source} callback={callback}></deamon-page-card_elapsed-time-small>
    <deamon-page-card_elapsed-time-large if={open}  source={opts.source} callback={callback}></deamon-page-card_elapsed-time-large>

    <script>
     this.open = true;
     this.callback = () => {
     };
    </script>

</deamon-page-card_elapsed-time>
