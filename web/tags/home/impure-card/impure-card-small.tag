<impure-card-small>

    <div class="card hw-box-shadow">

        <!-- <impure-card-header callback={opts.callback}
             data={opts.data}></impure-card-header> -->

        <div class="card-content">
            <div class="content" style="font-size:12px;">
                <p>
                    <span if={opts.data.deamon_id}
                          class="deamon"
                          title={deamonVal('deamon_name')}>
                        {deamonVal('deamon_name_short')}
                    </span>
                    {name()}
                </p>
            </div>
        </div>

        <impure-card-footer callback={opts.callback}
                            data={opts.data}
                            status={opts.status}
                            mode="small"></impure-card-footer>
    </div>

    <script>
     this.deamonVal = (name) => {
         let impure = this.opts.data;

         if (!impure)
             return null

         return this.opts.data[name];
     };
     this.name = () => {
         let impure = this.opts.data;
         if (!impure)
             return '????????'

         return impure.name;
     };
     this.description = () => {
         if (!this.opts.data) return ''
         return this.opts.data.description;
     };
    </script>

    <style>
     impure-card-small > .card {
         width: 188px;
         height: 188px;
         float: left;
         margin-left: 22px;
         margin-top: 1px;
         margin-bottom: 22px;

         border: 1px solid #dddddd;
         border-radius: 5px;
     }
     impure-card-small > .card .card-content{
         height: calc(188px - 33px - 1px);
         padding: 11px 11px;
         overflow: auto;
         word-break: break-all;
     }
     impure-card-small .deamon {
         background: #efefef;
         margin-right: 5px;
         padding: 3px 5px;
         border-radius: 3px;
     }
    </style>

</impure-card-small>
