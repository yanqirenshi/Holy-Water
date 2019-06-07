<impure_page-controller>

    <div class="controller-container" style="width: 555px;">

        <div class="operators">
            <button class="button is-small" onclick={click} action="refresh">Refresh</button>
            <span style="flex-grow:1;"></span>

            <button class="button is-small {isHide('start')}" onclick={click} action="start">作業開始</button>

            <button class="button is-small {isHide('stop')}" onclick={click} action="stop">作業終了</button>

            <button class="button is-small" onclick={click} action="spell" disabled>呪文詠唱</button>

            <button class="button is-small" onclick={click} action="create-after" disabled>後続作成</button>

            <button class="button is-small {isHide('attain')}" onclick={click} action="attain" disabled>埋葬</button>
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
     impure_page-controller > .controller-container {
         background: #FEF264;
         padding: 11px 22px;
         border-radius: 3px;
     }
     impure_page-controller .operators {
         display:flex;
     }
     impure_page-controller .operators > * { margin-right:11px; }
     impure_page-controller .operators > *:last-child { margin-right:0px; }
    </style>

</impure_page-controller>
