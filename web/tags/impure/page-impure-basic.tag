<page-impure-basic>

    <h1 class="title is-4" style="margin-bottom: 8px;">Maledict</h1>

    <div class="contents" style="font-weight:bold; padding-left:22px;">
        <p>{maledict()} @{maledict_angel()}</p>
    </div>

    <h1 class="title is-4" style="margin-bottom: 8px;">Name</h1>

    <div class="contents" style="font-weight:bold; padding-left:22px;">
        <p>{name()}</p>
    </div>

    <h1 class="title is-4" style="margin-bottom: 8px;">Description</h1>

    <div class="contents description" style="margin-left: 22px;">
        <description-markdown source={description()}></description-markdown>
    </div>

    <script>
     this.maledict = () => {
         if (!this.opts.source.maledict)
             return '???';

         return this.opts.source.maledict.name;
     };
     this.maledict_angel = () => {
         if (!this.opts.source.angel)
             return '';

         return this.opts.source.angel.name;
     };
     this.name = () => {
         let impure = this.opts.source.impure;

         if (!impure)
             return '????????';

         return impure.name;
     };
     this.description = () => {
         let impure = this.opts.source.impure;

         if (!impure)
             return '????????';

         return impure.description;
     };
    </script>

    <style>
     page-impure-basic {
         display: block;
         flex-direction: column;
         padding: 22px;
         width:  calc(88px * 4 + 22px * 3);
         height: calc(88px * 5 + 22px * 4);
         border-radius: 8px;
         background: rgba(255,255,255,0.88);
         margin-bottom: 11px;
     }
     page-impure-basic .description {
         background: #eee;
         border-radius: 3px;
         line-height: 14px;
     }
     page-impure-basic description-markdown > div {
         padding: 22px;
     }
    </style>

</page-impure-basic>
