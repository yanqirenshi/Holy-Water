<impure-card-large_tab_show>
    <div style="width:100%; height:100%; display:flex;">

        <div style="flex-grow:1; display:flex; flex-direction:column;">
            <p style="font-weight: bold;">{name()}</p>

            <div class="description" style="padding:11px; overflow:auto;">
                <impure-card-large_tab_show-description contents={this.description()}></impure-card-large_tab_show-description>
            </div>
        </div>

        <div>
            <a class="button is-small is-danger"
               action="finishe-impure"
               onclick={clickButton}>完了</a>
        </div>
    </div>

    <script>
     this.clickButton = (e) => {
         let target = e.target;

         this.opts.callback(target.getAttribute('action'));
     };
    </script>

    <script>
     this.name = () => {
         if (!this.opts.data) return '????????'

         return this.opts.data.name;
     };
     this.description = () => {
         if (!this.opts.data || !this.opts.data.description)
             return ''

         let out = '';
         try {
             out = marked(this.opts.data.description)
             out = out.replace(/{/g, '\\{');
             out = out.replace(/}/g, '\\}');
         } catch (e) {
             dump(e);
             console.trace();
         }

         return out;
     };
    </script>

</impure-card-large_tab_show>
