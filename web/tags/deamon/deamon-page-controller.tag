<deamon-page-controller>

    <button class="button hw-button" onclick={createImpure} disabled={isAddImpureActive()}>Add Impure</button>
    <button class="button hw-button" onclick={clickPurge}   disabled={isPurgeActive()}>浄化</button>

    <script>
     this.createImpure = () => {
         ACTIONS.openModalCreateDeamonImpure(this.opts.source.deamon);
     };
     this.clickPurge = () => {
         ACTIONS.openModalPuregeDeamon(this.opts.source.deamon);
     };
    </script>

    <script>
     this.isAddImpureActive = () => {
         if (!this.opts.source.deamon || this.opts.source.deamon.purged_at)
             return true;

         return false;
     }
     this.isPurgeActive = () => {
         if (!this.opts.source.deamon || this.opts.source.deamon.purged_at)
             return true;

         let non_purge = this.opts.source.impures.find((d)=>{
             return !d.finished_at;
         });

         if (non_purge)
             return true;

         return false;
     };
    </script>

    <style>
     deamon-page-controller {
         display: flex;
         flex-direction: column;
     }
     deamon-page-controller .button {
         margin-bottom: 11px;
         width:100%;
     }
    </style>

</deamon-page-controller>
