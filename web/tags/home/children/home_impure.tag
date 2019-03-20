<home_impure>
    <script>
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
    </script>
</home_impure>
