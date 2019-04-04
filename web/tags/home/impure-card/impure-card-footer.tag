<impure-card-footer>

    <footer class="card-footer">
        <span class="card-footer-item start" action="start-action" onclick={clickButton}>Start</span>
        <span class="card-footer-item stop"  action="stop-action"  onclick={clickButton}>Stop</span>
        <span class="card-footer-item open"  action={changeSizeAction()} onclick={clickButton}>{changeSizeLabel()}</span>
    </footer>

    <script>
     this.changeSizeLabel = () => {
         if (this.opts.mode == 'large')
             return 'Small'

         return 'Large'
     }
     this.changeSizeAction = () => {
         if (this.opts.mode == 'large')
             return 'switch-small'

         return 'switch-large'
     }

     this.clickButton = (e) => {
         let target = e.target;
         let action = target.getAttribute('action');

         if (action=='start-action' && this.opts.status)
             return;

         if (action=='stop-action' && !this.opts.status)
             return;
         dump(action);
         this.opts.callback(action);
     };
    </script>

</impure-card-footer>
