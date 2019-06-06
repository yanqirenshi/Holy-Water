<hw-card>

    <impure-card if={opts.source._class=="IMPURE"}
                 source={opts.source}
                 maledict={opts.maledict}
                 open={opts.open}
                 callbacks={opts.callbacks}></impure-card>

    <hw-card_impure-waiting-for if={opts.source._class=="IMPURE_WAITING-FOR"}
                                source={opts.source}
                                maledict={opts.maledict}
                                open={opts.open}
                                callbacks={opts.callbacks}></hw-card_impure-waiting-for>

</hw-card>
