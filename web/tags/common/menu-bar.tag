<menu-bar>
    <aside class="menu">

        <p ref="brand"
           class="menu-label"
           onclick={clickBrand}>
            {opts.brand.label}
        </p>

        <ul class="menu-list">
            <li each={opts.site.pages}>
                <a class="{opts.site.active_page==code ? 'is-active' : ''}"
                   href={'#' + code}>
                    {menu_label}
                </a>
            </li>
        </ul>

    </aside>

    <div class="move-page-menu hide" ref="move-panel">
        <p each={moves()}>
            <a href={href}>{label}</a>
        </p>
    </div>

    <style>
     menu-bar .move-page-menu {
         z-index: 666665;
         background: #ffffff;
         position: fixed;
         left: 55px;
         top: 0px;
         min-width: 111px;
         height: 100vh;
         box-shadow: 2px 0px 8px 0px #e0e0e0;
         text-shadow: 0px 0px 11px rgb(254, 242, 99);
         padding: 22px 55px 22px 22px;
     }
     menu-bar .move-page-menu.hide {
         display: none;
     }
     menu-bar .move-page-menu > p {
         margin-bottom: 11px;
     }
     menu-bar > .menu {
         z-index: 666666;
         height: 100vh;
         width: 55px;
         padding: 11px 0px 11px 11px;
         position: fixed;
         left: 0px;
         top: 0px;
         background: rgb(254, 242, 99);
     }

     menu-bar .menu-label, menu-bar .menu-list a {
         padding: 0;
         width: 33px;
         height: 33px;

         margin-top: 8px;
         padding-top: 7px;

         border-radius: 3px;

         background: none;
         color: #333333;

         text-align: center;
         text-shadow: 0px 0px 11px #ffffff;

         font-size: 14px;
         font-weight: bold;
     }
     .menu-label {
         background: #ffffff;
         color: #333333;
     }
     .menu-label.open {
         background: #ffffff;
         color: rgb(254, 242, 99);
         width: 44px;
         border-radius: 3px 0px 0px 3px;
         text-shadow: 0px 0px 1px #eee;
         padding-right: 11px;
     }
     menu-bar .menu-list a:hover {
         width: 44px;
         border-radius: 5px 0px 0px 5px;
         background: #ffffff;
     }
     menu-bar .menu-list a.is-active {
         width: 55px;

         border-radius: 5px 0px 0px 5px;
         background: #ffffff;
         color: #333333;
     }
    </style>

    <script>
     this.moves = () => {
         let moves = [
             {
                 code: 'link-a',
                 href: 'https://ja.wikipedia.org/wiki/Getting_Things_Done',
                 label: 'Getting Things Done - ウィキペディア'
             },
             {
                 code: 'link-b',
                 href: 'https://postd.cc/gtd-in-15-minutes/',
                 label: '15分で分かるGTD – 仕事を成し遂げる技術の実用的ガイド | POSTD'
             },
             {
                 code: 'link-c',
                 href: 'http://gtd-japan.jp/about',
                 label: 'GTD®とは - 日本唯一のGTD公式サイト。GTD Japan'
             },
             {
                 code: 'link-d',
                 href: 'https://teamhackers.io/work-efficiency-rises-three-times',
                 label: '作業効率が3倍上がる、質を落とさず早く仕上げるタスク管理・時短編'
             },
         ]
         return moves.filter((d)=>{
             return d.code != this.opts.current;
         });
     };

     this.brandStatus = (status) => {
         let brand = this.refs['brand'];
         let classes = brand.getAttribute('class').trim().split(' ');

         if (status=='open') {
             if (classes.find((d)=>{ return d!='open'; }))
                 classes.push('open')
         } else {
             if (classes.find((d)=>{ return d=='open'; }))
                 classes = classes.filter((d)=>{ return d!='open'; });
         }
         brand.setAttribute('class', classes.join(' '));
     }

     this.clickBrand = () => {
         let panel = this.refs['move-panel'];
         let classes = panel.getAttribute('class').trim().split(' ');

         if (classes.find((d)=>{ return d=='hide'; })) {
             classes = classes.filter((d)=>{ return d!='hide'; });
             this.brandStatus('open');
         } else {
             classes.push('hide');
             this.brandStatus('close');
         }
         panel.setAttribute('class', classes.join(' '));
     };
    </script>
</menu-bar>
