<orthodox-doropdown style="width:100%;">

    <div class="dropdown {open ? 'is-active' : ''}" style="width:100%;">

        <div class="dropdown-trigger" style="width:100%;">
            <button class="button" style="width:100%;height: 33px;"
                    aria-haspopup="true"
                    aria-controls="dropdown-menu"
                    onclick={clickButton}>
                <span style="font-size:11px;">{orthodox ? orthodox.name : 'Choose Orthodox'}</span>

                <span class="icon is-small" style="font-size:11px;">
                    <i class="fas fa-angle-down" aria-hidden="true"></i>
                </span>
            </button>
        </div>

        <div class="dropdown-menu" style="width:100%"
             id="dropdown-menu" role="menu">

            <div class="dropdown-content">
                <a each={orthodox in orthodoxs()}
                   class="dropdown-item"
                   orthodox-id={orthodox.id}
                   onclick={selectItem}
                   style="font-size:11px;">
                    {orthodox.name}
                </a>
            </div>

        </div>
    </div>

    <script>
     this.changeOrthodox = (id) => {
         this.open = null;

         this.orthodox = STORE.get('orthodoxs.ht')[id];

         this.update();

         if (id)
             ACTIONS.fetchOrthodoxExorcists(id);
     };
    </script>

    <script>
     this.open = null;
     this.orthodox = null;
     this.exorcists = [];

     this.changeOrthodox(STORE.get('profiles.orthodox.id'));

     this.clickButton = () => {
         this.open = !this.open;
         this.update();
     };
     this.selectItem = (e) => {
         let id = e.target.getAttribute('orthodox-id');

         this.open = null;

         this.orthodox = STORE.get('orthodoxs.ht')[id];

         this.update();

         ACTIONS.fetchOrthodoxExorcists(id);
     };

    </script>

    <script>
     this.orthodoxs = () => {
         return STORE.get('orthodoxs.list');
     };
    </script>
</orthodox-doropdown>
