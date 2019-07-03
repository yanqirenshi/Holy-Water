<page-impure-card-purge>


    <div style="display:flex; flex-direction:column; height:100%;">

        <div style="background:rgba(254, 242, 99, 0.88); padding:6px 8px; margin-bottom: 6px;">
            <p><b>浄化:</b> {angelName()}</p>
        </div>

        <div style="font-size:11px; margin-top:11px;">
            <p>開始:{start()}</p>
            <p>終了:{end()}</p>
        </div>

        <div style="flex-grow:1; display:flex; align-items:center;">
            <p style="flex-grow:1; font-size: 33px;text-align: center;">{elapsedTime()}</p>
        </div>

        <div style="font-size:8px; text-align:right;">
            <p>{time()}</p>
        </div>
    </div>

    <script>
     this.time = () => {
         let time_str = this.opts.source.end || this.opts.source.start;

         return moment(time_str).format('YYYY-MM-DD HH:mm (ddd)');
     }
     this.angelName = () => {
         return this.opts.source.angel_name;
     };
     this.start = () => {
         return moment(this.opts.source.start).format('YYYY-MM-DD HH:mm (ddd)');
     }
     this.end = () => {
         if (!this.opts.source.end)
             return '';

         return moment(this.opts.source.end).format('YYYY-MM-DD HH:mm (ddd)');
     }
     this.elapsedTime = () => {
         let start = this.opts.source.start;
         let end   = this.opts.source.end;
         if (!end)
             return '計測中';

         let elapsed_time_ms = new Date(end) - new Date(start);
         return new HolyWater().int2hhmmss(elapsed_time_ms / 1000);
     }
    </script>

    <style>
     page-impure-card-purge {
         display: block;
         width:  calc(88px * 2 + 11px * 1);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;

         font-size: 12px;
     }
    </style>
</page-impure-card-purge>
