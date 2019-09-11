<page-impure-card-maledict style="width:{w()}px; height:{h()}px;">

    <div style="display:flex; flex-direction:column; height:100%;">
        <div style="flex-grow: 1;display: flex;align-items: center; flex-direction:column; justify-content: center;">
            <p style="text-align: center;font-size: 33px;font-weight: bold;">
                {maledictName()}
            </p>
        </div>

        <div style="text-align: right;">
            <button class="button is-small" disabled>変更</button>
        </div>
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
     this.maledictName = () => {
         let maledict = this.opts.source.maledict;

         if (!maledict)
             return '';

         return maledict.name;
     };
    </script>

    <style>
     page-impure-card-maledict {
         display: block;
         width:  calc(88px * 2 + 11px * 1);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;
     }
    </style>
</page-impure-card-maledict>
