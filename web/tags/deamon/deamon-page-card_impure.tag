<deamon-page-card_impure>

    <div class="small">
        <div class="header {finished()}">
            <p>
                Impure
                <span style="margin-left:11px;">
                    <a href={linkImpure()}>
                        <i class="fas fa-link"></i>
                    </a>
                </span>
            </p>
        </div>

        <div class="name">
            <p>{name()}</p>
        </div>

        <div class="elapsed-time">
            <p>{elapsedTime()}</p>
        </div>
    </div>

    <script>
     this.elapsedTime = () => {
         if (!this.opts.source.purge)
             return 0;

         return new HolyWater().int2hhmmss(this.opts.source.purge.elapsed_time_total);
     };
     this.linkImpure = () => {
         return "%s/impures/%d".format(location.hash, this.opts.source.contents.id);
     };
     this.name = () => {
         return this.opts.source.contents.name;
     };
     this.finished = () => {
         return this.opts.source.contents.finished_at ? 'finished' : '';
     };
    </script>

    <style>
     deamon-page-card_impure > .small {
         display: flex;
         flex-direction: column;

         width: calc(11px * 8 + 11px * 7);
         height: calc(11px * 8 + 11px * 7);

         margin-bottom: 11px;

         background: #fff;
         border-radius: 8px;
     }
     deamon-page-card_impure > .small > .header {
         width: 100%;
         height: 33px;

         padding: 8px 11px;
         border-radius: 8px 8px 0px 0px;

         font-size: 12px;
         font-weight: bold;

         background: rgba(100, 1, 37, 0.88);
         color: #fff;
     }
     deamon-page-card_impure > .small > .header.finished {
         background: rgba(137, 195, 235, 0.88);
     }
     deamon-page-card_impure > .small > .name {
         padding: 6px 8px;
         font-size: 14px;
         font-weight: bold;
         flex-grow: 1;

         display: flex;
         justify-content: center;
         align-items: center;
     }
     deamon-page-card_impure .small > .elapsed-time {
         text-align: center;
         font-size: 22px;
         padding-top: 8px;
     }
    </style>

</deamon-page-card_impure>
