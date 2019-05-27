<impure-card-large_tab_deamon>

    <div>

        <div style="padding-left:22px; padding-right:22px;">
            <div class="selected" style="padding: 11px 22px;">
                <p>{selectedDeamon()}</p>
            </div>

            <div style="margin-top:8px; display:flex; justify-content:space-between;">
                <button class="button is-small" onclick={clickRevert} disabled={isDisabled()}>Revert</button>
                <button class="button is-small is-danger" onclick={clickSave} disabled={isDisabled()}>Save</button>
            </div>
        </div>

        <div class="selector">
            <h1 class="title is-5">Select Deamon:</h1>

            <div>
                <input class="input is-small"
                       type="text"
                       placeholder="Filter"
                       onkeyup={keyup}>

                <div class="deamons">
                    <button each={obj in deamons()}
                            class="button is-small"
                            deamon-id={obj.id}
                            onclick={selectDeamon}>
                        {obj.name_short} : {obj.name}
                    </button>
                </div>
            </div>
        </div>

    </div>

    <script>
     this.filter = null;
     this.selected_deamon = null;
    </script>

    <script>
     this.clickSave = () => {
         let impure = this.opts.data;
         let deamon = this.selected_deamon;

         ACTIONS.setImpureDeamon (impure, deamon);
     };
     this.clickRevert = () => {
         this.selected_deamon = null;
         this.update();
     };
     this.selectDeamon = (e) => {
         let id = e.target.getAttribute('deamon-id');
         let deamon = STORE.get('deamons.ht')[id];

         this.selected_deamon = deamon;
         this.update();
     };
     this.keyup = (e) => {
         let filter = e.target.value;

         if (filter.length==0)
             this.filter = null;
         else
             this.filter = filter;

         this.update();
     };
    </script>


    <script>
     this.isDisabled = () => {
         if (!this.selected_deamon ||
             this.opts.data.deamon_id == this.selected_deamon.id)
             return 'disabled';

         return null;
     };
     this.selectedDeamon = () => {
         let name, name_short;

         if (this.selected_deamon) {
             name = this.selected_deamon.name;
             name_short = this.selected_deamon.name_short;
         } else {
             let impure = this.opts.data;

             if (!impure.deamon_id)
                 return 'なし：浮遊霊';

             name = impure.deamon_name;
             name_short = impure.deamon_name_short;
         }

         return '%s: %s'.format(name_short, name);
     }
     this.deamons = () => {
         let out = STORE.get('deamons.list');

         if (!this.filter)
             return out;

         let filter = this.filter.toLowerCase();
         return out.filter((d) => {
             return d.name.toLowerCase().indexOf(filter) > -1 ||
                    d.name_short.toLowerCase().indexOf(filter) > -1;
         });
     };
    </script>


    <style>
     impure-card-large_tab_deamon > div {
         display:flex;
         flex-direction: column;
         height: 100%;
     }
     impure-card-large_tab_deamon .selected {
         background: #efefef;
         padding: 22px;
         border-radius: 3px;
     }
     impure-card-large_tab_deamon .selector {
         flex-grow: 1;

         margin-top: 22px;
     }
     impure-card-large_tab_deamon .selector > div {
         padding: 0px 22px;
         display: flex;
         flex-direction: column;
     }
     impure-card-large_tab_deamon .selector .title {
         margin-bottom: 5px;
     }
     impure-card-large_tab_deamon .selector .input {
         margin-bottom: 11px;
     }
     impure-card-large_tab_deamon .selector .deamons {
         flex-grow: 1;

         display: flex;
         flex-wrap: wrap;
     }
     impure-card-large_tab_deamon .selector .deamons > * {
         margin-right: 11px; margin-bottom: 11px;
     }
    </style>

</impure-card-large_tab_deamon>
