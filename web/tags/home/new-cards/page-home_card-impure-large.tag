<page-home_card-impure-large>

    <div class="{status()}">
        <page-home_card-impure-large-header source={opts.source}
                                            status={status()}></page-home_card-impure-large-header>

        <page-home_card-impure-large-body source={opts.source}
                                          status={status()}></page-home_card-impure-large-body>

        <page-home_card-impure-large-footer source={opts.source}
                                            status={status()}></page-home_card-impure-large-footer>
    </div>

    <script>
     this.status = () => {
         return this.opts.is_start_action ? 'started' : '';
     };
    </script>

    <style>
     page-home_card-impure-large > div {
         display: flex;
         flex-direction: column;

         width:  calc((22px * 12) * 2 + 22px * (12 - 1));
         height: calc((22px * 8) * 2 + 22px * (8 - 1));

         background: #fff;

         border-radius: 8px;
     }
     page-home_card-impure-large > div.started {
         box-shadow: 0px 0px 22px rgba(254, 242, 99, 0.888);
     }
    </style>

</page-home_card-impure-large>
