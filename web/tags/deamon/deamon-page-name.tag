<deamon-page-name>

    <div class="name">
        <h1 class="title hw-text-white"
            if={!edit}>
            悪魔: {name()}
        </h1>

        <input if={edit}
               class="input"
               type="text"
               placeholder="Text input"
               ref="deamon-name"
               value={name()}>
    </div>

    <div class="controller">
        <button if={!edit}
                class="button"
                onclick={clickEdit}>
            Edit
        </button>

        <button if={edit}
                class="button is-warning"
                onclick={clickCancel}>
            Cancel
        </button>

        <button if={edit}
                class="button is-danger"
                onclick={clickSave}>
            Save
        </button>
    </div>

    <script>
     this.edit = false;
     this.clickEdit = () => {
         this.edit = true;
     };
     this.clickCancel = () => {
         this.edit = false;
     };
     this.clickSave = () => {
         let new_name = this.refs['deamon-name'].value;
         ACTIONS.updateDeamonName(this.opts.source.deamon, new_name);
     };
     STORE.subscribe((action)=>{
         if (action.type=='UPDATED-DEAMON-NAME') {
             this.edit = false;
             this.update();
             return;
         }
     });
    </script>

    <script>
     this.name = () => {
         let deamon = this.opts.source.deamon;
         if (!deamon)
             return '';

         return deamon.name;
     };
    </script>

    <style>
     deamon-page-name {
         display: flex;
         width: 100%;
     }
     deamon-page-name .name{
         flex-grow: 1;
         margin-right:11px;
     }
     deamon-page-name .controller .button{
         margin-left:11px;
     }
    </style>

</deamon-page-name>
