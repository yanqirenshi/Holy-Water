<impure-card-small>

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

    <impure-card-footer callback={opts.callback}
                        data={opts.data}
                        maledict={opts.maledict}
                        status={opts.status}
                        mode="small"></impure-card-footer>

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
     impure-card-small {
         align-items: stretch;
         flex-grow: 1;

         display: flex;
         flex-direction: column;
     }
     impure-card-small .content {
         flex-grow: 1;

         padding: 11px 11px;
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
