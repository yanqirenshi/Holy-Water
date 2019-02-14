<orthodox-doropdown style="width:100%;">
    <div class="dropdown {open ? 'is-active' : ''}" style="width:100%;">
        <div class="dropdown-trigger" style="width:100%;">
            <button class="button" style="width:100%"
                    aria-haspopup="true"
                    aria-controls="dropdown-menu"
                    onclick={clickButton}>
                <span>Orthodox</span>
                <span class="icon is-small">
                    <i class="fas fa-angle-down" aria-hidden="true"></i>
                </span>
            </button>
        </div>
        <div class="dropdown-menu" style="width:100%"
             id="dropdown-menu" role="menu">
            <div class="dropdown-content">
                <a each={orthodox in orthodoxs}
                   href="" class="dropdown-item">
                    {orthodox.name}
                </a>
            </div>
        </div>
    </div>

    <script>
     this.open = false;
     this.clickButton = () => {
         this.open = !this.open;
         this.update();
     };
    </script>

    <script>
     this.orthodoxs = [
         { name: 'サーバーサイド' },
         { name: 'アプリ' },
         { name: 'ディレクター' },
     ];
    </script>
</orthodox-doropdown>
