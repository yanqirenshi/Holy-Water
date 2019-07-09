<page-impure-card-status
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
         let impure = this.opts.source.impure;

         if (!impure)
             return false;

         if (!impure.finished_at)
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
     page-impure-card-status {
         display: block;
         width:  calc(88px * 2 + 11px * 1);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         border-radius: 8px;
     }
     page-impure-card-status.pure {
         background: rgba(137, 195, 235, 0.88);
         color: #fff;
     }
     page-impure-card-status.impure {
         background: rgba(100, 1, 37, 0.88);
         color: #fff;
     }

    </style>

</page-impure-card-status>
