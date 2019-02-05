<home_page_root-working-action class={opts.data ? '' : 'hide'}>

    <button class="button is-small" style="margin-right:11px;">Stop</button>
    <span>{opts.data.name}</span>

    <div style="margin-top: 8px;">
        <p style="display:inline; font-size:12px; margin-right:22px;">
            <span>経過: {distance()}</span>
            <span>, 開始: </span>
            <span>{start()}</span>
        </p>

        <button class="button is-small">Stop & Close</button>
    </div>

    <script>
     this.name = () => {
         return opts.data ? opts.data.name : '';
     };
     this.distance = () => {
         let start = opts.data.purge.start;
         let sec_tmp   = moment().diff(start, 'second');

         let sec = sec_tmp % 60;
         sec_tmp -= sec;
         let min_tmp = sec_tmp / 60;
         let min = min_tmp % 60;
         min_tmp -= min;
         let hour = min_tmp / 60;

         let fmt = (v) => {
             return v<10 ? '0'+v : v;
         }

         return fmt(hour) + ':' + fmt(min) + ':' + fmt(sec);
     }
     this.start = () => {
         if (!opts.data || !opts.data.purge)
             return '????-??-?? ??:??:??';

         let start = opts.data.purge.start;

         return moment(start).format('YYYY-MM-DD HH:mm:ss');
     };
    </script>

    <style>
     home_page_root-working-action {
         display: block;
         position: fixed;
         bottom: 33px;
         right: 33px;
         background: #fff;
         padding: 11px 22px;
         border-radius: 8px;
     }
    </style>
</home_page_root-working-action>
