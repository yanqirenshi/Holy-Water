<page-impure-contents>

    <div class="grid">
        <page-impure-card each={source in hw.pageImpureContentsList(opts.source)}
                          class="grid-item"
                          source={source}></page-impure-card>

        <!-- <page-impure-basic       class="grid-item" source={opts.source}></page-impure-basic> -->
        <!-- <page-impure-purges      class="grid-item" source={opts.source.purges}></page-impure-purges>
             <page-impure-incantation class="grid-item" source={opts.source.spells}></page-impure-incantation> -->
        <!-- <page-impure-requests    class="grid-item" source={opts.source.requests}></page-impure-requests> -->
        <page-impure-chains      class="grid-item" source={[]}></page-impure-chains>
    </div>

    <script>
     this.hw = new HolyWater();
     this.msnry = null;
    </script>

    <script>
     this.on('updated', () => {
         var elem = document.querySelector('page-impure-contents .grid');
         this.msnry = new Masonry( elem, {
             itemSelector: 'page-impure-contents .grid-item',
             columnWidth: 88,
             gutter: 11,
         });
         this.msnry.layout();
     })
     this.on('update', () => {
         if (this.msnry)
             this.msnry.layout();
     });
    </script>

</page-impure-contents>
