<purges_page_filter>
    <Span style="font-size:24px;">期間：</Span>

    <input class="input"
           type="text"
           placeholder="From"
           value={date2str(opts.from)}>

    <span style="font-size:24px;"> 〜 </span>

    <input class="input"
           type="text"
           placeholder="To"
           value={date2str(opts.to)}>

    <div class="operators">
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
     }
    </style>
</purges_page_filter>
