<impure-card-footer>

    <div>
        <span class="menu-item action {opts.status}"
              action={startStopAction()}
              onclick={clickButton}>{startStopLabel()}</span>

        <span class="menu-item view"
              action="move-2-view"
              onclick={clickButton}>照会</span>

        <span class="menu-item open"
              action={changeSizeAction()}
              onclick={clickButton}>{changeSizeLabel()}</span>

        <span class="spacer"></span>

        <span>
            <impure-card-move-icon2 callback={opts.callback}
                                    data={opts.data}></impure-card-move-icon2>
        </span>
    </div>

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
     impure-card-footer > div {
         font-size:14px;
         height:33px;
         padding: 0px 6px;
         padding-top: 3px;

         display: flex;
     }
     impure-card-footer .action.start {
         border-radius: 0px 0px 0px 5px;
         background-color: #FEF264;
     }
     impure-card-footer .spacer {
         flex-grow: 1;
     }
     impure-card-footer .menu-item {
         width: 55px;
         text-align: center;
         padding-top: 4px;
     }
     impure-card-footer .menu-item:hover {
         font-weight: bold;
         text-shadow: 0px 0px 22px #FEF264;
     }
    </style>

</impure-card-footer>
