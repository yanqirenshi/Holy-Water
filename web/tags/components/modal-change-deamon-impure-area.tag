<modal-change-deamon-impure-area>

    <div class="root-container" >
        <h1 class="title is-4">Impure</h1>

        <div class="basic-info-area" style="font-size:12px;">
            <p>{val('impure_name')} (ID: {val('impure_id')})</p>

            <p style="background:#fff; flex-grow: 1; overflow: auto;">
                <description-markdown source={val('impure_description')}></description-markdown>
            </p>
        </div>

        <div class="deamon-area">
            <h1 class="title is-6" style="margin-bottom: 8px;">Deamon</h1>

            <div style="padding-left:11px;">
                <p>{val('impure_deamon')}</p>

                <button class="button is-small deamon-item {impureDeamon() ? '' : 'hide'}"
                        onclick={clickRemove}>
                    削除
                </button>
            </div>
        </div>
    </div>

    <script>
     this.clickRemove = (e) => {
         this.opts.callback('remove-deamon');
     }
    </script>

    <script>
     this.val = (name) => {
         if (!this.opts.source)
             return '';

         if ('impure_deamon'!=name)
             return this.opts.source[name];

         let deamon = this.opts.choosed_deamon;

         if (!deamon || deamon.id===null)
             return 'なし';

         return deamon.name + ' (ID:' + deamon.id + ')';
     };
     this.impureDeamon = () => {
         if (!this.opts.source)
             return null;

         let deamon = this.opts.choosed_deamon;

         if (!deamon || deamon.id===null)
             return null;

         return deamon;
     };
     this.deamons = () => {
         return STORE.get('deamons.list');
     };
    </script>

    <style>
     modal-change-deamon-impure-area .root-container {
         height: 100%;

         display: flex;
         flex-direction: column;
     }
     modal-change-deamon-impure-area .basic-info-area {
         padding-left:11px;
         flex-grow: 1;

         display: flex;
         flex-direction: column;
     }
     modal-change-deamon-impure-area .deamon-area {
         height:99px;
         margin-top:11px;
     }
    </style>
</modal-change-deamon-impure-area>
