<page-impure-card-deamon-large>

    <div style="width:{w()}px; height:{h()}px;">

        <div class="current">
            <p>
                {deamonName()}
                ({deamonNameShort()})
            </p>
        </div>

        <div class="selector">
            <input class="input is-small"
                   type="text"
                   placeholder="Text input"
                   onkeyup={keyUp}>

            <div style="margin-top:11px; flex-grow:1;">
                <page-impure-card-deamon-item each={deamon in deamons()}
                                              source={deamon}
                                              onclick={selectItem}></page-impure-card-deamon-item>
            </div>
        </div>

        <div class="controller">
            <button class="button is-small"
                    onclick={clickCancel}>Cancel</button>

            <button class="button is-small is-danger"
                    onclick={clickSave} disabled={isDisable()}>Save</button>
        </div>
    </div>

    <script>
     this.deamon = this.opts.source.deamon;
     this.filter = null;
     this.deamons = () => {
         let deamons = STORE.get('deamons.list');

         if (!this.filter)
             return deamons;

         let filter = this.filter.toLowerCase();
         return deamons.filter((d) => {
             return d.name.toLowerCase().indexOf(filter) != -1 ||
                    d.name_short.toLowerCase().indexOf(filter) != -1;
         });
     };
     this.selectItem = (e) => {
         let id = e.target.getAttribute('deamon_id');
         let deamon = STORE.get('deamons.ht')[id];

         this.deamon = deamon;
         this.update();
     };
     this.keyUp = (e) => {
         let = this.filter = e.target.value;
         this.update();
     }
     this.clickCancel = () => {
         this.opts.callback('close-deamon');
     };
     this.isDisable = () => {
         if (!this.opts.source.deamon && !this.deamon)
             return 'disabled';

         if (this.opts.source.deamon && this.deamon &&
             this.opts.source.deamon.id == this.deamon.id)
             return 'disabled';

         return '';
     };
    </script>

    <script>
     this.clickSave = () => {
         ACTIONS.setImpureDeamon(this.opts.source.impure, this.deamon);
     };
    </script>

    <script>
     this.w = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(8 * 3, null, 11);
     };
     this.h = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(8 * 3, null, 11);
     };
    </script>

    <script>
     this.deamonName = () => {
         if (!this.deamon)
             return '';

         return this.deamon.name;
     };
     this.deamonNameShort = () => {
         if (!this.deamon)
             return '';

         return this.deamon.name_short;
     };
    </script>

    <style>
     page-impure-card-deamon-large > div {
         display: flex;
         flex-direction: column;
         height: 100%;

         padding: 11px;
         background: rgba(22, 22, 14, 0.88);;
         color: #e83929;
         font-weight: bold;

         border-radius: 8px;
     }
     page-impure-card-deamon-large .current {
         padding: 11px 11px 0px 11px;
     }
     page-impure-card-deamon-large .selector {
         flex-grow:1;
         display:flex;
         flex-direction:column;
         padding: 11px 11px 0px 11px;
     }
     page-impure-card-deamon-large .controller {
         display:flex;
         justify-content:space-between;
     }
    </style>

</page-impure-card-deamon-large>
