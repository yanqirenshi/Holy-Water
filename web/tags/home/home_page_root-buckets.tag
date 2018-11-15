<home_page_root-buckets>
    <nav class="panel" style="width: 222px;">
        <p class="panel-heading">Buckets</p>

        <a each={opts.data.list}
           class="panel-block {isActive(id)}"
           onclick={clickItem}
           maledict-id={id}>
            <span class="panel-icon">
                <i class="fas fa-book" aria-hidden="true"></i>
            </span>
            {name}
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
