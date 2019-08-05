<page-impure-card-network style="width:{w()}px; height:{h()}px;">

    <div style="width:100%; height:100%;border-top: 1px solid #aaaaaa;border-bottom: 1px solid #aaaaaa;">
        <svg ref="graph"></svg>
    </div>

    <script>
     this.w = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(56, null, 11);
     };
     this.h = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(22, null, 11);
     };
    </script>

    <script>
     this.makeCamera = () => {
         return {
             look: {
                 at: {
                     x: 0,
                     y: 0.0,
                 },
             },
             scale: 1.0,
         };
     }
     this.getSize = () => {
         let graph  = this.refs.graph;

         if (!graph) {
             console.warn('---- not found this.refs.graph -----------------------');
             console.warn(this.refs);
             console.warn('Graph がないよ。');
             return { w:0, h:0 };
         }

         let parent = graph.parentNode;
         if (!parent)
             return { w:0, h:0 };

         return {
             w: this.refs.graph.parentNode.clientWidth,
             h: this.refs.graph.parentNode.clientHeight,
         };
     }
     this.on('updated', () => {
         let camera = this.makeCamera();
         let size   = this.getSize();

         console.warn(this.refs.graph);

         let sketcher = new DefaultSketcher({
             element: {
                 selector: 'page-impure-card-network svg',
             },
             w: size.w,
             h: size.h,
             x: camera.look.at.x,
             y: camera.look.at.y,
             scale: camera.scale,
         });
     });
    </script>

    <style>
     page-impure-card-network {
         display: block;
         padding: 11px 0px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;

         font-size: 12px;
     }
    </style>

</page-impure-card-network>
