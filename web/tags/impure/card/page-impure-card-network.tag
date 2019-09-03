<page-impure-card-network style="width:{w()}px; height:{h()}px;">

    <div style="padding: 11px 22px; padding-bottom: 22px;">
        <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth" style="font-size:12px;">
            <thead>
                <tr>
                    <th rowspan="2">ID</th>
                    <th rowspan="2">Direction</th>
                    <th colspan="2">deamon</th>
                    <th colspan="2">祓魔師</th>
                    <th colspan="2">maledict</th>
                    <th colspan="2">Impure</th>
                </tr>
                <tr>
                    <th>ID</th>
                    <th>Namme(short)</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>ID</th>
                    <th>Name</th>
                </tr>
            </thead>
            <tbody>
                <tr each={obj in list()}>
                    <td>{obj.relationship_id}</td>
                    <td>{obj.relationship_direction}</td>
                    <td>{obj.deamon_id}</td>
                    <td>{obj.deamon_name_short}</td>
                    <td>{obj.angel_id}</td>
                    <td>{obj.angel_name}</td>
                    <td>{obj.maledict_id}</td>
                    <td>{obj.maledict_name}</td>
                    <td>
                        <a onclick={link} impure-id={obj.id}>
                            {obj.id}
                        </a>
                    </td>
                    <td>{obj.name}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div style="width:100%; height:100%;border-top: 1px solid #aaaaaa;border-bottom: 1px solid #aaaaaa;">
        <svg ref="graph"></svg>
    </div>

    <script>
     this.list = () => {
         let list = this.opts.source.relationships;
         if (!list)
             return [];

         return list;
     };
     this.link = (e) => {
         let id = e.target.getAttribute('impure-id');

         location.hash = '#home/impures/' + id;

         ACTIONS.fetchPagesImpure({ id: id });
     };
    </script>

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
