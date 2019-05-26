<impure-card class="{cardSize()}" status={status()}>

    <impure-card-small data={opts.data} status={status()} callback={callback}></impure-card-small>
    <impure-card-large data={opts.data} status={status()} callback={callback}></impure-card-large>

    <script>
     this.callback = (action, data) => {
         if ('switch-large'==action)
             return this.opts.callbacks.switchSize('large', opts.data);

         if ('switch-small'==action)
             return this.opts.callbacks.switchSize('small', opts.data);

         if ('start-drag'==action)
             ACTIONS.startDragImpureIcon();

         if ('end-drag'==action)
             ACTIONS.endDragImpureIcon();

         if ('start-action'==action)
             ACTIONS.startImpure(this.opts.data);

         if ('stop-action'==action)
             ACTIONS.stopImpure(this.opts.data);

         if ('finishe-impure'==action)
             ACTIONS.finishImpure(this.opts.data, true, data.spell);

         if ('save-impure-contents'==action)
             ACTIONS.saveImpure(data);

         if ('move-2-view'==action)
             location.hash = '#home/impures/' + this.opts.data.id;

         if ('incantation'==action)
             ACTIONS.saveImpureIncantationSolo(this.opts.data, data.spell);
     };
    </script>

    <script>
     this.cardSize = () => {
         return this.opts.open ? 'large' : 'small';
     };
     this.isStart = () => {
         if (!this.opts.data)
             return false;

         if (!this.opts.data.purge_started_at)
             return false;

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
     impure-card[status=start] div.card impure-card-header > .card-header {
         background: rgba(254, 242, 99, 0.888);
     }
     impure-card[status=start] impure-card-small > .card .card-content p {
         font-weight: bold;
     }
     impure-card[status=start] .card {
         box-shadow: 0px 0px 22px rgba(254, 242, 99, 0.666);
     }
    </style>

</impure-card>
