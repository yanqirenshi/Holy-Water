<hw-page-header>

    <section class="section" style="padding-bottom: 22px;">
        <div class="container">
            <h1 class="title hw-text-white">{opts.title}</h1>
            <h2 class="subtitle hw-text-white">
                <p>{opts.subtitle}</p>
                <section-breadcrumb class="{isHide()}"></section-breadcrumb>
            </h2>
        </div>
    </section>

    <script>
     this.isHide = () => {
         if (!this.opts || !this.opts.type)
             return 'hide';
         dump(this.opts.type);
         if (this.opts.type=='child')
             return '';

         return 'hide';
     };
    </script>

</hw-page-header>
