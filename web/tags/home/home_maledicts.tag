<home_maledicts>
    <nav class="panel hw-box-shadow">
        <p class="panel-heading">Maledicts</p>

        <a each={data()}
           class="panel-block {isActive(id)}"
           onclick={clickItem}
           maledict-id={id}
           style="padding: 5px 8px;">

            <span style="width:120px; font-size:11px;" maledict-id={id}>
                {name}
            </span>

            <span class="operators" style="font-size:14px;">
                <span class="icon" title="ここに「やること」を追加する。"
                      maledict-id={id}
                      maledict-name={name}
                      onclick={clickAddButton}>
                    <i class="far fa-plus-square" maledict-id={id}></i>
                </span>

                <span class="move-door {dragging ? 'open' : 'close'}"
                      ref="move-door"
                      dragover={dragover}
                      drop={drop}>

                    <span class="icon closed-door">
                        <i class="fas fa-door-closed"></i>
                    </span>

                    <span class="icon opened-door" maledict-id={id}>
                        <i class="fas fa-door-open" maledict-id={id}></i>
                    </span>
                </span>

            </span>
        </a>

        <a class="panel-block" style="padding: 5px 8px; height:35px;">
            <span style="width:120px; font-size:11px;"
                  maledict-id={id}
                  onclick={clickWaitingFor}>Waiting for ... ※実装中</span>
        </a>
    </nav>

    <script>
     this.dragging = false;
    </script>

    <script>
     this.dragover = (e) => {
         e.preventDefault();
     };
     this.drop = (e) => {
         let impure = JSON.parse(e.dataTransfer.getData('impure'));
         let maledict = this.opts.data.ht[e.target.getAttribute('maledict-id')];

         ACTIONS.moveImpure(maledict, impure);

         e.preventDefault();
     };
    </script>

    <script>
     this.clickWaitingFor = (e) => {
         ACTIONS.fetchImpureAtWaitingFor();
     };
     this.clickItem = (e) => {
         let target = e.target;
         let maledict = this.opts.data.ht[target.getAttribute('maledict-id')];

         ACTIONS.selectedHomeMaledict(maledict);
     };
     this.clickAddButton = (e) => {
         let target = e.target;
         let maledict = this.opts.data.ht[target.getAttribute('maledict-id')];

         this.opts.callback('open-modal-create-impure', maledict);

         e.stopPropagation();
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

         return this.opts.data.list.filter((d)=>{
             return d['maledict-type']['ORDER']!=999;
         });
     };
    </script>

    <script>
     this.active_maledict = null;
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
     home_maledicts .move-door.close .opened-door {
         display: none;
     }
     home_maledicts .move-door.open .closed-door {
         display: none;
     }
     home_maledicts .operators {
         width: 53px;
     }
     home_maledicts .operators .icon {
         color: #cccccc;
     }
     home_maledicts .operators .icon:hover {
         color: #880000;
     }
     home_maledicts .operators .move-door.open .icon {
         color: #880000;
     }
    </style>
</home_maledicts>
