<impure_page-controller>

    <div class="controller-container">
        <div class="term">
            <p style="margin-right:11px;">期間</p>

            <input class="input is-small" type="text" placeholder="YYYY-MM-DD" value={opts.source.from.format('YYYY-MM-DD')} disabled>
            <p class="week">{opts.source.from.format('ddd')}</p>

            <p style="margin-left:11px;margin-right:11px;">〜</p>

            <input class="input is-small" type="text" placeholder="YYYY-MM-DD" value={opts.source.to.format('YYYY-MM-DD')} disabled>
            <p class="week">{opts.source.to.format('ddd')}</p>

            <div style="width:33px;"></div>

            <button class="button is-small"onclick={clickRefresh} >Refresh</button>
        </div>

    </div>

    <div class="operators">
        <button class="button is-small" disabled>作業開始</button>
        <button class="button is-small" disabled>作業終了</button>
        <button class="button is-small" disabled>呪文詠唱</button>
        <button class="button is-small" disabled>後続作成</button>
        <button class="button is-small" disabled>埋葬</button>
    </div>

    <script>
     this.clickRefresh = () => {
         this.opts.callback('refresh');
     };
    </script>


    <style>
     impure_page-controller > .controller-container {
         display:flex;
         flex-direction: column;

         background: #FEF264;
         padding: 11px 22px;
         border-radius: 3px;
     }
     impure_page-controller > .controller-container > .term {
         display:flex;
     }
     impure_page-controller > .controller-container > .term > p {
         font-weight: bold;
     }
     impure_page-controller > .controller-container > .term > input.input {
         border-radius: 3px;
         width: 111px;
         text-align: center;
         margin-right: 5px;
     }
     impure_page-controller > .controller-container > .term > .move-date {
         background: none;
         border: none;
     }
     impure_page-controller > .controller-container > .term > .week {
         font-weight:normal;
     }
     impure_page-controller > .operators {
         margin-top: 22px;
         display:flex;
         justify-content:flex-end;
     }
     impure_page-controller > .operators > .button {
         margin-right: 11px;
         box-shadow: 0px 0px 22px #FEF264;
     }
     impure_page-controller > .operators > .button:hover {
         background: #FEF264;
         box-shadow: 0px 0px 22px #ffffff;
     }
    </style>

</impure_page-controller>
