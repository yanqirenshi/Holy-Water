<impure-card-large_tab_create-after>

    <div class="form-contents">

        <div class="left">
            <input class="input is-small"
                   type="text"
                   placeholder="Title"
                   ref="name"
                   onkeyup={keyUpTitle}>

            <textarea class="textarea is-small"
                      placeholder="Description"
                      rows="6"
                      style="margin-top:11px; flex-grow:1;"
                      ref="description"></textarea>
        </div>

        <div class="right">
            <button class="button is-small" onclick={clickReset}>Reset</button>
            <button class="button is-small" onclick={clickClear}>Clear</button>
            <span style="flex-grow:1;"></span>
            <button class="button is-small is-success" onclick={clickCreate} disabled={isDisable()}>Create!</button>
        </div>

    </div>

    <script>
     this.isDisable = () => {
         return this.refs.name.value.trim().length==0;
     };
     this.keyUpTitle = () => {
         this.update();
     };
    </script>

    <script>
     this.name = '';
     this.description = '';
     STORE.subscribe((action) => {
         if (action.type=='CREATED-IMPURE-AFTER-IMPURE')
             if (action.from.id == this.opts.data.id) {
                 this.clickClear();
             }
     });
     this.clickReset = () => {
         let from = this.opts.data;

         this.refs.name.value = from.name;
         this.refs.description.value = from.description;

         this.update();
     };
     this.clickClear = () => {
         if (!this.refs.name || !this.refs.description) {
             console.wan('TODO: なんで refs がないん？');
             console.wan(this.refs);
         } else {
             this.refs.name.value = '';
             this.refs.description.value = '';
         }

         this.update();
     };
     this.clickCreate = () => {
         ACTIONS.createImpureAfterImpure(this.opts.data, {
             name: this.refs.name.value,
             description: this.refs.description.value,
         })
     };
    </script>

    <style>
     impure-card-large_tab_create-after .form-contents {
         display:flex;
         width:100%;
         height:100%;
     }
     impure-card-large_tab_create-after .form-contents > .left {
         flex-grow:1;

         display:flex;
         flex-direction:column;
     }
     impure-card-large_tab_create-after .form-contents > .right{
         padding-left:8px;
         display:flex;
         flex-direction: column;
     }
     impure-card-large_tab_create-after .form-contents > .right > * {
         margin-bottom: 8px;
     }
    </style>
</impure-card-large_tab_create-after>
