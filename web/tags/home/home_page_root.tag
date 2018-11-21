<home_page_root>
    <div class="bucket-area">
        <home_page_root-buckets data={STORE.get('maledicts')}
                                select={maledict}
                                callback={callback}
                                dragging={dragging}></home_page_root-buckets>
        <home_page_root-members></home_page_root-members>
    </div>

    <div class="contetns-area">
        <home_page_root-impures maledict={maledict}
                                callback={callback}></home_page_root-impures>
    </div>

    <home_page_root-operators callback={callback}
                              maledict={maledict}></home_page_root-operators>

    <home_page_root-modal-create-impure open={modal_open}
                                        callback={callback}
                                        maledict={modal_maledict}></home_page_root-modal-create-impure>

    <script>
     this.modal_open = false;
     this.modal_maledict = null;
     this.maledict = null; //選択された maledict
    </script>

    <script>
     this.callback = (action, data) => {
         if (action=='select-bucket') {
             this.maledict = data;

             this.update();

             ACTIONS.fetchMaledictImpures(data.id);
         }

         if (action=='open-modal-create-impure')
             this.openModal(data);

         if (action=='close-modal-create-impure')
             this.closeModal();

         if (action=='create-impure')
             ACTIONS.createMaledictImpures(data.maledict, {
                 name: data.name,
                 description: data.description,
             });
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-MALEDICTS') {
             this.update();
         }
         if (action.type=='CREATED-MALEDICT-IMPURES') {
             this.closeModal();
         }
     });
     this.on('mount', () => {
         ACTIONS.fetchMaledicts();
     });
    </script>

    <script>
     this.openModal = (maledict) => {
         this.modal_open = true;
         this.modal_maledict = maledict;

         this.tags['home_page_root-modal-create-impure'].update();
     };
     this.closeModal = () => {
         this.modal_open = false;
         this.tags['home_page_root-modal-create-impure'].update();
     };
    </script>

    <style>
     home_page_root {
         height: 100%;
         width: 100%;
         padding: 22px 0px 0px 22px;

         display: flex;
     }

     home_page_root > .contetns-area {
         height: 100%;
         margin-left: 11px;

         flex-grow: 1;
     }
    </style>
</home_page_root>
