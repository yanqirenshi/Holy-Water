<impure-card-small status={status()}>
    <div class="card">
        <header class="card-header">
            <p class="card-header-title">
                やること
            </p>
            <a href="#" class="card-header-icon" aria-label="more options">
                <!-- https://www.html5rocks.com/ja/tutorials/dnd/basics/ -->
                <span class="icon"
                      title="このアイコンを扉へドラッグ&ドロップすると、扉の場所へ移動できます。"
                      draggable="true"
                      dragstart={dragStart}
                      dragend={dragEnd}>
                    <i class="fas fa-running"></i>
                </span>
            </a>
        </header>
        <div class="card-content">
            <div class="content">
                <p>{name()}</p>
            </div>
        </div>
        <footer class="card-footer">
            <span class="card-footer-item start" action="start-action" onclick={clickButton}>Start</span>
            <span class="card-footer-item stop"  action="stop-action"  onclick={clickButton}>Stop</span>
            <span class="card-footer-item open"  action="switch-large" onclick={clickButton}>Open</span>
        </footer>
    </div>

    <script>
     this.clickButton = (e) => {
         let target = e.target;
         let action = target.getAttribute('action');

         if (action=='start-action' && this.isStart())
             return;

         if (action=='stop-action' && !this.isStart())
             return;

         this.opts.callback(action);
     };
     this.dragStart = (e) => {
         this.opts.callback('start-drag');
     };
     this.dragEnd = (e) => {
         this.opts.callback('end-drag');
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
     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };
     this.description = () => {
         if (!this.opts.data) return ''
         return this.opts.data.description;
     };
    </script>

    <style>
     impure-card-small > .card {
         width: 222px;
         height: 222px;
         float: left;
         margin-left: 22px;
         margin-top: 1px;
         margin-bottom: 22px;

         box-shadow: 0px 0px 8px #ffffff;
         border: 1px solid #dddddd;
         border-radius: 5px;
     }
     impure-card-small > .card .card-content{
         height: calc(222px - 49px - 48px);
         padding: 11px 22px;
         overflow: auto;
     }
     impure-card-small span.card-footer-item.start {
         color: inherit;
     }
     impure-card-small[status=start] span.card-footer-item.start {
         color: #eeeeee;
     }
     impure-card-small span.card-footer-item.stop {
         color: #eeeeee;
     }
     impure-card-small[status=start] span.card-footer-item.stop {
         color: inherit;
     }
    </style>
</impure-card-small>
