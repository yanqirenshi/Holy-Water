<orthodox-page class="page-contents">

    <div class="flex-container">

        <div class="angels-list">
            <orthodox-page-angels-list source={source}></orthodox-page-angels-list>
        </div>

        <div class="basic-info">
            <orthodox-page-basic-info source={source}></orthodox-page-basic-info>
        </div>

    </div>

    <script>
     this.source = {
         angels: [],
         duties: [],
         orthodox: null
     };
     this.orthodox = () => {
         let id = location.hash.split('/').reverse()[0];

         return STORE.get('orthodoxs.ht.' + id);
     };
     this.on('mount', () => {
         ACTIONS.fetchPagesOrthodox(this.orthodox());
     });
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-ORTHODOX') {
             this.source = action.response;
             this.update();

             return;
         }
     });
    </script>

    <style>
     orthodox-page .flex-container {
         display: flex;
         padding: 55px; 222px;
         justify-content: center;
     }
     orthodox-page .flex-container > * {
         display: block;
     }
     orthodox-page .flex-container > .angels-list {
         flex-grow: 1;
         max-width:555px;
         margin-right: 22px;
     }
     orthodox-page .flex-container > .basic-info {
         width: 333px;
     }
    </style>

</orthodox-page>
