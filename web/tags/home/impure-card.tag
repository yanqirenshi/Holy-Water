<impure-card>
    <div class="card" style="">
        <header class="card-header">
            <p class="card-header-title">
                やること
            </p>
            <a href="#" class="card-header-icon" aria-label="more options">
                <span class="icon">
                    <i class="fas fa-running"></i>
                </span>
            </a>
        </header>
        <div class="card-content">
            <div class="content">
                <p>{name()}</p>
                <p>{description()}</p>
            </div>
        </div>
        <footer class="card-footer">
            <a href="#" class="card-footer-item">Start</a>
            <a href="#" class="card-footer-item">Stop</a>
            <a href="#" class="card-footer-item">Open</a>
        </footer>
    </div>

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
     impure-card > .card {
         width: 222px;
         height: calc(1.618 * 222px);
         float: left;
         margin-left: 22px;
         margin-top: 1px;
         margin-bottom: 22px;
     }
     impure-card > .card .card-content{
         height: calc(222px + 39px);
         padding: 11px 22px;
         overflow: auto;
     }
    </style>
</impure-card>
