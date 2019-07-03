<page-impure-card-incantation>

    <div style="display:flex; flex-direction:column; height:100%;">

        <div style="background:#cee4ae; padding:6px 8px; margin-bottom: 6px;">
            <p><b>呪文詠唱:</b> {angelName()}</p>
        </div>

        <div class="description">
            <description-markdown source={spell()}></description-markdown>
        </div>

        <div style="font-size:8px; text-align:right;">
            <p>{time()}</p>
        </div>
    </div>

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
         display: block;
         width:  calc(88px * 2 + 11px * 1);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;

         font-size: 12px;
     }
     page-impure-card-incantation .description {
         word-break: break-all;
         flex-grow: 1;
         overflow: auto;
     }
    </style>
</page-impure-card-incantation>
