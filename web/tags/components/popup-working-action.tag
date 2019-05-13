<popup-working-action class="{hide()}">

    <button class="button is-small hw-button"
            style="margin-right:11px;"
            onclick={clickStop}>Stop</button>
    <span style="font-size:12px;">{name()}</span>

    <div style="margin-top: 8px;">
        <p style="display:inline; font-size:12px; margin-right:22px;">
            <span style="font-size:12px;width:88px;display:inline-block;">経過: {distance()}</span>
            <span style="font-size:12px;">開始: </span>
            <span style="font-size:12px;">{start()}</span>
        </p>

        <button class="button is-small hw-button"
                onclick={clickStopAndClose}>Stop & Close</button>
    </div>

    <script>
     /// Events
     this.clickStop = () => {
         let impure = this.opts.data;
         if (impure)
             ACTIONS.stopImpure(impure);
     }
     this.clickStopAndClose = () => {
         let impure = this.opts.data;
         if (impure)
             ACTIONS.finishImpure(impure, true);
     };
    </script>

    <script>
     /// Views
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
     popup-working-action {
         display: block;
         position: fixed;
         bottom: 33px;
         right: 33px;
         background: #fff;
         padding: 11px 22px;

         border: 1px solid #ededed;
         border-radius: 8px;
         box-shadow: 0px 0px 22px rgba(254, 242, 99, 0.666);
     }
    </style>
</popup-working-action>
