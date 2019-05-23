<impure_page-controller>

    <div class="controller-container">

        <div class="operators">
            <button class="button is-small"onclick={clickRefresh} >Refresh</button>
            <span style="flex-grow:1;"></span>
            <button class="button is-small" disabled>作業開始</button>
            <button class="button is-small" disabled>作業終了</button>
            <button class="button is-small" disabled>呪文詠唱</button>
            <button class="button is-small" disabled>後続作成</button>
            <button class="button is-small" disabled>埋葬</button>
        </div>

    </div>

    <script>
     this.clickRefresh = () => {
         this.opts.callback('refresh');
     };
    </script>


    <style>
     impure_page-controller > .controller-container {
         background: #FEF264;
         padding: 11px 22px;
         border-radius: 3px;
     }
     impure_page-controller .operators {
         display:flex;
     }
     impure_page-controller .operators > * { margin-right:11px; }
     impure_page-controller .operators > *:last-child { margin-right:0px; }
    </style>

</impure_page-controller>
