<exorcists-list>

    <table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Ghost ID</th>
            </tr>
        </thead>
        <tbody>
            <tr each={exorcist in exorcists()}>
                <td><a href={idLink(exorcist)}>{exorcist.id}</a></td>
                <td>{exorcist.name}</td>
                <td>{exorcist.ghost_id}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.idLink = (exorcist) => {
         return '#orthodoxs/exorcists/' + exorcist.id;
     };
     this.exorcists = () => {
         return STORE.get('angels.list');
     };
    </script>
</exorcists-list>
