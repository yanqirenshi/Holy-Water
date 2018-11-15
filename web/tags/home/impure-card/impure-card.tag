<impure-card class="small">
    <impure-card-small data={opts.data} callback={callback}></impure-card-small>
    <impure-card-large data={opts.data} callback={callback}></impure-card-large>

    <script>
     this.callback = (action) => {
         if ('switch-large'==action)
             this.root.setAttribute('class', 'large');

         if ('switch-small'==action)
             this.root.setAttribute('class', 'small');

         if ('start-drag'==action)
             ACTIONS.startDragImpureIcon();

         if ('end-drag'==action)
             ACTIONS.endDragImpureIcon();

     };
    </script>

    <style>
     impure-card.large > impure-card-small {
         display: none;
     }
     impure-card.small > impure-card-large {
         display: none;
     }
    </style>
</impure-card>
