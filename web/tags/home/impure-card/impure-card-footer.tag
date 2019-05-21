<impure-card-footer>

    <footer class="card-footer" style="font-size:14px; height:33px;">
        <span class="card-footer-item action {opts.status}" action={startStopAction()}  onclick={clickButton}>{startStopLabel()}</span>
        <span class="card-footer-item view"   action="move-2-view"        onclick={clickButton}>照会</span>
        <span class="card-footer-item open"   action={changeSizeAction()} onclick={clickButton}>{changeSizeLabel()}</span>
    </footer>

    <script>
     this.startStopLabel = () => {
         if (!this.opts.status)
             return '開始';

         return '停止';
     }
     this.startStopAction = () => {
         if (!this.opts.status)
             return 'start-action';

         return 'stop-action';
     }
     this.changeSizeLabel = () => {
         if (this.opts.mode == 'large')
             return '閉じる'

         return '開く'
     }
     this.changeSizeAction = () => {
         if (this.opts.mode == 'large')
             return 'switch-small'

         return 'switch-large'
     }

     this.clickButton = (e) => {
         let target = e.target;
         let action = target.getAttribute('action');

         if (action=='start-action' && this.opts.status)
             return;

         if (action=='stop-action' && !this.opts.status)
             return;

         this.opts.callback(action);
     };
    </script>

    <style>
     impure-card-footer .action.start {
         border-radius: 0px 0px 0px 5px;
         background-color: #FEF264;
     }
     impure-card-footer .action.start:hover {
         font-weight: bold;
     }
    </style>

</impure-card-footer>
