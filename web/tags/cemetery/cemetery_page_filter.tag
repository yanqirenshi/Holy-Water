<cemetery_page_filter>
    <Span class="hw-text-white"
          style="font-size:24px; font-weight:bold;">期間：</Span>

    <input class="input"
           type="text"
           placeholder="From"
           value={date2str(opts.from)} readonly>

    <span style="font-size:24px;"> 〜 </span>

    <input class="input"
           type="text"
           placeholder="To"
           value={date2str(opts.to)} readonly>

    <div class="operators">
        <move-date-operator label="日" unit="d" callback={callback}></move-date-operator>
        <move-date-operator label="週" unit="w" callback={callback}></move-date-operator>
        <move-date-operator label="月" unit="M" callback={callback}></move-date-operator>

        <button class="button refresh hw-box-shadow"
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
     cemetery_page_filter,
     cemetery_page_filter .operators  {
         display: flex;
     }

     cemetery_page_filter .input {
         width: 111px;
         border: none;
     }
    </style>
</cemetery_page_filter>
