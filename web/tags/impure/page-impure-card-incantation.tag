<page-impure-card-incantation>

    <d>
        <p>{time()}</p>
    </d>

    <d>
        <p><b>呪文詠唱</b></p>
        <p>{angelName()}</p>
        <p>{spell()}</p>
    </d>

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
    </style>
</page-impure-card-incantation>
