<page-impure>

    <section class="section" style="padding-bottom: 22px;">
        <div class="container">
            <h1 class="title hw-text-white">{this.name()}</h1>
            <h2 class="subtitle hw-text-white">
                <section-breadcrumb></section-breadcrumb>
            </h2>
        </div>
    </section>

    <section class="section" style="padding-top:0px;">
        <div class="container">
            <div style="display: flex;">
                <div style="flex-grow: 1;">
                    <page-impure-contents source={source}></page-impure-contents>
                </div>

                <div style="margin-left:22px;">
                    <page-impure-controller source={term}
                                            impure={source.impure}
                                            callback={callback}></page-impure-controller>
                </div>
            </div>
        </div>
    </section>

    <script>
     this.callback = (action, data) => {
         if (action=='refresh') {
             let id = this.id();

             ACTIONS.fetchPagesImpure({ id: id });
             return ;
         }

         if (action=='stop') {
             ACTIONS.stopImpure(this.source.impure);
             return ;
         }

         if (action=='start') {
             ACTIONS.startImpure(this.source.impure);
             return ;
         }

         if (action=='attain') {
             ACTIONS.confirmationAttainImpure(this.source.impure);
             return ;
         }

         if (action=='spell') {
             ACTIONS.openModalSpellImpure(this.source.impure);
             return ;
         }

         if (action=='create-after') {
             let impure = Object.assign({}, this.source.impure);

             if(this.source.deamon)
                 impure.deamon = Object.assign({}, this.source.deamon);

             ACTIONS.openModalCreateAfterImpure(impure);
             return ;
         }
     };
    </script>

    <script>
     this.term = {
         from: moment().add('month', -1),
         to:   moment(),
     }
    </script>

    <script>
     this.id = () => {
         return location.hash.split('/').reverse()[0];
     }
     this.name = () => {
         let impure = this.source.impure;
         if (impure)
             return impure.name;

         return '';
     };
    </script>


    <script>
     this.source = {
         impure: null,
         purges: [],
         spells: [],
         requests: [],
     };

     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PAGES-IMPURE') {
             this.source = action.response;
             this.update();

             return;
         }

         let list = [
             'STARTED-ACTION',
             'STOPED-ACTION',
             'FINISHED-IMPURE',
             'SAVED-IMPURE-INCANTATION-SOLO',
         ];

         if (list.find((d) => { return d == action.type; })) {
             if (action.impure.id==this.source.impure.id)
                 ACTIONS.fetchPagesImpure(this.source.impure);

             return;
         }
     });
     this.on('mount', () => {
         let id = this.id();

         ACTIONS.fetchPagesImpure({ id: id });
         ACTIONS.fetchImpure(id);
     });
    </script>

    <style>
     page-impure page-tabs li a{
         background: #fff;
     }
    </style>

    <style>
     page-impure {
         width: 100%;
         height: 100%;
         display: block;
         overflow: auto;
     }
    </style>

    <style>
     page-impure .tabs ul {
         border-bottom-color: rgb(254, 242, 99);
         border-bottom-width: 2px;
     }
     page-impure .tabs.is-boxed li.is-active a {
         background-color: rgba(254, 242, 99, 1);
         border-color: rgb(254, 242, 99);

         text-shadow: 0px 0px 11px #fff;
         color: #333;
         font-weight: bold;
     }
     page-impure .tabs.is-boxed  li {
         margin-left: 8px;
     }
     page-impure .tabs.is-boxed a {
         text-shadow: 0px 0px 8px #fff;
         font-weight: bold;
     }
     page-impure .table th, page-impure .table td {
         font-size: 14px;
     }
    </style>
</page-impure>
