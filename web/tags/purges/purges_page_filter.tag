<purges_page_filter>
    <input class="input"
           type="text"
           placeholder="From"
           value={date2str(opts.from)} readonly>

    <span style="font-size:24px; margin-left:11px; margin-right:11px;"> 〜 </span>

    <input class="input"
           type="text"
           placeholder="To"
           value={date2str(opts.to)} readonly>

    <div class="operators" style="margin-top:-1px;">
        <move-date-operator label="日" unit="d" callback={callback}></move-date-operator>
        <move-date-operator label="週" unit="w" callback={callback}></move-date-operator>
        <move-date-operator label="月" unit="M" callback={callback}></move-date-operator>

        <button class="button refresh"
                style="margin-top:1px; margin-left:11px;"
                onclick={clickRefresh}>Refresh</button>
    </div>

    <script>
     this.date2str = (date) => {
         if (!date) return '';
         return date.format('YYYY-MM-DD');
     };
    </script>

    <script>
     this.clickRefresh = () => {
         this.opts.callback('refresh');
     };

     this.callback = (action, data) => {
         this.opts.callback('move-date', {
             unit: data.unit,
             amount: data.amount,
         })
     };
    </script>

    <style>
     purges_page_filter, purges_page_filter .operators  {
         display: flex;
     }

     purges_page_filter .input {
         width: 111px;
         border: none;
     }
    </style>
</purges_page_filter>
