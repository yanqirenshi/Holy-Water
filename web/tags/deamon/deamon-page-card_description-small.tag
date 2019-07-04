<deamon-page-card_description-small>

    <div class="description" style="">
        <description-markdown source={description()}></description-markdown>
    </div>

    <div class="controller">
        <button class="button is-small">編集</button>
    </div>

    <script>
     this.description = () => {
         let deamon = this.opts.source.deamon;
         if (!deamon)
             return '';

         return deamon.description;
     };
    </script>

    <style>
     deamon-page-card_description-small {
         display: flex;
         width:  calc(11px * 24 + 11px * 23);
         height: calc(11px * 24 + 11px * 23);

         margin-bottom: 11px;

         background: #fff;
         border-radius: 8px;

         display:flex;
         flex-direction:column;
     }
     deamon-page-card_description-small .description {
         flex-grow:1;
         overflow:auto;

         padding: 22px 11px 11px 11px;

         border-radius: 8px 8px 0px 0px;

         background: #eee;

         font-size:   14px;
         line-height: 14px;
     }
     deamon-page-card_description-small .controller {
         text-align: right;
         margin-top: 8px;
         margin: 8px;
     }
    </style>
</deamon-page-card_description-small>
