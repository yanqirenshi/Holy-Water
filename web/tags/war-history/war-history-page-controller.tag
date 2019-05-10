<war-history-page-controller>

    <section class="section">
        <div class="container">

            <div class="contents">
                <div class="condition">
                    <p class="text is-small" style="margin-right:8px;">期間: </p>
                    <input class="input is-small" type="text" placeholder="From" value={this.from} ref="from">
                    <p class="text">〜</p>
                    <input class="input is-small" type="text" placeholder="To"   value={this.to}   ref="to">
                </div>

                <div class="condition">
                    <p class="text is-small" style="margin-left: 22px; margin-right:8px;">集計単位:</p>
                    <div class="select is-small">
                        <select>
                            <option>Daily</option>
                        </select>
                    </div>
                </div>

                <div class="operator">
                    <button class="button is-small" onclick={clickRefresh}>Refresh</button>
                </div>

            </div>

        </div>
    </section>

    <script>
     this.from = this.opts.term.from.format('YYYY-MM-DD');
     this.to   = this.opts.term.to.format('YYYY-MM-DD');

     this.clickRefresh = () => {
         let from = moment(this.refs.from.value);
         let to   = moment(this.refs.to.value);

         this.opts.callback('refresh', { from: from, to: to });
     };
    </script>

    <style>
     war-history-page-controller > .section {
         padding-top:0px;
         padding-bottom:11px;
     }
     war-history-page-controller > .section > .container > .contents{
         display: flex;
         width: 577px;
         background: rgb(254, 242, 99, 0.55);
         padding: 11px 22px;
         border-radius: 8px;
     }
     war-history-page-controller .condition {
         display: flex;
     }
     war-history-page-controller .operator {
         margin-left: 22px;
     }
     war-history-page-controller .condition > .input {
         width: 111px;
     }
     war-history-page-controller .condition > p {
         margin-top: 1px;
         margin-top: 1px;
         text-shadow: 0px 0px 8px #fff;
         color: #333;
         font-weight: bold;
         word-break:keep-all;
     }
    </style>

</war-history-page-controller>
