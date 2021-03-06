<page-impure-card-status-purge 
    class={isPurgeNow() ? 'purge' : 'wait'}
    style="width:{w()}px; height:{h()}px;">

    <div style="display:flex; flex-direction:column; height:100%;">
        <div style="height:24px;">
            <p style="text-align: center;">{purgeNow()}</p>
        </div>

        <div class="tota-time">
            <div>
                <p>Total time:</p>
                <p class="tota-time-contents" style="">
                    {totalTime()}
                </p>
            </div>
        </div>
    </div>

    <script>
     this.w = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(16, null, 11);
     };
     this.h = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(8, null, 11);
     };
    </script>

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
         width:  calc(88px * 4 + 11px * 3);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         background: rgba(255,255,255,0.88);
         border-radius: 8px;
     }
     page-impure-card-status-purge.purge {
         background: rgba(254, 242, 99, 0.88);
     }
     page-impure-card-status-purge .tota-time {
         flex-grow: 1;
         display: flex;
         align-items: center;
         flex-direction:column;
     }
     page-impure-card-status-purge .tota-time-contents {
         text-align:center;
         font-size:66px;
         word-break:break-all;
         font-weight: bold;
         margin-top: -22px;
     }
    </style>

</page-impure-card-status-purge>
