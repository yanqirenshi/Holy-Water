<orthodox-page-angels-list>

    <div>
        <h1 class="title is-3 hw-text-white">構成員</h1>

        <div each={duty in opts.source.duties} style="padding-left:22px;">
            <orthodox-page-angels-list-item duty={duty} source={opts.source}></orthodox-page-angels-list-item>
        </div>

    </div>

</orthodox-page-angels-list>
