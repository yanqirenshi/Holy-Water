<home-maledicts-item-operators>

    <span if={opts.maledict.id > 0}
          class="operators"
          style="font-size:14px;">
        <span class="icon" title="ここに「やること」を追加する。"
              maledict-id={opts.maledict.id}
              maledict-name={opts.maledict.name}
              onclick={clickAddButton}>
            <i class="far fa-plus-square" maledict-id={id}></i>
        </span>

        <span class="move-door {opts.dragging ? 'open' : 'close'}"
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

</home-maledicts-item-operators>
