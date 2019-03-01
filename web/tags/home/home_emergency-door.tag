<home_emergency-door>

    <span class="move-door {dragging ? 'open' : 'close'}"
          ref="move-door"
          dragover={dragover}
          drop={drop}>

        <span class="icon closed-door">
            <i class="fas fa-door-closed"></i>
        </span>

        <span class="icon opened-door" angel-id={opts.source.id}>
            <i class="fas fa-door-open" angel-id={opts.source.id}></i>
        </span>
    </span>

    <script>
     this.dragging = false;
     this.dragover = (e) => {
         e.preventDefault();
     };
     this.drop = (e) => {
         let impure = e.dataTransfer.getData('impure');
         let angel  = this.opts.source;

         // ACTIONS.moveImpureToAngel(impure, angel);
         ACTIONS.pushWarningMessage('祓魔師間の移動は実装中です。')

         e.preventDefault();
     };
    </script>

    <script>
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
     home_emergency-door .move-door.close .opened-door{
         display: none;
     }
     home_emergency-door .move-door.open .closed-door{
         display: none;
     }
     home_emergency-door {
         width: 24px;
     }
     home_emergency-door .icon {
         color: #cccccc;
     }
     home_emergency-door .icon:hover {
         color: #880000;
     }
     home_emergency-door .move-door.open .icon {
         color: #880000;
     }
    </style>

</home_emergency-door>
