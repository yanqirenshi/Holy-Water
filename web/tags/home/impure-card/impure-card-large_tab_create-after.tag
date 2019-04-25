<impure-card-large_tab_create-after>

    <div  style="display:flex; width:100%; height:100%; flex-direction:row;">

        <div style="flex-grow:1; display:flex; flex-direction:column;">
            <input class="input is-small"
                   type="text"
                   placeholder="Title"
                   ref="name">

            <textarea class="textarea is-small"
                      placeholder="Description"
                      rows="6"
                      style="margin-top:11px; flex-grow:1;"
                      ref="description"></textarea>
        </div>

        <div class="operators" style="display: flex; flex-direction:column; padding-left:8px;">
            <button class="button is-small" onclick={clickReset}>Reset</button>
            <button class="button is-small" onclick={clickClear}>Clear</button>
            <button class="button is-small is-success" onclick={clickCreate}>Create!</button>
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

    <style>
     impure-card-large_tab_create-after .operators > * {
         margin-bottom: 8px;
     }
    </style>
</impure-card-large_tab_create-after>
