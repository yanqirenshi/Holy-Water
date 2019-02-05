<home_page_root-working-action class={hide()}>

    <button class="button is-small" style="margin-right:11px;">Stop</button>
    <span>{name()}</span>

    <div style="margin-top: 8px;">
        <p style="display:inline; font-size:12px; margin-right:22px;">
            <span style="width:88px;display:inline-block;">経過: {distance()}</span>
            <span>開始: </span>
            <span>{start()}</span>
        </p>

        <button class="button is-small">Stop & Close</button>
    </div>

    <script>
     this.hide = () => {
         return opts.data ? '' : 'hide';
     }
     this.name = () => {
         return opts.data ? opts.data.name : '';
     };
     this.distance = () => {
         if (!opts.data || !opts.data.purge || !opts.data.purge.start)
             return '??:??:??'

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

         return fmt(hour) + ':' + fmt(min) + ':' + fmt(sec) + ', ';
     }
     this.start = () => {
         if (!opts.data || !opts.data.purge || !opts.data.purge.start)
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
