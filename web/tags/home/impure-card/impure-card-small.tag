<impure-card-small>

    <div class="card hw-box-shadow">

        <header class="card-header">
            <p class="card-header-title">Impure</p>
            <impure-card-move-icon callback={this.opts.callback}
                                   data={opts.data}></impure-card-move-icon>
        </header>

        <div class="card-content">
            <div class="content" style="font-size:14px;">
                <p>{name()}</p>
            </div>
        </div>

        <impure-card-footer callback={this.opts.callback}
                            status={opts.status}
                            mode="small"></impure-card-footer>
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
     impure-card-small > .card {
         width: 222px;
         height: 222px;
         float: left;
         margin-left: 22px;
         margin-top: 1px;
         margin-bottom: 22px;

         border: 1px solid #dddddd;
         border-radius: 5px;
     }
     impure-card-small > .card .card-content{
         height: calc(222px - 49px - 48px);
         padding: 11px 22px;
         overflow: auto;
     }
    </style>

</impure-card-small>
