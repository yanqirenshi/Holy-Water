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
            <tr each={orthodox in orthodoxs()}>
                <td>{orthodox.id}</td>
                <td>{orthodox.name}</td>
                <td>{orthodox.ghost_id}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.orthodoxs = () => {
         return STORE.get('angels.list');
     };
    </script>
</exorcists-list>
