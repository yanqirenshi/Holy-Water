<modal-change-deamon-area>

    <h1 class="title is-4">Deamons</h1>

    <p class="control has-icons-left has-icons-right">
        <input class="input is-small" type="text" placeholder="Search"
               onkeyup={keyUp}>

        <span class="icon is-small is-left">
            <i class="fas fa-search"></i>
        </span>
    </p>

    <div>
        <button each={deamon in deamons()}
                class="button is-small deamon-item"
                deamon-id={deamon.id}
                onclick={clickDeamon}>
            {deamon.name} ({deamon.name_short})
        </button>
    </div>

    <script>
     this.clickDeamon = (e) => {
         let deamon_id = e.target.getAttribute('deamon-id');

         this.opts.callback('choose-deamon', { id: deamon_id });
     };
    </script>

    <script>
     this.filter = null;

     this.keyUp = (e) => {
         let str = e.target.value;

         if (str.length==0)
             this.filter = null;
         else
             this.filter = str

         this.update();
     };

     this.deamons = () => {
         let filter = this.filter;
         let deamons = STORE.get('deamons.list');

         if (!this.filter)
             return deamons

         filter = filter.toLowerCase();

         let out = deamons.filter((d) => {


             return (d.id + '').toLowerCase().indexOf(filter) >= 0
                 || d.name.toLowerCase().indexOf(filter) >= 0
                 || d.name_short.toLowerCase().indexOf(filter) >= 0
         });

         return out;
     };
    </script>

</modal-change-deamon-area>
