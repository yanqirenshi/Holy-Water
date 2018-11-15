<home_page_root-buckets>
    <nav class="panel" style="width: 255px;">
        <p class="panel-heading">Buckets</p>

        <a each={opts.data.list}
           class="panel-block {isActive(id)}"
           onclick={clickItem}
           maledict-id={id}>

            <span style="width: 177px;" maledict-id={id}>
                {name}
            </span>

            <span style="width: 53px;">
                <span class="icon">
                    <i class="fas fa-door-closed"></i>
                </span>
                <span class="icon hide">
                    <i class="fas fa-door-open"></i>
                </span>
                <span class="icon">
                    <i class="far fa-plus-square"></i>
                </span>
            </span>
        </a>
    </nav>

    <script>
     this.active_maledict = null;
     this.isActive = (id) => {
         return id==opts.select ? 'is-active' : ''
     }
     this.clickItem = (e) => {
         this.opts.callback('select-bucket', e.target.getAttribute('maledict-id') * 1)
     };
    </script>
</home_page_root-buckets>
