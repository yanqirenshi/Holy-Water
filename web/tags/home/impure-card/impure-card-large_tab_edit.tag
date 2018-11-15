<impure-card-large_tab_edit>
    <input class="input" type="text" placeholder="Text input" value={name()}>
    <textarea class="textarea"
              placeholder="10 lines of textarea"
              rows="10"
              style="height: 411px;">{description()}</textarea>
    <button class="button">Save</button>

    <script>
     this.name = () => {
         if (!this.opts.data) return '????????'
         return this.opts.data.name;
     };
     this.description = () => {
         if (!this.opts.data) return ''
         return this.opts.data.description;
     };
    </script>

    <style>
     impure-card-large_tab_edit > *{
         margin-bottom: 11px;
     }
     impure-card-large_tab_edit > *:last-child{
         margin-bottom: 0px;
     }
    </style>
</impure-card-large_tab_edit>
