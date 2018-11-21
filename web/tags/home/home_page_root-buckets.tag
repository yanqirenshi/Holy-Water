<home_page_root-buckets>
    <nav class="panel" style="width: 255px; box-shadow: 0px 0px 8px #ffffff">
        <p class="panel-heading">Buckets</p>

        <a each={data()}
           class="panel-block {isActive(id)}"
           onclick={clickItem}
           maledict-id={id}
           style="background:#fff;">

            <span style="width: 177px;" maledict-id={id}>
                {name}
            </span>

            <span class="operators">
                <span class="icon" title="ここに「やること」を追加する。"
                      maledict-id={id}
                      maledict-name={name}
                      onclick={clickAddButton}>
                    <i class="far fa-plus-square" maledict-id={id}></i>
                </span>

                <span class="move-door {dragging ? 'open' : 'close'}"
                      ref="move-door"
                      dragover={mouseOver} dragenter={dragEnter} dragleave={dragLeave}>

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
     this.clickItem = (e) => {
         let target = e.target;
         let maledict = this.opts.data.ht[target.getAttribute('maledict-id')];
         this.opts.callback('select-bucket', maledict)
     };
     this.clickAddButton = (e) => {
         let target = e.target;
         let maledict = this.opts.data.ht[target.getAttribute('maledict-id')];

         this.opts.callback('open-modal-create-impure', maledict);

         e.stopPropagation();
     };
    </script>

    <script>
     this.data = () => {
         if (!this.opts.data) return [];

         return this.opts.data.list.filter((d)=>{
             return d['maledict-type']['ORDER']!=999;
         });
     };
    </script>

    <script>
     this.active_maledict = null;
     this.isActive = (id) => {
         if (!opts.select) return;

         return id==opts.select.id ? 'is-active' : ''
     }
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
     home_page_root-buckets .move-door.close .opened-door {
         display: none;
     }
     home_page_root-buckets .move-door.open .closed-door {
         display: none;
     }
     home_page_root-buckets .operators {
         width: 53px;
     }
     home_page_root-buckets .operators .icon {
         color: #cccccc;
     }
     home_page_root-buckets .operators .icon:hover {
         color: #880000;
     }
     home_page_root-buckets .operators .move-door.open .icon {
         color: #880000;
     }
    </style>
</home_page_root-buckets>
