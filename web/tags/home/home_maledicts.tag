<home_maledicts>
    <nav class="panel hw-box-shadow">
        <p class="panel-heading">Maledicts</p>

        <a each={maledict in data()}
           class="panel-block {isActive(maledict.id)}"
           onclick={clickItem}
           maledict-id={id}
           style="padding: 5px 8px; height: 35px;">

            <span style="width:120px; font-size:11px;" maledict-id={maledict.id}>
                {maledict.name}
            </span>

            <home-maledicts-item-operators maledict={maledict}
                                           dragging={dragging}
                                           callback={opts.callback}>
            </home-maledicts-item-operators>
        </a>
    </nav>

    <script>
     this.dragging = false;
    </script>

    <script>
     this.default_maledicts = [
         {
             deletable: 0,
             description: "",
             id: -1,
             'maledict-type': {NAME: "Waiting For ...", ORDER: 0, DELETABLE: 0, DESCRIPTION: ""},
             name: "Waiting For ... ※実装中",
             order: 666,
         },
     ];
     this.getDefaultMaeldict = (maledict_id) => {
         return this.default_maledicts.find((d) => {
             return d.id = maledict_id;
         });
     };
    </script>

    <script>
     this.clickItem = (e) => {
         let target = e.target;
         let maledict_id = target.getAttribute('maledict-id');

         if (maledict_id==-1) {
             ACTIONS.selectedHomeMaledictWatingFor(this.getDefaultMaeldict(maledict_id));
         } else {
             ACTIONS.selectedHomeMaledict(this.opts.data.ht[target.getAttribute('maledict-id')]);
         }

     };
     this.on('mount', () => {
         let maledicts = this.data()
                             .sort((a,b) => {
                                 return a.ORDER < b.ORDER;
                             });

         let maledict_selected = STORE.get('selected.home.maledict');
         if (!maledict_selected)
             maledict_selected = maledicts[0];

         ACTIONS.selectedHomeMaledict(maledict_selected);
     });
    </script>

    <script>
     this.data = () => {
         if (!this.opts.data) return [];

         let out = this.opts.data.list.filter((d)=>{
             return d['maledict-type']['ORDER']!=999;
         });

         return out.concat(this.default_maledicts);
     };
    </script>

    <script>
     this.isActive = (id) => {
         if (!opts.select) return;

         return id==opts.select.id ? 'is-active' : ''
     }
     STORE.subscribe((action) => {
         if (action.type=='START-DRAG-IMPURE-ICON') {
             this.dragging = true;
             this.update();
         }
         if (action.type=='END-DRAG-IMPURE-ICON') {
             this.dragging = false;
             this.update();
         }
     });
    </script>

    <style>
     home_maledicts > .panel {
         width: 188px;
         border-radius: 4px 4px 0 0;
     }
     home_maledicts > .panel > .panel-heading{
         font-size:12px;
         font-weight:bold;
     }
     home_maledicts .panel-block {
         background:#fff;
     }

     home_maledicts .panel-block:hover {
         background:rgb(255, 255, 236);
     }

     home_maledicts .panel-block.is-active {
         background:rgb(254, 242, 99);
     }
     home_maledicts .panel-block.is-active {
         border-left-color: rgb(254, 224, 0);
     }
    </style>
</home_maledicts>
