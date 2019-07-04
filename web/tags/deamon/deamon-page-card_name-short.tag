<deamon-page-card_name-short>

    <div class="small">
        <p class="name">{nameShort()}</p>
    </div>

    <script>
     this.nameShort = () => {
         let deamon = this.opts.source.deamon;

         if (!deamon)
             return ''

         return deamon.name_short;
     };
    </script>

    <style>
     deamon-page-card_name-short > .small{
         display: flex;
         flex-direction: column;
         justify-content: center;

         width: calc(11px * 8 + 11px * 7);
         height: calc(11px * 8 + 11px * 7);
         padding: 8px;
         margin-bottom: 11px;

         background: rgba(22, 22, 14, 0.88);
         border-radius: 8px;
     }

     deamon-page-card_name-short > .small > .name {
         font-size: 33px;
         color: #ec6d71;
         font-weight: bold;
         text-align: center;
     }
    </style>

</deamon-page-card_name-short>
