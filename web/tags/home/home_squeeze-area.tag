<home_squeeze-area>
    <div style="width:444px; margin-bottom:22px; margin-left:22px;">
        <div class="control has-icons-left has-icons-right">
            <input class="input is-rounded"
                   type="text"
                   placeholder="Squeeze Impure※ まだ表示のみで機能しません。"
                   onKeyUp="{onKeyUp}"
                   ref="word">
            <span class="icon is-left">
                <i class="fas fa-search" aria-hidden="true"></i>
            </span>
        </div>

    </div>

    <button class="button" onclick={clickClearButton}>
        <i class="fas fa-times-circle"></i>
    </button>

    <script>
     this.clickClearButton = (e) => {
         this.refs.word.value = '';
         this.opts.callback('squeeze-impure', '');
     };

     this.onKeyUp = (e) => {
         this.opts.callback('squeeze-impure', e.target.value);
     };
    </script>

    <style>
     home_squeeze-area {
         display: flex;
     }
     home_squeeze-area .button{
         padding: 0px;
         margin-left: 8px;
         background: none;
         border: none;
         color: #ffff;
     }
     home_squeeze-area .button:hover{
         color: #880000;
     }
     home_squeeze-area .button i{
         font-size: 33px;
     }
    </style>
</home_squeeze-area>
