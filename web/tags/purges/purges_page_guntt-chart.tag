<purges_page_guntt-chart>
    <div style="overflow:auto;">
        <svg class="chart-yabane"></svg>
    </div>

    <script>
     this.on('mount', () => {
         let now   = moment().millisecond(0).second(0).minute(0).hour(0);

         let options = {
             scale: {
                 x: {
                     cycle: 'hours',
                     tick:  88,
                     start: moment(now).add(-1, 'd'),
                     end:   moment(now).add( 1, 'd'),
                 }
             },
             stage: {
                 selector: 'svg.chart-yabane',
             }
         }

         let d3yabane = new D3jsYabane()
             .config(options)
             .makeStage()
             .data(yabane_data) // with sizing and positioning
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
