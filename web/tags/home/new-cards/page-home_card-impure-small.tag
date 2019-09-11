<page-home_card-impure-small>

    <div class="{status()}">
        <page-home_card-impure-small-body source={opts.source}
                                          status={status()}></page-home_card-impure-small-body>

        <page-home_card-impure-small-footer source={opts.source}
                                            status={status()}></page-home_card-impure-small-footer>
    </div>

    <script>
     this.status = () => {
         return this.opts.is_start_action ? 'started' : '';
     };
    </script>

    <style>
     page-home_card-impure-small > div {
         display: flex;
         flex-direction: column;

         width:  calc((22px * 4) * 2 + 22px * (4 - 1));
         height: calc((22px * 4) * 2 + 22px * (4 - 1));

         background: #fff;
         border-radius: 5px;
         padding-top:11px;
     }
     page-home_card-impure-small > div.started {
         box-shadow: 0px 0px 22px rgba(254, 242, 99, 0.888);
     }
     page-home_card-impure-small > div > page-home_card-impure-small-body {
         flex-grow: 1;
         flex-direction: column;
     }
    </style>

</page-home_card-impure-small>
