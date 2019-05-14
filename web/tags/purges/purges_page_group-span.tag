<purges_page_group-span>
    <p class="hw-text-white" style="width:100%; font-weight:bold; text-align: center;font-size: 22px;">
        合計作業時間
    </p>

    <p class="hw-text-white" style="font-size: 111px;">
        {sumHours()}
    </p>

    <script>
     this.sumHours = () => {
         let time_sec = new HolyWater().summaryPurges(this.opts.source);

         return new TimeStripper().format_sec(time_sec)
     };
    </script>
</purges_page_group-span>
