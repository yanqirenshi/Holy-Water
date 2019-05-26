<impure_page_tab-basic>

    <section class="section" style="padding-bottom:22px; style="padding:0px;"">
        <div class="container">
            <h1 class="title hw-text-white is-4">Name</h1>

            <div class="contents hw-text-white" style="font-weight:bold; padding-left:22px;">
                <p>{name()}</p>
            </div>
        </div>
    </section>

    <section class="section" style="padding-top: 22px;">
        <div class="container">
            <h1 class="title hw-text-white is-4">Description</h1>

            <div class="contents description" style="margin-left: 22px;">
                <description-markdown source={description()}></description-markdown>
            </div>
        </div>
    </section>

    <script>
     this.name = () => {
         let impure = this.opts.source;

         if (!impure)
             return '????????';

         return impure.name;
     };
     this.description = () => {
         let impure = this.opts.source;

         if (!impure)
             return '????????';

         return impure.description;
     };
    </script>

    <style>
     impure_page_tab-basic .description {
         background: #fff;
         border-radius: 3px;
         line-height: 14px;
     }
     impure_page_tab-basic description-markdown > div {
         padding: 22px;
     }
    </style>

</impure_page_tab-basic>
