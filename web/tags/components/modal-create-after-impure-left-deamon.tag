<modal-create-after-impure-left-deamon>

    <div if={!opts.source}>
        なし
    </div>

    <div if={opts.source}>
        {nameShort()} : {name()}
        <button class="button is-small">削除</button>
    </div>

    <script>
     this.name = () => {
         return opts.source.name;
     }
     this.nameShort = () => {
         return opts.source.name_short;
     }
    </script>

</modal-create-after-impure-left-deamon>
