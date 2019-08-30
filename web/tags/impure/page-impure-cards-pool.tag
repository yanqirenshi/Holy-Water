<page-impure-cards-pool>

    <div class="grid">
        <page-impure-card each={source in hw.pageImpureContentsList(opts.source)}
                          class="grid-item"
                          source={source}
                          callback={callback}></page-impure-card>

    </div>

    <script>
     this.hw = new HolyWater();
     this.msnry = null;
    </script>

    <script>
     this.layout = () => {
         var elem = document.querySelector('page-impure-cards-pool .grid');

         this.msnry = new Masonry(elem, {
             itemSelector: 'page-impure-cards-pool .grid-item',
             columnWidth: 11,
             gutter: 11,
         });
         this.msnry.layout();
     }
     this.callback = (action) => {
         if (action=='refresh') {

             this.layout();

             return;
         }
     };
     this.on('updated', () => {
         this.layout();
     })
     this.on('update', () => {
         this.layout();
     });
    </script>

</page-impure-cards-pool>
