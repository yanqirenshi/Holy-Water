<deamon-page-card>

    <deamon-page-card_description if={typeIs('DEAMON-DESCRIPTION')} source={opts.source.contents}></deamon-page-card_description>
    <deamon-page-card_name-short  if={typeIs('DEAMON-CODE')}        source={opts.source.contents}></deamon-page-card_name-short>
    <deamon-page-card_impure      if={typeIs('IMPURES')}            source={opts.source.contents}></deamon-page-card_impure>
    <!-- <deamon-page-card_purges      if={} source={opts.source}></deamon-page-card_purges> -->

    <script>
     this.typeIs = (code) => {
         return this.opts.source.type == code;
     };
    </script>

</deamon-page-card>
