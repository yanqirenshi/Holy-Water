<page-card_description-small style="width:{w()}px; height:{h()}px;">

    <div class="description" style="">
        <description-markdown source={opts.source}></description-markdown>
    </div>

    <div class="controller">
        <button class="button is-small"
                onclick={clickEdit}>編集</button>
    </div>

    <script>
     this.w = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(hw.htVal('size.w', this.opts), 24, 11);
     };
     this.h = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(hw.htVal('size.h', this.opts), 24, 11);
     };
    </script>

    <script>
     this.clickEdit = () => {
         this.opts.callback('open');
     }
    </script>

    <script>
     this.description = () => {
         let deamon = this.opts.source.deamon;
         if (!deamon)
             return '';

         return deamon.description;
     };
    </script>

    <style>
     page-card_description-small {
         display: flex;

         background: #fff;
         border-radius: 8px;

         display:flex;
         flex-direction:column;
     }
     page-card_description-small .description {
         flex-grow:1;
         overflow:auto;

         padding: 22px 11px 11px 11px;

         border-radius: 8px 8px 0px 0px;

         font-size:   14px;
         line-height: 14px;
     }
     page-card_description-small .controller {
         text-align: right;
         margin-top: 8px;
         margin: 8px;
     }
    </style>

</page-card_description-small>
