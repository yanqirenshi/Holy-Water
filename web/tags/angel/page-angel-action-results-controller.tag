<page-angel-action-results-controller>

    <div class="controller">
        <p style="word-break: keep-all; margin-right:11px;">期間: </p>

        <input class="input is-small"
               type="date"
               placeholder="From"
               style="margin-right:11px;"
               value={opts.span.from.format('YYYY-MM-DD')}
               ref="from">

        <p style="margin-right:11px;">〜</p>

        <input class="input is-small"
               type="date"
               placeholder="To"
               style="margin-right:11px;"
               value={opts.span.to.format('YYYY-MM-DD')}
               ref="to">

        <button class="button is-small"
                onclick={clickRefresh}>Refresh</button>
    </div>

    <div class="summary hw-text-white" style="margin-top:11px;">
        <p style="margin-right:11px;">Total:</p>
        <p style="margin-right:11px;">{totalElapsedDay()}</p>
        <p style="margin-right:11px;">[人日]</p>
    </div>


    <script>
     this.clickRefresh = () => {
         this.opts.callback('click-refresh', {
             from: moment(this.refs.from.value),
             to:   moment(this.refs.to.value),
         })
     };
     this.elapsedDay = (val) => {
         return (Math.ceil(this.elapsedHour(val) / 6 * 100) /100).toFixed(2);

     };
     this.elapsedHour = (val) => {
         return (Math.ceil(this.elapsedMinute(val) / 60 * 100) /100).toFixed(2);
     };
     this.elapsedMinute = (val) => {
         return (Math.ceil(val / 60 * 100) / 100).toFixed(2);
     };
    </script>

    <script>
     this.totalElapsedDay = () => {
         let sum = opts.source.purges.deamons.reduce((a,b)=>{
             return a + b.puge_elapsed_time;
         }, 0);

         return this.elapsedDay(sum);
     };
    </script>

    <style>
     page-angel-action-results-controller {
         display: block;
         margin-bottom: 22px;
         width: 555px;
     }
     page-angel-action-results-controller .controller {
         display: flex;
         align-items: center;

         background: #fff;
         padding: 11px 22px;
         border-radius: 5px;
     }
     page-angel-action-results-controller .summary {
         display: flex;
         align-items: center;

         font-weight: bold;
     }
    </style>


</page-angel-action-results-controller>
