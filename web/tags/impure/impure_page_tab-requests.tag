<impure_page_tab-requests>

    <section class="section" style="padding-top: 22px;">
        <div class="container">
            <h1 class="title hw-text-white"></h1>

            <div class="contents">
                <request-messages-list sources={requests()}></request-messages-list>
            </div>

        </div>
    </section>

    <script>
     this.requests = () => {
         let impure = this.opts.source;

         if (!impure)
             return [];

         return impure.requests;
     };
    </script>

</impure_page_tab-requests>
