<page-deamons_card-list>

    <div>
        <button class="button is-small {filter.active ? 'is-warning' : ''}" action="active" onclick={clickFilter}>Active</button>
        <button class="button is-small {filter.purged ? 'is-warning' : ''}" action="purged" onclick={clickFilter}>Purged</button>
    </div>

    <div>
        <div style="margin-top:22px;">
            <table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow"
                   style="font-size:12px;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Name(Short)</th>
                        <th>Purged at</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr each={deamon in deamons()}>
                        <td nowrap><a href={idLink(deamon)}>{deamon.id}</a></td>
                        <td>{deamon.name}</td>
                        <td nowrap>{deamon.name_short}</td>
                        <td nowrap>{purgedAt(deamon)}</td>
                        <td>{description(deamon)}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
     this.filter = {
         active: true,
         purged: false,
     };
     this.clickFilter = (e) => {
         let key = e.target.getAttribute('action');

         this.filter[key] = !this.filter[key];
         this.update();
     };
    </script>

    <script>
     this.purgedAt = (deamon) => {
         let val =  deamon.purged_at;
         if (!val)
             return ""

         return moment(val).format('YYYY-MM-DD HH:mm');
     };
     this.description = (deamon) => {
         return deamon.description.split('\n')[0];
     };
     this.idLink = (deamon) => {
         return '#deamons/' + deamon.id;
     };
     this.deamons = () => {
         let list = STORE.get('deamons.list');

         return list.filter((deamon)=>{
             if (!this.filter.active && !deamon.purged_at)
                 return false;

             if (!this.filter.purged && deamon.purged_at)
                 return false;

             return true;
         });
     };
    </script>

    <style>
     page-deamons_card-list {
         display: flex;
         flex-direction: column;

         padding: 22px 22px;
     }
    </style>

</page-deamons_card-list>
