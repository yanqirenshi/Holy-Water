<page-home_card-pool2>

    <div class="grid">
        <page-home_card class="grid-item" each={obj in list()} source={obj}></page-home_card>
    </div>

    <script>
     this.layout = () => {
         var elem = document.querySelector('page-home_card-pool2 > .grid');

         this.msnry = new Masonry(elem, {
             itemSelector: 'page-home_card-pool2 > .grid .grid-item',
             columnWidth: 22,
             gutter: 22,
         });
         this.msnry.layout();
     }
     this.on('updated', () => {
         this.layout();
     });
    </script>

    <script>
     this.list = () => {
         let list = this.opts.source;

         let out = list.sort((a, b) => {
             return a.id > b.id ? 1 : -1;
         });

         let keyword = this.opts.filter;
         if (this.opts.filter===null)
             return out;

         keyword = keyword.toLowerCase();
         return out.filter((d) => {
             if (d.deamon_name_short &&
                 d.deamon_name_short.toLowerCase().indexOf(keyword) >= 0)
                 return true;

             if (d.name.toLowerCase().indexOf(keyword) >= 0)
                 return true;

             return false;
         });
     };
    </script>

    <style>
     page-home_card-pool2 {
         display: block;
         width: 100%;
         padding-left: 22px;
     }
     page-home_card-pool2 .grid-item {
         margin-bottom: 22px;
     }
    </style>

</page-home_card-pool2>
