<hw-card>

    <hw-card-impure if={opts.source._class=="IMPURE"}
                 source={opts.source}
                 maledict={opts.maledict}
                 open={opts.open}
                 callbacks={opts.callbacks}></hw-card-impure>

    <hw-card_impure-waiting-for if={opts.source._class=="IMPURE_WAITING-FOR"}
                                source={source()}></hw-card_impure-waiting-for>

    <hw-card_request-message if={opts.source._class=="REQUEST-MESSAGE"}
                             source={source()}></hw-card_request-message>


    <script>
     this.source = () => {
         return {
             obj: opts.source,
             maledict: opts.maledict,
             open: opts.open,
             callbacks: opts.callbacks,
         }
     };
    </script>
</hw-card>
