<page-impure-card-angel style="width:{w()}px; height:{h()}px;">

    <div style="display:flex; flex-direction:column; height:100%;">
        <div style="flex-grow: 1;display: flex;align-items: center; flex-direction:column; justify-content: center;">
            <p style="text-align: center;font-size: 33px;font-weight: bold;">
                {angelName()}
            </p>
            <p>
                <span style="font-size:14px;">{maledictName()}</span>
            </p>
        </div>

        <div style="text-align: right;">
            <button class="button is-small">依頼</button>
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
     this.angelName = () => {
         if (!this.opts.source.angel)
             return '';

         return this.opts.source.angel.name;
     };
     this.maledictName = () => {
         let maledict = this.opts.source.maledict;

         if (!maledict)
             return '';

         return '(' + maledict.name + ')';
     };
    </script>

    <style>
     page-impure-card-angel {
         display: block;
         width:  calc(88px * 2 + 11px * 1);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;
     }
    </style>
</page-impure-card-angel>
