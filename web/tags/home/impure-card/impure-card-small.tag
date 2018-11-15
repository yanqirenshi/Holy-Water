<impure-card-small>
    <div class="card" style="">
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
            <a class="card-footer-item">Start</a>
            <a class="card-footer-item">Stop</a>
            <a class="card-footer-item" onclick={clickOpenButton}>Open</a>
        </footer>
    </div>

    <script>
     this.clickOpenButton = (e) => {
         this.opts.callback('switch-large');
     };
     this.dragStart = (e) => {
         this.opts.callback('start-drag');
     };
     this.dragEnd = (e) => {
         this.opts.callback('end-drag');
     };
    </script>

    <script>
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
     }
     impure-card-small > .card .card-content{
         height: calc(222px - 49px - 48px);
         padding: 11px 22px;
         overflow: auto;
     }
    </style>
</impure-card-small>
