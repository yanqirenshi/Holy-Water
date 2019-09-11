<deamon-page-card_elapsed-time-small>

    <div class="small">
        <div class="header">
            <p>Elapsed Time</p>
            <button class="button is-small"
                    onclick={clickOpen}>Open</button>
        </div>

        <div class="time">
            {amount()}
        </div>

        <div class="hw-card-footer">
            <p>hour</p>
        </div>
    </div>

    <script>
     this.amount = () => {
         let total = this.opts.source.purges.total;
         if (!total)
             return '';

         return (total.amount / 60 / 60).toFixed(2);
     };
     this.clickOpen = () => {
         this.opts.callback('switch-large');
     }
    </script>

    <style>
     deamon-page-card_elapsed-time-small > .small{
         display: flex;
         flex-direction: column;

         width: calc(11px * 16 + 11px * 15);
         height: calc(11px * 8 + 11px *  7);

         margin-bottom: 11px;

         background: rgba(255, 255, 255, 0.88);
         border-radius: 8px;
     }

     deamon-page-card_elapsed-time-small > .small > .header {
         width: 100%;
         height: 44px;

         padding: 8px 11px;
         border-radius: 8px 8px 0px 0px;

         font-size: 12px;
         font-weight: bold;

         background: #e7e7eb;
         color: #333333;

         display: flex;
         justify-content: space-between;
         align-items: center;
     }

     deamon-page-card_elapsed-time-small > .small > .time {
         display: flex;
         justify-content: center;
         align-items: center;
         height: 100%;
         font-size: 66px;
     }
     deamon-page-card_elapsed-time-small .hw-card-footer {
         display: flex;
         justify-content: flex-end;
         padding-bottom: 8px;
         padding-right: 22px;
         color: #888;
     }
    </style>

</deamon-page-card_elapsed-time-small>
