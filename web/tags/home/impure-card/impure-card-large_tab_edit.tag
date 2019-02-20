<impure-card-large_tab_edit>
    <div>
        <input class="input" type="text" placeholder="Text input" value={name()} ref="name">
        <textarea class="textarea description"
                  placeholder="10 lines of textarea"
                  rows="10"
                  style="height: 411px;"
        ref="description">{description()}</textarea>
        <div>
            <button class="button" onclick={clickSave}>Save</button>
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
     impure-card-large_tab_edit > div {
         height:295px;
         overflow:auto;

         display:flex;
         flex-direction:column;
     }
     impure-card-large_tab_edit > description {
         margin-top:11px;
         flex-grow:1;
     }
     impure-card-large_tab_edit > div > * {
         margin-top: 11px;
     }
     impure-card-large_tab_edit > div > *:first-child {
         margin-top: 0px;
     }
    </style>
</impure-card-large_tab_edit>
