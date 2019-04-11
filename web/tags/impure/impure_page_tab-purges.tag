<impure_page_tab-purges>

    <section class="section" style="padding-top: 22px;">
        <div class="container">
            <h1 class="title hw-text-white"></h1>

            <div class="contents">
                <purges-list  data={purges()} callback={callback}></purges-list>
            </div>

        </div>
    </section>

    <script>
     this.purges = () => {
         if (!this.opts.source)
             return { list: [] };

         return { list: this.opts.source.purges };
     };
     this.callback = (action, data) => {
     };
    </script>

</impure_page_tab-purges>
