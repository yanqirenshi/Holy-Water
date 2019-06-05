<impure-card-move-icon>

    <a href="#"
       class="card-header-icon"
       aria-label="more options">

        <span class="icon"
              title="このアイコンを扉へドラッグ&ドロップすると、扉の場所へ移動できます。"
              draggable="true"
              dragstart={dragStart}
              dragend={dragEnd}>
            <icon-ranning></icon-ranning>
        </span>
    </a>

    <script>
     this.dragStart = (e) => {
         let target = e.target;

         e.dataTransfer.setData('impure', JSON.stringify(this.opts.data));

         this.opts.callback('start-drag');
     };
     this.dragEnd = (e) => {
         this.opts.callback('end-drag');
     };
    </script>

    <style>
     impure-card-move-icon a.card-header-icon {
         padding: 5px 8px;
     }
    </style>

</impure-card-move-icon>
