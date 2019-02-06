<purges_page_group-span>
    <p style="width:100%; color:#fff; font-weight:bold;text-shadow: 0px 0px 22px #333333;text-align: center;font-size: 22px;">
        合計作業時間
    </p>

    <p style="font-size: 111px;color: #fff;text-shadow: 0px 0px 22px #333333;">
        {sumHours()}
    </p>

    <script>
     this.sumHours = () => {
         let time_sec = new HolyWater().summaryPurges(this.opts.data.list);

         return new TimeStripper().format_sec(time_sec)
     };
    </script>
</purges_page_group-span>
