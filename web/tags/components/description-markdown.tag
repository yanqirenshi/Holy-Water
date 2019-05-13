<description-markdown>
    <p>
        <pre ref="markdown-html" style=" background: none;"></pre>
    </p>

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

</description-markdown>
