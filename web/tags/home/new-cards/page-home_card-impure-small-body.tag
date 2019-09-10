<page-home_card-impure-small-body>

    <div class="{opts.status}">
        <page-home_card-impure-deamon-tag source={opts.source}></page-home_card-impure-deamon-tag>
        <p>
            {name()}
        </p>
    </div>

    <script>
     this.name = () => {
         let impure = this.opts.source;
         if (!impure)
             return '????????'

         return impure.name;
     };

    </script>

    <style>
     page-home_card-impure-small-body {
         display: block;
         height: 100%;
         overflow:auto;
     }
     page-home_card-impure-small-body > div {
         padding: 0px 11px 11px 11px;
     }
     page-home_card-impure-small-body > div.started {
         font-weight: bold;
         text-shadow: 0px 0px 22px rgba(254, 242, 99, 0.666);
     }
     page-home_card-impure-small-body > div > p {
         word-break: break-all;
         display: inline;
     }
    </style>

</page-home_card-impure-small-body>
