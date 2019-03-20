<home_servie-items>

    <div class="items">
        <div each={obj in source()} class="item">
            <service-card-small source={obj}></service-card-small>
        </div>
    </div>

    <script>
     this.source = () => {
         return STORE.get('gitlab.list');
     };
    </script>

    <script>
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-SERVICE-ITEMS') {
             this.update();
         }
     });
    </script>

    <style>
     home_servie-items {
         overflow: auto;
         height: 100%;
         display: block;
         padding-top: 22px;
         padding-bottom: 222px;
     }
    </style>
</home_servie-items>
