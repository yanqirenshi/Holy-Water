<home_page_root-members>
    <nav class="panel">
        <p class="panel-heading">Members</p>

        <a each={data()}
           class="panel-block {isActive(id)}"
           maledict-id={id}>

            <span style="width: 177px;" maledict-id={id}>
                {name}
            </span>
        </a>
    </nav>

    <script>
     this.dragging = false;
    </script>

    <script>
     this.data = () => {
         return opts.data ? opts.data.list : [];
     };
    </script>

    <script>
     this.active_maledict = null;
     this.isActive = (id) => {
         return id==opts.select ? 'is-active' : ''
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
     home_page_root-members > .panel {
         width: 255px;
         margin-top: 22px;
         box-shadow: 0px 0px 8px #ffffff
     }
     home_page_root-buckets .move-door.close .opened-door{
         display: none;
     }
     home_page_root-buckets .move-door.open .closed-door{
         display: none;
     }
    </style>
</home_page_root-members>
