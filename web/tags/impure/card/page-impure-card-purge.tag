<page-impure-card-purge style="width:{w()}px; height:{h()}px;">


    <div class="header" style="">
        <p><b>浄化:</b> {angelName()}</p>
    </div>

    <div class="body">
        <div style="font-size:11px; padding-left:8px;">
            <p>開:{start()}</p>
            <p>終:{end()}</p>
        </div>

        <div class="elapsed-time">
            <p>{elapsedTime()}</p>
        </div>
    </div>

    <div class="hw-card-footer">
        <p>{time()}</p>
    </div>

    <script>
     this.w = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(8, null, 11);
     };
     this.h = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(8, null, 11);
     };
    </script>

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
         display:flex;
         flex-direction:column;

         background: rgba(255,255,255,0.88);;
         border-radius: 8px;

         font-size: 12px;
     }
     page-impure-card-purge > .header {
         background:rgba(254, 242, 99, 0.88);
         padding:8px 11px;
         border-radius: 8px 8px 0px 0px;
     }
     page-impure-card-purge > .body {
         display: flex;
         flex-direction: column;

         padding: 8px 0px 0px 0px;

         height: 100%;
     }

     page-impure-card-purge > .body > .elapsed-time{
         text-align: center;
         align-items: center;
         height: 100%;
         display: flex;
         justify-content: center;
         font-size: 33px;
         font-weight: bold;
     }

     page-impure-card-purge .hw-card-footer {
         font-size:8px;
         text-align:right;
         padding: 8px 8px 0px 0px;
         color: #aaaaaa;
     }
    </style>
</page-impure-card-purge>
