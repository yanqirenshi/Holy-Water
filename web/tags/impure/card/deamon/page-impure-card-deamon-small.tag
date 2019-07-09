<page-impure-card-deamon-small>

    <div style="width:{w()}px; height:{h()}px;">

        <div style="display: flex;flex-grow: 1;align-items: center; justify-content: center;">

            <p style="text-align:center;">
                <b>{deamonNameShort()}</b>
                <br/>
                {deamonName()}
            </p>

        </div>

        <div style="text-align: right;">
            <button class="button is-small" onclick={clickEdit}>変更</button>
        </div>
    </div>

    <script>
     this.clickEdit = () => {
         this.opts.callback('open-deamon');
     };
    </script>

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
     this.deamonName = () => {
         if (!this.opts.source.deamon)
             return '';

         return this.opts.source.deamon.name;
     };
     this.deamonNameShort = () => {
         if (!this.opts.source.deamon)
             return '';

         return this.opts.source.deamon.name_short;
     };
    </script>

    <style>
     page-impure-card-deamon-small > div {
         display: flex;
         flex-direction: column;
         height: 100%;

         padding: 11px;
         background: rgba(22, 22, 14, 0.88);;
         color: #e83929;
         font-weight: bold;

         border-radius: 8px;
     }
    </style>

</page-impure-card-deamon-small>
