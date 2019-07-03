<page-impure-card-status>

    <div>
        <p>状況</p>
    </div>

    <div>
        <p>{purgeNow()}</p>
        <p>{finished()}</p>
    </div>

    <script>
     this.finished = () => {
         let impure = this.opts.source.impure;

         if (!impure)
             return '';

         if (!impure.finished_at)
             return '未浄化';

         return '浄化済み';
     }
     this.purgeNow = () => {
         let impure = this.opts.source.impure;

         if (!impure)
             return '';

         if (!impure.purge)
             return '';

         return 'パージ中';
     };
    </script>

    <style>
     page-impure-card-status {
         display: block;
         width:  calc(88px * 2 + 11px * 1);
         height: calc(88px * 2 + 11px * 1);
         padding: 11px;
         background: rgba(255,255,255,0.88);;
         border-radius: 8px;
     }
    </style>
</page-impure-card-status>
