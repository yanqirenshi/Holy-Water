<impure-card-large_tab_edit>
    <div style="display:flex; height:100%; width:100%;">
        <div style="flex-grow:1; display:flex; flex-direction:column;">
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

        <div style="padding-left:8px;">
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
         if (!this.opts.data) return ''
         return this.opts.data.description.trim();
     };
    </script>

    <style>
    </style>
</impure-card-large_tab_edit>
