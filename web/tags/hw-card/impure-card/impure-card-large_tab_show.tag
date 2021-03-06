<impure-card-large_tab_show>
    <div style="width:100%; height:279px; overflow:auto;">

        <div style="flex-grow:1; display:flex; flex-direction:column;">
            <p if={opts.data.deamon_id} style="font-size:14px;">Deamon: {deamon()}</p>

            <p style="font-weight: bold;">{name()}</p>

            <div class="description" style="padding:11px; overflow:auto;">
                <description-markdown source={this.description()}></description-markdown>
            </div>
        </div>

    </div>

    <script>
     this.deamon = () => {
         let impure = this.opts.data;

         if (!impure)
             return null

         return "%s (%s)".format(this.opts.data.deamon_name, this.opts.data.deamon_name_short);
     };
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
             console.warn(e);
             console.trace();
         }

         return out;
     };
    </script>

</impure-card-large_tab_show>
