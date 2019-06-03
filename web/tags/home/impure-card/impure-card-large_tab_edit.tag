<impure-card-large_tab_edit>

    <div class="form-contents">
        <div class="left">
            <input class="input is-small"
                   type="text"
                   placeholder="Text input"
                   value={name()}
                   ref="name"
                   style="margin-bottom:8px;">

            <textarea class="textarea description is-small"
                      placeholder="10 lines of textarea"
                      rows="10"
                      style="flex-grow: 1;"
                      ref="description">{description()}</textarea>
        </div>

        <div class="right">
            <span style="flex-grow:1;"></span>
            <button class="button is-small is-danger" onclick={clickSave}>Save</button>
        </div>
    </div>

    <script>
     this.clickSave = () => {
         this.opts.callback('save-impure-contents', {
             id: this.opts.data.id,
             name: this.refs.name.value.trim(),
             description: this.refs.description.value.trim(),
         });
     };
    </script>

    <script>
     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };
     this.description = () => {
         if (!this.opts.data)
             return ''

         return this.opts.data.description.trim();
     };
    </script>

    <style>
     impure-card-large_tab_edit .form-contents {
         display:flex;
         width:100%;
         height:100%;
     }
     impure-card-large_tab_edit .form-contents > .left {
         flex-grow:1;

         display:flex;
         flex-direction:column;
     }
     impure-card-large_tab_edit .form-contents > .right{
         padding-left:8px;
         display:flex;
         flex-direction: column;
     }
    </style>

</impure-card-large_tab_edit>
