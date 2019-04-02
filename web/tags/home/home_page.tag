<home_page>
    <div class="bucket-area">
        <home_maledicts data={STORE.get('maledicts')}
                                  select={maledict()}
                                  callback={callback}
                                  dragging={dragging}></home_maledicts>
        <home_angels></home_angels>

        <home_other-services></home_other-services>
    </div>

    <div class="contetns-area">
        <div style="display:flex;">
            <home_squeeze-area callback={callback}></home_squeeze-area>
            <!-- <home_close-impure-area style="margin-left:88px;margin-top:-5px;"></home_close-impure-area> -->
        </div>

        <!-- ----------------------- -->
        <!--   Impures               -->
        <!-- ----------------------- -->
        <home_impures maledict={maledict()}
                      callback={callback}
                      filter={squeeze_word}></home_impures>

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
    </script>

    <script>
     this.impure = () => {
         return STORE.get('purging.impure');
     }
     this.maledict = () => {
         return STORE.get('selected.home.maledict');
     };
    </script>

    <script>
     this.callback = (action, data) => {
         if ('open-modal-create-impure'==action)
             this.openModal(data);

         if ('close-modal-create-impure'==action)
             this.closeModal();

         if ('create-impure'==action)
             ACTIONS.createMaledictImpures(data.maledict, {
                 name: data.name,
                 description: data.description,
             });

         if ('squeeze-impure'==action) {
             this.squeeze_word = (data.trim().length==0 ? null : data);
             this.tags['home_impures'].update();
         }
     };

     STORE.subscribe((action) => {
         if (action.type=='SELECTED-HOME-MALEDICT') {

             this.update();

             let maledict = this.maledict();
             ACTIONS.fetchMaledictImpures(maledict.id);
         }

         if (action.type=='FETCHED-MALEDICTS')
             this.update();

         if (action.type=='CREATED-MALEDICT-IMPURES')
             this.closeModal();

         if (action.type=='START-TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = action.contents;
             this.tags['modal_request-impure'].update();
         }

         if (action.type=='STOP-TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = null;
             this.tags['modal_request-impure'].update();
         }

         if (action.type=='TRANSFERD-IMPURE-TO-ANGEL') {
             this.request_impure = null;
             this.tags['modal_request-impure'].update();
         }

         if (action.type=='SELECT-SERVICE-ITEM') {
             this.tags['home_maledicts'].update();
             this.tags['home_impures'].update();

             let service = action.data.selected.home.service;
             ACTIONS.fetchServiceItems(service.service, service.id);
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
         this.tags['home_modal-create-impure'].update();
     };
    </script>

    <style>
     home_page {
         height: 100%;
         width: 100%;
         padding: 22px 0px 0px 0px;
         padding-left: calc(22px + 55px);

         display: flex;
     }

     home_page > .contetns-area {
         height: 100%;
         margin-left: 11px;

         flex-grow: 1;
     }
    </style>
</home_page>
