<page-tabs>
    <div class="tabs is-{type()} is-small">
        <ul>
            <li each={opts.core.tabs}
                class="{opts.core.active_tab==code ? 'is-active' : ''}">
                <a code={code}
                   onclick={clickTab}>{label}</a>
            </li>
        </ul>
    </div>

    <script>
     this.clickTab = (e) => {
         let code = e.target.getAttribute('code');
         this.opts.callback(e, 'CLICK-TAB', { code: code });
     };
     this.type = () => {
         return this.opts.type ? this.opts.type : 'boxed';
     };
    </script>

    <style>
     page-tabs .is-boxed li:first-child { margin-left: 22px; }

     page-tabs .is-toggle li a {
         background: #ffffff;
     }

     page-tabs .tabs.is-toggle li.is-active a {
         background-color: RGB(254, 242, 99);
         border-color: RGB(254, 242, 99);
         font-weight: bold;
     }

    </style>


</page-tabs>
