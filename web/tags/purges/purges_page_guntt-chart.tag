<purges_page_guntt-chart>
    <div style="overflow:auto; background:#fff; padding:22px;">
        <svg class="chart-yabane"></svg>
    </div>

    <script>
     this.on('update', () => {
         let now   = moment().millisecond(0).second(0).minute(0).hour(0);

         let options = {
             scale: {
                 x: {
                     cycle: 'hours',
                     tick:  88,
                     start: moment(now).startOf('d').hour(7),
                     end:   moment(now).add( 1, 'd').startOf('d'),
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

         let d3yabane = new D3jsYabane()
             .config(options)
             .makeStage()
             .data(data) // with sizing and positioning
             .draw();
     });
    </script>

    <style>
     purges_page_guntt-chart {
         display: block;
         padding-left: 22px;
         padding-right: 22px;
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
