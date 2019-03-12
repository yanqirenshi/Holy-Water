<impure-card-large_tab_create-after>

    <input class="input"
           type="text"
           placeholder="Title"
           ref="name"
           style="margin-top:11px;">

    <textarea class="textarea"
              placeholder="Description"
              rows="6"
              style="margin-top:11px;"
              ref="description"></textarea>

    <div style="margin-top:22px; display: flex; justify-content: space-between;">
        <div>
            <button class="button" onclick={clickReset}>Reset</button>
            <button class="button" onclick={clickClear}>Clear</button>
        </div>

        <div>
            <button class="button is-success" onclick={clickCreate}>Create!</button>
        </div>
    </div>

    <script>
     this.clickReset = () => {
         let from = this.opts.data;

         this.refs.name.value = from.name;
         this.refs.description.value = from.description;
     };
     this.clickClear = () => {
         this.refs.name.value = '';
         this.refs.description.value = '';
     };
     this.clickCreate = () => {
         ACTIONS.createImpureAfterImpure(this.opts.data, {
             name: this.refs.name.value,
             description: this.refs.description.value,
         })
     };
    </script>
</impure-card-large_tab_create-after>
