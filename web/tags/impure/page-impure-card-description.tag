<page-impure-card-description>

    <div>
        <p>Description</p>
    </div>

    <div class="description" style="">
        <description-markdown source={description()}></description-markdown>
    </div>

    <script>
     this.description = () => {
         if (!this.opts.source.impure)
             return '';

         return this.opts.source.impure.description;
     };
    </script>

    <style>
     page-impure-card-description {
         display:flex;
         flex-direction:column;

         width:  calc(88px * 5 + 11px * 4);
         height: calc(88px * 4 + 11px * 3);
         padding: 11px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;
     }

     page-impure-card-description .description {
         flex-grow:1;
         overflow:auto;

         padding: 11px;

         background: #eee;
         line-height: 14px;

     }
    </style>
</page-impure-card-description>
