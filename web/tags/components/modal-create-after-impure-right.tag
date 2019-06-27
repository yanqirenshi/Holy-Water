<modal-create-after-impure-right>

    <h1 class="title is-6" style="margin-bottom: 3px;">Title:</h1>
    <p style="padding-left:11px;">{imprueVal('name')}</p>

    <h1 class="title is-6" style="margin-bottom: 3px; margin-top: 11px;">description:</h1>
    <p style="padding-left:11px;">
        <description-markdown source={imprueVal('description')}></description-markdown>
    </p>

    <h1 class="title is-6" style="margin-bottom: 3px; margin-top: 11px;">Deamon:</h1>
    <p style="padding-left:11px;">{imprueVal('deamon')}</p>

    <script>
     this.imprueVal = (name) => {
         let impure = this.opts.source;

         if (!impure)
             return '';

         if (name=='deamon') {
             let deamon = impure.deamon;

             if (!deamon)
                 return ''

             return deamon.name + ' (' + deamon.name_short + ')';
         }

         return impure[name];
     };
    </script>

    <style>
     modal-create-after-impure-right {
         flex-grow: 1;
         display: flex;
         flex-direction: column;
         width:45%;

         padding: 11px;
         background: #eeeeee;
         border-radius: 3px;
     }
    </style>

</modal-create-after-impure-right>
