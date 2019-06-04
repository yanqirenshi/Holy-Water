<impure-card-footer>

    <div class="{opts.mode}">
        <span class="menu-item action {opts.status}"
              action={startStopAction()}
              onclick={clickButton}>{startStopLabel()}</span>

        <span class="menu-item open"
              action={changeSizeAction()}
              onclick={clickButton}>{changeSizeLabel()}</span>

        <span class="menu-item view"
              action="move-2-view"
              onclick={clickButton}>照会</span>

        <span class="spacer" if={opts.mode=="small"}></span>

        <span class="move-icon">
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
         padding: 0px 6px;
         padding-top: 3px;

         display: flex;
     }
     impure-card-footer > div.small {
         font-size: 14px;
         height:33px;
         padding: 0px 6px;
         padding-top: 3px;

     }
     impure-card-footer > div.large {
         font-size: 18px;
         height:38px;
         padding: 0px 6px;
         padding-top: 3px;

         justify-content: flex-end;
     }

     impure-card-footer .action.start {
         background-color: #FEF264;
         border-radius: 0px 0px 0px 0px;
     }
     impure-card-footer .spacer {
         flex-grow: 1;
     }
     impure-card-footer > div.small .menu-item {
         width: 55px;
         text-align: center;
         padding-top: 4px;
         margin-left: 11px;
     }
     impure-card-footer > div.large .menu-item {
         width: 55px;
         text-align: center;
         padding-top: 4px;
         margin-right: 22px;
     }
     impure-card-footer > div.large .move-icon { padding-top: 3px; }
     impure-card-footer > div.small .move-icon { padding-top: 2px; }

     impure-card-footer .menu-item:hover {
         font-weight: bold;
         text-shadow: 0px 0px 22px #FEF264;
     }
    </style>

</impure-card-footer>
