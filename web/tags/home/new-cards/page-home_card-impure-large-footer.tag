<page-home_card-impure-large-footer>

    <div class="{opts.status}">
        <button class="button is-small is-grow"
                onclick={clickShow}>照会</button>

        <button class="button is-small is-grow" onclick={clickStartStopaction}>{actionButtonLabel()}</button>

        <button class="button is-small" onclick={clickOpen}>
            <i class="far fa-envelope-open"></i>
        </button>
    </div>

    <script>
     this.clickOpen = () => {
         ACTIONS.switchLargeHomeImpureCard(this.opts.source);
     };
     this.clickShow = () => {
         location.hash = '#home/impures/' + this.opts.source.id;
     }
     this.clickStartStopaction = (e) => {
         if (e.target.innerHTML=='停止') {
             ACTIONS.stopImpure(this.opts.source);
             return;
         }
         if (e.target.innerHTML=='開始') {
             ACTIONS.startImpure(this.opts.source);
             return;
         }

         throw new Error('XXXX');
     };
    </script>

    <script>
     this.actionButtonLabel = () => {
         return this.opts.source.purge_started_at ? '停止' : '開始';
     };
    </script>

    <style>
     page-home_card-impure-large-footer > div {
         display: flex;
         justify-content: space-between;
         padding: 8px 11px;
     }
     page-home_card-impure-large-footer > div.started .button {
         font-weight: bold;
         text-shadow: 0px 0px 22px rgba(254, 242, 99, 0.888);
     }
     page-home_card-impure-large-footer .button.is-grow {
         flex-grow:1;
     }
    </style>

</page-home_card-impure-large-footer>
