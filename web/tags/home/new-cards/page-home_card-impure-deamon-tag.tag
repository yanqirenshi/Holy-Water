<page-home_card-impure-deamon-tag>

    <a href="#deamons/{deamonVal('deamon_id')}">
        <span if={deamonVal('deamon_id')}
              class="deamon"
              title={deamonVal('deamon_name')}>
            {deamonVal('deamon_name_short')}
        </span>
    </a>

    <script>
     this.deamonVal = (name) => {
         let impure = this.opts.source;

         if (!impure)
             return null

         return impure[name];
     };
    </script>

    <style>
     page-home_card-impure-deamon-tag .deamon {
         background: #efefef;
         margin-right: 5px;
         padding: 3px 5px;
         border-radius: 3px;
     }

    </style>

</page-home_card-impure-deamon-tag>
