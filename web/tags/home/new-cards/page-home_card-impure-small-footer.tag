<page-home_card-impure-small-footer>

    <div class="{opts.status}">
        <button class="button is-small is-grow">照会</button>
        <button class="button is-small is-grow">停止</button>
        <button class="button is-small is-grow">開始</button>
        <button class="button is-small">
            <i class="far fa-envelope-open"></i>
        </button>
    </div>

    <style>
     page-home_card-impure-small-footer > div {
         display: flex;
         justify-content: space-between;
         padding: 8px 11px;
     }
     page-home_card-impure-small-footer > div.started .button {
         font-weight: bold;
         text-shadow: 0px 0px 22px rgba(254, 242, 99, 0.888);
     }
     page-home_card-impure-small-footer .button.is-grow {
         flex-grow:1;
     }
    </style>

</page-home_card-impure-small-footer>
