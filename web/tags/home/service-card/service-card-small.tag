<service-card-small>
    <div class="card hw-box-shadow">
        <header class="card-header">
            <p class="card-header-title">
                Gitlab &nbsp;
                <a href={url()} target="_blank">Issues</a>
            </p>
        </header>
        <div class="card-content">
            <div class="content" style="font-size:14px;">
                <p style="word-break: break-all;">{name()}</p>
            </div>
        </div>
        <footer class="card-footer">
            <a class="card-footer-item" href={assignee_url()} taget="_blank">
                {assignee_name()}
            </a>
        </footer>
    </div>

    <script>
     this.name = () => {
         if (!this.opts.source) return '????????'

         return this.opts.source.title;
     };
     this.url = () => {
         if (!this.opts.source) return ''

         return this.opts.source.web_url;
     };
     this.assignee_name = () => {
         if (!this.opts.source) return '????????'

         return this.opts.source.assignee.username;
     };
     this.assignee_url = () => {
         if (!this.opts.source) return ''

         return this.opts.source.assignee.web_url;
     };
    </script>

    <style>
     service-card-small > .card {
         width: 222px;
         height: 222px;
         float: left;
         margin-left: 22px;
         margin-top: 1px;
         margin-bottom: 22px;

         border: 1px solid #dddddd;
         border-radius: 5px;
     }
     service-card-small > .card .card-content{
         height: calc(222px - 49px - 48px);
         padding: 11px 22px;
         overflow: auto;
     }

     service-card-small .panel-block:hover {
         background:rgb(255, 255, 236);
     }

     service-card-small .panel-block.is-active {
         background:rgb(254, 242, 99);
     }
     service-card-small .panel-block.is-active {
         border-left-color: rgb(254, 224, 0);
     }
    </style>
</service-card-small>
