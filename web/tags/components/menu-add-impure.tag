<menu-add-impure>

    <div style="position:fixed; right: 33px; top: 22px; ">
        <button class="button add-impure is-small hw-button"
                onclick={clickButton}>add Impure</button>
    </div>

    <script>
     this.maledict = () => {
         let maledict = STORE.get('maledicts.list').find((d) => {
             return d['maledict-type'].NAME == 'In Box';
         });

         return maledict
     };
     this.clickButton = () => {
         ACTIONS.openModalCreateImpure(this.maledict());
     };
    </script>

</menu-add-impure>
