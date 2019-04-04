<impure-card-footer>

    <footer class="card-footer">
        <span class="card-footer-item start" action="start-action" onclick={opts.callback}>Start</span>
        <span class="card-footer-item stop"  action="stop-action"  onclick={opts.callback}>Stop</span>
        <span class="card-footer-item open"  action="switch-small" onclick={opts.callback}>Small</span>
    </footer>

    <script>
     this.clickButton = (e) => {
         let target = e.target;
         let action = target.getAttribute('action');

         if (action=='start-action' && this.opts.status)
             return;

         if (action=='stop-action' && !this.opts.status)
             return;

         this.opts.callback(action);
     };
    </script>

</impure-card-footer>
