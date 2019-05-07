<orthodox-list>

    <table class="table is-bordered is-striped is-narrow is-hoverable hw-box-shadow">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr each={orthodox in orthodoxs()}>
                <td><a href={idLink(orthodox)}>{orthodox.id}</a></td>
                <td>{orthodox.name}</td>
                <td>{orthodox.description}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.idLink = (orthodox) => {
         return '#orthodoxs/' + orthodox.id;
     };
     this.orthodoxs = () => {
         return STORE.get('orthodoxs.list');
     };
    </script>
</orthodox-list>
