<home_orthodox-angels>
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
     this.exorcists = [];
    </script>

    <script>
     this.data = () => {
         return this.exorcists;
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ORTHODOX-EXORCISTS') {
             this.exorcists = action.exorcists

             this.update();
         }
     });
    </script>

    <script>
     this.active_maledict = null;
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-ANGELS')
             this.update();
     });
    </script>

    <style>
     home_orthodox-angels > .panel {
         width: 255px;
         margin-top: 22px;
         border-radius: 4px 4px 0 0;
     }
     home_orthodox-angels > .panel > a {
         background: #ffffff;
     }
    </style>
</home_orthodox-angels>
