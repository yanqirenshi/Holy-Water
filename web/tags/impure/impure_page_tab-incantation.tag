<impure_page_tab-incantation>

    <section class="section" style="padding-top: 22px;">
        <div class="container">
            <h1 class="title hw-text-white"></h1>

            <div class="contents">
                <request-messages-list sources={sources()}></request-messages-list>
            </div>

        </div>
    </section>

    <script>
     this.sources = () => {
         let impure = this.opts.source;

         if (!impure)
             return [];

         return impure.sources;
     };
    </script>

</impure_page_tab-incantation>
