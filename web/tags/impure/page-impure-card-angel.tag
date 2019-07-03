<page-impure-card-angel>

    <div>
        <p>祓魔師</p>
    </div>

    <div>
        <p>{angelName()}</p>
    </div>

    <script>
     this.angelName = () => {
         if (!this.opts.source.angel)
             return '';

         return this.opts.source.angel.name;
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
