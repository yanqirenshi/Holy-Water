<impure_page-controller>

    <div class="controller-container" style="">
        <p>期間</p>
        <input class="input is-small" type="text" placeholder="YYYY-MM-DD">
        <p>〜</p>
        <input class="input is-small" type="text" placeholder="YYYY-MM-DD">
        <button class="button is-small" disabled>Refresh ※準備中</button>
    </div>

    <style>
     impure_page-controller > .controller-container {
         display:flex;
         background: #FEF264;
         padding: 11px 22px;
         border-radius: 3px;
     }
     impure_page-controller > .controller-container > * {
         margin-right: 11px;
     }
     impure_page-controller > .controller-container > p {
         font-weight: bold;
     }
     impure_page-controller > .controller-container > input.input {
         border-radius: 3px;
         width: 111px;
     }
    </style>

</impure_page-controller>
