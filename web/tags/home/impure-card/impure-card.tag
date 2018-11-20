<impure-card class="small" status={status()}>
    <impure-card-small data={opts.data} status={status()} callback={callback}></impure-card-small>
    <impure-card-large data={opts.data} status={status()} callback={callback}></impure-card-large>

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

         if ('start-action'==action)
             ACTIONS.startImpure(this.opts.data);

         if ('stop-action'==action)
             ACTIONS.stopImpure(this.opts.data);

         if ('finishe-impure'==action)
             ACTIONS.finishImpure(this.opts.data);
     };
    </script>

    <script>
     this.isStart = () => {
         if (!this.opts.data) return false;
         if (!this.opts.data.purge) return false;

         return true;
     }
     this.status = () => {
         return this.isStart() ? 'start' : '';
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

    <style>
     impure-card span.card-footer-item.start {
         color: inherit;
     }
     impure-card[status=start] span.card-footer-item.start {
         color: #eeeeee;
     }
     impure-card span.card-footer-item.stop {
         color: #eeeeee;
     }
     impure-card[status=start] span.card-footer-item.stop {
         color: inherit;
     }
    </style>
</impure-card>
