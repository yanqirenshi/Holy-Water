<home_page_root-angels>
    <nav class="panel hw-box-shadow">
        <p class="panel-heading">Exorcists</p>
        <a class="panel-block">
            <orthodox-doropdown></orthodox-doropdown>
        </a>

        <a each={obj in data()}
           class="panel-block"
           angel-id={obj.id}>

            <span style="width: 205px;" maledict-id={obj.id}>
                {obj.name}
            </span>

            <home_emergency-door source={obj}></home_emergency-door>
        </a>
    </nav>

    <script>
     this.dragging = false;
    </script>

    <script>
     this.data = () => {
         return STORE.get('angels').list;
     };
    </script>

    <script>
     this.active_maledict = null;
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ANGELS')
             this.update();
     });
    </script>

    <style>
     home_page_root-angels > .panel {
         width: 255px;
         margin-top: 22px;
         border-radius: 4px 4px 0 0;
     }
     home_page_root-angels > .panel > a {
         background: #ffffff;
     }
    </style>
</home_page_root-angels>
