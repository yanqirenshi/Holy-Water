<home-maledicts-item-operators>

    <span if={opts.maledict.id > 0}
          class="operators"
          style="font-size:14px;">
        <span class="icon" title="ここに「やること」を追加する。"
              maledict-id={opts.maledict.id}
              maledict-name={opts.maledict.name}
              onclick={clickAddButton}>
            <i class="far fa-plus-square" maledict-id={opts.maledict.id}></i>
        </span>

        <span class="move-door {opts.dragging ? 'open' : 'close'}"
              ref="move-door"
              dragover={dragover}
              drop={drop}>

            <span class="icon closed-door">
                <i class="fas fa-door-closed"></i>
            </span>

            <span class="icon opened-door" maledict-id={opts.maledict.id}>
                <i class="fas fa-door-open" maledict-id={opts.maledict.id}></i>
            </span>
        </span>

    </span>

    <style>
    </style>

    <script>
     this.dragover = (e) => {
         e.preventDefault();
     };
     this.drop = (e) => {
         let impure = JSON.parse(e.dataTransfer.getData('impure'));
         let maledict = opts.maledict;

         ACTIONS.moveImpure(maledict, impure);

         e.preventDefault();
     };
    </script>

    <script>
     this.clickAddButton = (e) => {
         let maledict = opts.maledict;

         this.opts.callback('open-modal-create-impure', maledict);

         e.stopPropagation();
     };
    </script>


    <style>
     home-maledicts-item-operators {
         display: flex;
         width: 53px;
     }
     home-maledicts-item-operators .move-door.close .opened-door {
         display: none;
     }
     home-maledicts-item-operators .move-door.open .closed-door {
         display: none;
     }
     home-maledicts-item-operators .operators {
         width: 53px;
     }
     home-maledicts-item-operators .operators .icon {
         color: #cccccc;
     }
     home-maledicts-item-operators .operators .icon:hover {
         color: #880000;
     }
     home-maledicts-item-operators .operators .move-door.open .icon {
         color: #880000;
     }
    </style>
</home-maledicts-item-operators>
