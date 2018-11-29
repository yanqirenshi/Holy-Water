<home_page_root-angels>
    <nav class="panel">
        <p class="panel-heading">Angels</p>

        <a each={data()}
           class="panel-block"
           angel-id={id}>

            <span style="width: 205px;" maledict-id={id}>
                {name}
            </span>

            <span class="operators">
                <icon-door-closed></icon-door-closed>
            </span>
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
         box-shadow: 0px 0px 8px #ffffff;
     }
     home_page_root-angels > .panel > a {
         background: #ffffff;
     }
     home_page_root-angels .move-door.close .opened-door{
         display: none;
     }
     home_page_root-angels .move-door.open .closed-door{
         display: none;
     }
    </style>
</home_page_root-angels>
