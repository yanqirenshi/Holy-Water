<modal-change-deamon>

    <div class="modal {opts.open ? 'is-active' : ''}">
        <div class="modal-background"></div>

        <div class="modal-content" style="width:888px;">

            <div class="card">
                <header class="card-header">
                    <p class="card-header-title">
                        Change Deamon <span style="margin-left: 22px; color: #f00; font-weight:bold;" >注意: 実装中</span>
                    </p>
                </header>

                <div class="card-content">
                    <div class="content">

                        <div class="flex-contener">
                            <div class="choose-demaon-area">
                                <h1 class="title is-4">Deamons</h1>

                                <p class="control has-icons-left has-icons-right">
                                    <input class="input is-small" type="text" placeholder="Search">
                                    <span class="icon is-small is-left">
                                        <i class="fas fa-search"></i>
                                    </span>
                                </p>

                                <div>
                                    <button each={deamon in deamons()}
                                            class="button is-small deamon-item"
                                            deamon_id={deamon.id}>
                                        {deamon.name} ({deamon.name_short})
                                    </button>
                                </div>
                            </div>

                            <div class="view-impure-area">
                                <h1 class="title is-4">Impure</h1>

                                <div style="padding-left:11px;     flex-grow: 1;">
                                    <p>Title (ID: 999)</p>
                                    <p>
                                        markdown;
                                    </p>
                                </div>

                                <div style="height:99px;">
                                    <h1 class="title is-6" style="margin-bottom: 8px;">Deamon</h1>
                                    <div style="padding-left:11px;">
                                        <p>XXXX (YYY)</p>
                                        <button class="button is-small deamon-item">
                                            削除
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div style="display: flex; justify-content: space-between; margin-top: 11px;">
                            <button class="button is-small"
                                    onclick={clickCancel}>Cancel</button>

                            <button class="button is-small is-danger">Save</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <button class="modal-close is-large" aria-label="close"></button>
    </div>

    <script>
     this.deamons = () => {
         return STORE.get('deamons.list');
     };
     this.clickCancel = () => {
         this.opts.callback('close-modal-change-deamon');
     };
    </script>

    <style>
     modal-change-deamon .flex-contener { display:flex; height:555px; }
     modal-change-deamon .choose-demaon-area { flex-grow: 1; padding: 11px; width: 211px; }
     modal-change-deamon .choose-demaon-area .deamon-item { margin-left: 11px; margin-bottom: 11px; }
     modal-change-deamon .view-impure-area   {
         flex-grow: 1;
         padding: 11px;
         background: rgba(254, 242, 100, 0.08);
         border-radius: 8px;
         box-shadow: 0px 0px 22px rgba(254, 242, 100, 0.08);

         display: flex;
         flex-direction: column;
     }
    </style>
</modal-change-deamon>
