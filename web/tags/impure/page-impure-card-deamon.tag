<page-impure-card-deamon>

    <div>
        <p>悪魔</p>
    </div>

    <div>
        <p>{deamonNameShort()}</p>
        <p>{deamonName()}</p>
    </div>

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
     page-impure-card-deamon {
         display: block;
         width:  calc(88px * 2 + 11px * 1);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;
     }
    </style>
</page-impure-card-deamon>
