<description-markdown>
    <div ref="markdown-html" style=" background: none;"></div>

    <script>
     this.on('update', () => {
         this.refs['markdown-html'].innerHTML = '';
     });
     this.on('updated', () => {
         if (!this.opts.source)
             return;

         let html = marked(this.opts.source);

         this.refs['markdown-html'].innerHTML = html;
     });
    </script>

    <style>
     description-markdown * { font-size: 12px; }
     description-markdown h1 { font-size: 16px; font-weight: bold;}

     description-markdown ul    { list-style-type: disc; margin-left: 22px; }
    </style>

</description-markdown>
