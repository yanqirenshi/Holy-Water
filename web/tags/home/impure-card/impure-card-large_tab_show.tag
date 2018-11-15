<impure-card-large_tab_show>
    <div style="height:422px; height:505px; overflow:auto;">
        <p style="font-weight: bold;">{name()}</p>
        <p style="margin-top:11px;">{description()}</p>
    </div>

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
</impure-card-large_tab_show>
