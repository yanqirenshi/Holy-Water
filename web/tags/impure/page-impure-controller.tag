<page-impure-controller>

    <div class="controller-container">

        <div class="operators">
            <button class="button is-small" onclick={click} action="refresh">Refresh</button>

            <button class="button is-small {isHide('start')}" onclick={click} action="start">作業開始</button>

            <button class="button is-small {isHide('stop')}" onclick={click} action="stop">作業終了</button>

            <button class="button is-small" onclick={click} action="spell">呪文詠唱</button>

            <button class="button is-small" onclick={click} action="create-after">後続作成</button>

            <button class="button is-small {isHide('attain')}" onclick={click} action="attain">埋葬</button>
        </div>

    </div>

    <script>
     this.click = (e) => {
         let action = e.target.getAttribute('action');

         this.opts.callback(action);
     };
    </script>

    <script>
     this.isHide = (action) => {
         if (!this.opts.impure)
             return 'hide';

         if (action=='start')
             return this.opts.impure.purge || this.opts.impure.finished_at ? 'hide' : '';

         if (action=='stop')
             return this.opts.impure.purge && !this.opts.impure.finished_at ? '' : 'hide';

         if (action=='attain')
             return this.opts.impure.finished_at ? 'hide' : '';

         return '';
     };
    </script>

    <style>
     page-impure-controller > .controller-container {
         background: #FEF264;
         padding: 22px 11px ;
         border-radius: 3px;
     }
     page-impure-controller .operators {
         display:flex;
         flex-direction: column;
     }
     page-impure-controller .operators > * {
         margin-bottom: 22px;
     }
     page-impure-controller .operators > *:last-child {
         margin-bottom: 0px;
     }
    </style>

</page-impure-controller>
