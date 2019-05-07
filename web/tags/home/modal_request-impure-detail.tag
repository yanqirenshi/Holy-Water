<modal_request-impure-detail>

    <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
            <tr> <th>Type</th> <th>ID</th> <th>Name</th></tr>
        </thead>
        <tbody>
            <tr>
                <th>Impure</th>
                <td>{val('impure', 'id')}</td>
                <td>{val('impure', 'name')}</td>
            </tr>
            <tr>
                <th>Angel</th>
                <td>{val('angel', 'id')}</td>
                <td>{val('angel', 'name')}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.val = (name, key) => {
         if (!opts.source || !opts.source[name])
             return null;

         let obj = opts.source[name];

         return obj[key];
     };
    </script>

</modal_request-impure-detail>
