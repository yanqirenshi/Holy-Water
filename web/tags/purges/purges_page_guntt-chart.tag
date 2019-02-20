<purges_page_guntt-chart>
    <div style="overflow:auto; background:#fff; padding:22px;">
        <svg class="chart-yabane"></svg>
    </div>

    <script>
     this.on('update', () => {
         let now   = moment().millisecond(0).second(0).minute(0).hour(0);
         let start = moment(now).startOf('d').hour(7);

         let options = {
             scale: {
                 x: {
                     cycle: 'hours',
                     tick:  88,
                     start: start,
                     end:   moment(now).add( 1, 'd').startOf('d').hour(6),
                 }
             },
             stage: {
                 selector: 'svg.chart-yabane',
             }
         }

         let hw = new HolyWater()
         let data = this.opts.data.list.map((d) => {
             return hw.makeGunntChartData(d);
         });

         try {
             new D3jsYabane()
                 .config(options)
                 .makeStage()
                 .data(data) // with sizing and positioning
                 .draw();
         } catch (e) {
             ACTIONS.pushErrorMessage('Guntt Chart の描画に失敗しました。');
             dump(e);
         }
     });
    </script>

    <style>
     purges_page_guntt-chart {
         display: block;
         margin-left: 22px;
         margin-right: 22px;
         padding: 22px 11px;
         background: #fff;
         border-radius: 3px;
     }
     purges_page_guntt-chart > div {
         width: 100%;
         border-radius: 3px;
     }
     purges_page_guntt-chart > div > svg{
         background: #fff;
     }
    </style>
</purges_page_guntt-chart>
