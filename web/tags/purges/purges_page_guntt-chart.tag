<purges_page_guntt-chart>
    <div>
        <svg class="chart-yabane"></svg>
    </div>

    <script>
     let now   = moment().millisecond(0).second(0).minute(0).hour(0);
     let start = moment(now).add(-2, 'w');
     let end   = moment(now).add( 6, 'M');
     let selector = 'svg.chart-yabane';

     let d3yabane = new D3jsYabane()
         .config(selector, start, end)
         .makeStage()
     /* .data(yabane_data) // with sizing and positioning
      * .draw(); */
    </script>

    <style>
     purges_page_guntt-chart {
         display: block;
         padding-left: 22px;
         padding-right: 22px;
     }
     purges_page_guntt-chart > div {
         width: 100%
     }
     purges_page_guntt-chart > div > svg{
         background: #fff;
         width: 100%;
         height: 333px;
     }
    </style>
</purges_page_guntt-chart>
