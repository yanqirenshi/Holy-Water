<home_orthodox-angels>
    <nav class="panel hw-box-shadow">
        <p class="panel-heading">Exorcists</p>
        <a class="panel-block">
            <orthodox-doropdown></orthodox-doropdown>
        </a>

        <a each={obj in data()}
           class="panel-block"
           angel-id={obj.id}
           style="padding:5px 8px;">

            <span style="width:100%;font-size:11px;;" maledict-id={obj.id}>
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
         width: 188px;
         margin-top: 22px;
         border-radius: 4px 4px 0 0;
     }
     home_orthodox-angels > .panel > a {
         background: #ffffff;
     }
     home_orthodox-angels > .panel > .panel-heading {
         font-size:12px;
         font-weight: bold;
     }
    </style>
</home_orthodox-angels>
