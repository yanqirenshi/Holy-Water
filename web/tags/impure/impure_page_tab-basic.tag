<impure_page_tab-basic>

    <section class="section" style="padding-top:0px; padding-bottom:22px; style="padding:0px;"">
        <div class="container">
            <h1 class="title hw-text-white is-4" style="margin-bottom: 8px;">Maledict</h1>

            <div class="contents hw-text-white" style="font-weight:bold; padding-left:22px;">
                <p>{maledict()} @{maledict_angel()}</p>
            </div>
        </div>
    </section>

    <section class="section" style="padding-top:0px; padding-bottom:22px; style="padding:0px;"">
        <div class="container">
            <h1 class="title hw-text-white is-4" style="margin-bottom: 8px;">Name</h1>

            <div class="contents hw-text-white" style="font-weight:bold; padding-left:22px;">
                <p>{name()}</p>
            </div>
        </div>
    </section>

    <section class="section" style="padding-top: 22px;">
        <div class="container">
            <h1 class="title hw-text-white is-4" style="margin-bottom: 8px;">Description</h1>

            <div class="contents description" style="margin-left: 22px;">
                <description-markdown source={description()}></description-markdown>
            </div>
        </div>
    </section>

    <script>
     this.maledict = () => {
         if (!this.opts.source.maledict)
             return '???';

         return this.opts.source.maledict.name;
     };
     this.maledict_angel = () => {
         if (!this.opts.source.angel)
             return '';

         return this.opts.source.angel.name;
     };
     this.name = () => {
         let impure = this.opts.source.impure;

         if (!impure)
             return '????????';

         return impure.name;
     };
     this.description = () => {
         let impure = this.opts.source.impure;

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
