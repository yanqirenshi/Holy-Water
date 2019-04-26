<impure-card-large_tab_finish>

    <div class="form-contents">

        <div class="left">
            <textarea class="textarea is-large" ;;  is-smal
                      placeholder="完了メッセージ (準備中)"
                      style="width:100%; height:100%;" disabled></textarea>
        </div>

        <div class="right">
            <a class="button is-small" action="finishe-impure" disabled>Clear</a>

            <span style="flex-grow:1;"></span>

            <a class="button is-small is-danger"
               action="finishe-impure"
               onclick={clickButton}>完了</a>
        </div>
    </div>

    <script>
     this.clickButton = (e) => {
         let target = e.target;

         this.opts.callback(target.getAttribute('action'));
     };
    </script>

    <style>
     impure-card-large_tab_finish .form-contents {
         display:flex;
         width:100%;
         height:100%;
     }
     impure-card-large_tab_finish .form-contents > .left {
         flex-grow:1;
         width:100%;
         height:100%;
     }
     impure-card-large_tab_finish .form-contents > .right{
         padding-left:8px;
         display:flex;
         flex-direction: column;
     }
    </style>

</impure-card-large_tab_finish>
