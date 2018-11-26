<impure-card-large_tab_show>
    <div>
        <p style="font-weight: bold;">{name()}</p>
        <p class="description">{description()}</p>
        <div>
            <a class="button is-danger"
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
         if (!this.opts.data) return ''
         return this.opts.data.description;
     };
    </script>

    <style>
     impure-card-large_tab_show > div {
         height:422px;
         height:505px;
         overflow:auto;

         display:flex;
         flex-direction:column;
     }
     impure-card-large_tab_show .description {
         margin-top:11px;
         flex-grow:1;
     }

    </style>
</impure-card-large_tab_show>
