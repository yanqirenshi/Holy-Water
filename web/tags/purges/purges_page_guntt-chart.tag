<purges_page_guntt-chart>
    <div style="overflow:auto; background:#fff; padding:22px;">
        <svg class="chart-yabane" ref="chart"></svg>
    </div>

    <script>
     this.on('update', () => {
         let options = {
             scale: {
                 x: {
                     cycle: 'hours',
                     tick:  88,
                     start: this.opts.from,
                     end:   this.opts.to,
                 }
             },
             stage: {
                 selector: 'svg.chart-yabane',
             }
         }

         let hw = new HolyWater()
         let data = this.opts.source.map((d) => {
             return hw.makeGunntChartData(d);
         });

         let element = this.refs.chart;
         while (element.firstChild) element.removeChild(element.firstChild);

         try {
             new D3jsYabane()
                 .config(options)
                 .makeStage()
                 .data(data) // with sizing and positioning
                 .draw();
         } catch (e) {
             ACTIONS.pushErrorMessage('Guntt Chart の描画に失敗しました。');
             console.log(e);
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
