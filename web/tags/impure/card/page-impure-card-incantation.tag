<page-impure-card-incantation style="width:{w()}px; height:{h()}px;">

    <div class="header">
        <p><b>呪文詠唱:</b> {angelName()}</p>
    </div>

    <div class="description">
        <description-markdown source={spell()}></description-markdown>
    </div>

    <div class="hw-card-footer">
        <p>{time()}</p>
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
     this.time = () => {
         let time = moment(this.opts.source.incantation_at);

         return time.format('YYYY-MM-DD HH:mm (ddd)');
     };
     this.angelName = () => {
         return this.opts.source.angel_name;
     };
     this.spell = () => {
         return this.opts.source.spell;
     };
    </script>

    <style>
     page-impure-card-incantation {
         display:flex;
         flex-direction:column;
         height:100%;

         background: rgba(255,255,255,0.88);;
         border-radius: 8px;

         font-size: 12px;
     }
     page-impure-card-incantation .header {
         background:#cee4ae;
         padding:8px 11px;
         margin-bottom: 6px;
         border-radius: 8px 8px 0px 0px;
     }
     page-impure-card-incantation .description {
         word-break: break-all;
         flex-grow: 1;
         overflow: auto;
         padding-left: 8px;
         padding-right: 8px;
     }
     page-impure-card-incantation .hw-card-footer {
         font-size:8px;
         text-align:right;
         padding: 8px 8px 0px 0px;
         color: #aaaaaa;
     }
    </style>
</page-impure-card-incantation>
