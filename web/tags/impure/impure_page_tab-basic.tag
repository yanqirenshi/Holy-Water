<impure_page_tab-basic>

    <section class="section" style="padding-top: 22px;">
        <div class="container">
            <h1 class="title hw-text-white is-4">Name</h1>

            <div class="contents hw-text-white" style="font-weight:bold;">
                <p>{name()}</p>
            </div>
        </div>
    </section>

    <section class="section" style="padding-top: 22px;">
        <div class="container">
            <h1 class="title hw-text-white is-4">Description</h1>

            <div class="contents hw-text-white" style="font-weight:bold;">
                <p><pre>{description()}</pre></p>
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

</impure_page_tab-basic>
