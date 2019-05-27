<home_page>
    <div class="bucket-area">
        <home_maledicts data={STORE.get('maledicts')}
                                  select={maledict()}
                                  callback={callback}
                                  dragging={dragging}></home_maledicts>
        <home_orthodox-angels></home_orthodox-angels>

        <home_other-services></home_other-services>
    </div>

    <div class="contetns-area">
        <div style="display:flex;">
            <home_squeeze-area callback={callback}></home_squeeze-area>
            <home_request-area></home_request-area>
        </div>

        <!-- ----------------------- -->
        <!--   Impures               -->
        <!-- ----------------------- -->
        <home_impures maledict={maledict()}
                      callback={callback}
                      filter={squeeze_word}
                      source={impures}></home_impures>

        <!-- ----------------------- -->
        <!--   Other Service Items   -->
        <!-- ----------------------- -->
        <home_servie-items></home_servie-items>
    </div>

    <home_modal-create-impure open={modal_open}
                              callback={callback}
                              maledict={modal_maledict}></home_modal-create-impure>

    <modal_request-impure source={request_impure}></modal_request-impure>

    <script>
     this.modal_open     = false;
     this.modal_maledict = null;
     this.maledict       = null; //選択された maledict
     this.squeeze_word   = null;
     this.request_impure = null;
     this.impures        = [];
    </script>

    <script>
     this.impure = () => {
         return STORE.get('purging.impure');
     }
     this.maledict = () => {
         return STORE.get('selected.home.maledict');
     };
     this.fetchPageData = (maledict_in) => {
         let maledict = maledict_in || this.maledict();

         ACTIONS.fetchPagesImpures(maledict.id);
     };
    </script>

    <script>
     this.callback = (action, data) => {
         if ('open-modal-create-impure'==action) {
             let maledict = data;

             ACTIONS.openModalCreateImpure(maledict);
         }

         if ('squeeze-impure'==action) {
             this.squeeze_word = (data.trim().length==0 ? null : data);
             this.tags['home_impures'].update();
         }
     };

     STORE.subscribe((action) => {
         if (action.type=='MOVED-IMPURE' ||
             action.type=='FINISHED-IMPURE' ||
             action.type=='STARTED-ACTION' ||
             action.type=='STOPED-ACTION' ||
             action.type=='SAVED-IMPURE' ||
             action.type=='SETED-IMPURE-DEAMON') {

             this.fetchPageData();

             return;
         }

         if (action.type=='FETCHED-PAGES-IMPURES') {
             this.impures = action.response.impures;
             this.update();

             return;
         }

         if (action.type=='SELECTED-HOME-MALEDICT') {
             this.fetchPageData();

             return;
         }

         if (action.type=='CREATED-MALEDICT-IMPURE') {
             let maledict_selected = this.maledict();

             if (action.maledict.id == maledict_selected.id)
                 this.fetchPageData(maledict_selected);
         }

         if (action.type=='START-TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = action.contents;
             this.update();

             return;
         }

         if (action.type=='STOP-TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = null;
             this.update();

             return;
         }

         if (action.type=='TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = null;
             this.fetchPageData();

             return;
         }

         if (action.type=='SELECT-SERVICE-ITEM') {
             this.tags['home_maledicts'].update();
             this.tags['home_impures'].update();

             let service = action.data.selected.home.service;
             ACTIONS.fetchServiceItems(service.service, service.id);

             return;
         }
     });

     this.on('mount', () => {
         ACTIONS.fetchMaledicts();
         ACTIONS.fetchAngels();
     });
    </script>

    <script>
     this.openModal = (maledict) => {
         this.modal_open = true;
         this.modal_maledict = maledict;

         this.tags['home_modal-create-impure'].update();
     };
     this.closeModal = () => {
         this.modal_open = false;

         this.update();
     };
    </script>

    <style>
     home_page {
         height: 100%;
         width: 100%;
         padding: 22px 0px 0px 22px;

         display: flex;
     }

     home_page > .contetns-area {
         height: 100%;
         margin-left: 11px;

         flex-grow: 1;
     }
     home_page home_squeeze-area {
         margin-right: 55px;
     }
    </style>
</home_page>
