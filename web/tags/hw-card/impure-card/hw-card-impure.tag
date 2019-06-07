<hw-card-impure class="hw-box-shadow {cardSize()}" status={status()}>

    <impure-card-small if={cardSize()=="small"}
                       data={opts.source}
                       status={status()}
                       callback={callback}
                       maledict={opts.maledict}></impure-card-small>

    <impure-card-large if={cardSize()=="large"}
                       data={opts.source}
                       status={status()}
                       callback={callback}
                       maledict={opts.maledict}></impure-card-large>

    <script>
     this.callback = (action, data) => {
         if ('switch-large'==action)
             return this.opts.callbacks.switchSize('large', opts.source);

         if ('switch-small'==action)
             return this.opts.callbacks.switchSize('small', opts.source);

         if ('start-drag'==action)
             ACTIONS.startDragImpureIcon();

         if ('end-drag'==action)
             ACTIONS.endDragImpureIcon();

         if ('start-action'==action)
             ACTIONS.startImpure(this.opts.source);

         if ('stop-action'==action)
             ACTIONS.stopImpure(this.opts.source);

         if ('finishe-impure'==action)
             ACTIONS.finishImpure(this.opts.source, true, data.spell);

         if ('save-impure-contents'==action)
             ACTIONS.saveImpure(data);

         if ('move-2-view'==action)
             location.hash = '#home/impures/' + this.opts.source.id;

         if ('incantation'==action)
             ACTIONS.saveImpureIncantationSolo(this.opts.source, data.spell);
     };
    </script>

    <script>
     this.cardSize = () => {
         return this.opts.open ? 'large' : 'small';
     };
     this.isStart = () => {
         if (!this.opts.source)
             return false;

         if (!this.opts.source.purge_started_at)
             return false;

         return true;
     }
     this.status = () => {
         return this.isStart() ? 'start' : '';
     };
    </script>

    <style>
     hw-card-impure {
         display: flex;
         flex-direction: column;
         align-items: stretch;

         border-radius: 5px;
         border: 1px solid #dddddd;

         background: #ffffff;
     }
     /* Card Size */
     hw-card-impure.small {
         width: 188px;
         height: 188px;
     }
     hw-card-impure.large {
         width: calc(222px + 222px + 222px + 22px + 22px);
         height: calc(188px + 188px + 22px + 1px);
     }
     hw-card-impure[status=start] p {
         font-weight: bold;
     }
     hw-card-impure[status=start] {
         box-shadow: 0px 0px 22px rgba(254, 242, 99, 0.666);
     }
    </style>

</hw-card-impure>
