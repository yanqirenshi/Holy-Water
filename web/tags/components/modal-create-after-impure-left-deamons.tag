<modal-create-after-impure-left-deamons>

    <input class="input is-small martin-top"
           type="text"
           placeholder="Search Deamon"
           ref="deamon_name"
           onkeyup={keyUp}>

    <div class="martin-top">
        <button each={deamon in deamons()}
                class="button is-small deamon"
                deamon_id={deamon.id}
                onclick={clickDeamon}>
            {deamon.name_short} : {deamon.name}
        </button>
    </div>

    <script>
     this.keyword = null;
     this.keyUp = (e) => {
         let keyword = e.target.value;
         if (keyword.length==0)
             this.keyword = null;
         else
             this.keyword = keyword;

         this.update();
     };
     this.clickDeamon = (e) => {
         let id = e.target.getAttribute('deamon_id');
         this.opts.callback('select-deamon', STORE.get('deamons.ht')[id])
     };
     this.deamons = () => {
         let list = STORE.get('deamons.list');

         if (!this.keyword)
             return list;

         let keyword = this.keyword.toLowerCase();
         return list.filter((d) => {
             let name       = d.name.toLowerCase();
             let name_short = d.name_short.toLowerCase();

             return !(name.indexOf(keyword) == -1 && name_short.indexOf(keyword) == -1)
         });
     };
    </script>

    <style>
     modal-create-after-impure-left-deamons .deamon {
         margin-right: 6px;
         margin-bottom: 6px;
     }
    </style>

</modal-create-after-impure-left-deamons>
