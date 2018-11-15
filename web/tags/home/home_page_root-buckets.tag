<home_page_root-buckets>
    <nav class="panel" style="width: 255px;">
        <p class="panel-heading">Buckets</p>

        <a each={opts.data.list}
           class="panel-block {isActive(id)}"
           onclick={clickItem}
           maledict-id={id}
           style="background:#fff;">

            <span style="width: 177px;" maledict-id={id}>
                {name}
            </span>

            <span style="width: 53px;">
                <span class="move-door {dragging ? 'open' : 'close'}"
                      ref="move-door"
                      dragover={mouseOver} dragenter={dragEnter} dragleave={dragLeave}>

                    <span class="icon" title="ここに「やること」を追加する。">
                        <i class="far fa-plus-square"></i>
                    </span>

                    <span class="icon closed-door">
                        <i class="fas fa-door-closed"></i>
                    </span>

                    <span class="icon opened-door">
                        <i class="fas fa-door-open"></i>
                    </span>

                </span>
            </span>
        </a>
    </nav>

    <script>
     this.dragging = false;
    </script>

    <script>
     this.active_maledict = null;
     this.isActive = (id) => {
         return id==opts.select ? 'is-active' : ''
     }
     this.clickItem = (e) => {
         this.opts.callback('select-bucket', e.target.getAttribute('maledict-id') * 1)
     };
     STORE.subscribe((action) => {
         if (action.type=='START-DRAG-IMPURE-ICON') {
             this.dragging = true;
             this.update();
         }
         if (action.type=='END-DRAG-IMPURE-ICON') {
             this.dragging = false;
             this.update();
         }
     });
    </script>

    <style>
     home_page_root-buckets .move-door.close .opened-door{
         display: none;
     }
     home_page_root-buckets .move-door.open .closed-door{
         display: none;
     }
    </style>
</home_page_root-buckets>
