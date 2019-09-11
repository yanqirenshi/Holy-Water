<deamon-page-card-status
    class={isFinished() ? 'pure' : 'impure'}
    style="width:{w()}px; height:{h()}px;">

    <div style="height:100%; display:flex; align-items:center;">
        <p style="font-size:66px; font-weight:bold; word-break:break-all; text-align:center; flex-grow:1;">
            {finished()}
        </p>
    </div>

    <script>
     this.w = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(8, null, 11);
     };
     this.h = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(8, null, 11);
     };
    </script>

    <script>
     this.isFinished = () => {
         let impure = this.opts.source.deamon;

         if (!impure)
             return false;

         if (!impure.purged_at)
             return false;

         return true;
     }
     this.finished = () => {
         let state = this.isFinished();

         return state ? '清浄' : '不浄';

         return ;
     }
    </script>

    <style>
     deamon-page-card-status {
         display: block;
         width:  calc(88px * 2 + 11px * 1);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         margin-bottom: 11px;
         border-radius: 8px;
     }
     deamon-page-card-status.pure {
         background: rgba(137, 195, 235, 0.88);
         color: #fff;
     }
     deamon-page-card-status.impure {
         background: rgba(100, 1, 37, 0.88);
         color: #fff;
     }

    </style>

</deamon-page-card-status>
