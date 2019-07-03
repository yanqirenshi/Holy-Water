<page-impure-card-status-purge class={isPurgeNow() ? 'purge' : 'wait'}>

    <div style="display:flex; flex-direction:column; height:100%;">
        <div style="height:24px;">
            <p style="text-align: center;">{purgeNow()}</p>
        </div>

        <div style="flex-grow:1;display: flex;align-items: center; flex-direction:column;">
            <div>
                <p>Total time:</p>
                <p style="text-align:center; font-size:55px; word-break:break-all; font-weight: bold;">
                    {totalTime()}
                </p>
            </div>
        </div>
    </div>

    <script>
     this.totalTime = () => {
         let time = this.opts.source.purges.reduce((a, b) => {
             return a + b.elapsed_time
         }, 0);

         return new HolyWater().int2hhmmss(time);
     }
     this.isPurgeNow = () => {
         let impure = this.opts.source.impure;

         if (!impure)
             return false;

         if (!impure.purge)
             return false;

         return true;
     };
     this.purgeNow = () => {
         let impure = this.opts.source.impure;

         if (!impure)
             return 'Purge';

         if (!impure.purge)
             return 'Purge';

         return 'Purging';
     };
    </script>

    <style>
     page-impure-card-status-purge {
         display: block;
         width:  calc(88px * 3 + 11px * 2);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         background: rgba(255,255,255,0.88);
         border-radius: 8px;
     }
     page-impure-card-status-purge.purge {
         background: rgba(254, 242, 99, 0.88);
     }
    </style>

</page-impure-card-status-purge>
