<impure-card-large_tab_finish>

    <div class="form-contents">

        <div class="left">
            <textarea class="textarea is-small"
                      placeholder="完了時のメモなどがあれば入力してください。(任意項目)"
                      style="width:100%; height:100%;"
                      ref="spell"></textarea>
        </div>

        <div class="right">
            <a class="button is-small"
               action="finishe-impure"
               onclick={clickClearButton}>Clear</a>

            <span style="flex-grow:1;"></span>

            <a class="button is-small is-danger"
               action="finishe-impure"
               onclick={clickFinishButton}>完了</a>
        </div>
    </div>

    <script>
     this.clickClearButton = (e) => {
         this.refs.spell.value = '';
     }
     this.clickFinishButton = (e) => {
         let target = e.target;
         let spell = this.refs.spell.value.trim();

         this.opts.callback(target.getAttribute('action'), { spell: spell });
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
