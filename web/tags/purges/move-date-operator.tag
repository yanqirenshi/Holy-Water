<move-date-operator>
    <div class="operator hw-box-shadow">
        <div class="befor">
            <button class="button" onclick={clickBefor}><</button>
        </div>

        <div class="trg">
            <span>{opts.label}</span>
        </div>

        <div class="after">
            <button class="button" onclick={clickAfter}>></button>
        </div>
    </div>

    <script>
     this.clickBefor = () => {
         this.opts.callback('move-date', {
             unit: this.opts.unit,
             amount: -1,
         });
     }
     this.clickAfter = () => {
         this.opts.callback('move-date', {
             unit: this.opts.unit,
             amount: 1,
         });
     }
    </script>

    <style>
     move-date-operator .operator {
         display: flex;
         margin-left:11px;
         border-radius: 8px;
     }
     move-date-operator .operator span {
         font-size:18px;
     }
     move-date-operator .button{
         border: none;
     }
     move-date-operator .befor,
     move-date-operator .befor .button{
         border-radius: 8px 0px 0px 8px;
     }
     move-date-operator .after,
     move-date-operator .after .button{
         border-radius: 0px 8px 8px 0px;
     }
     move-date-operator .operator > div {
         border: 1px solid #dbdbdb;
         width: 36px;
     }
     move-date-operator .operator > div.trg{
         padding-top: 5px;
         padding-left: 8px;
         border-left: none;
         border-right: none;
         background: #ffffff;
     }
    </style>
</move-date-operator>
