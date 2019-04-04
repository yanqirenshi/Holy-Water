<impure-card class="small" status={status()}>
    <impure-card-small data={opts.data} status={status()} callback={callback}></impure-card-small>
    <impure-card-large data={opts.data} status={status()} callback={callback}></impure-card-large>

    <script>
     this.callback = (action, data) => {
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

         if ('save-impure-contents'==action)
             ACTIONS.saveImpure(data);

         if ('move-2-view'==action)
             location.hash = '#home/impures/' + this.opts.data.id;
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
     impure-card[status=start] div.card {
         background: rgba(254, 242, 99, 0.888);
     }
    </style>
</impure-card>
