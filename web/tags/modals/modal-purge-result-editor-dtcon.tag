<modal-purge-result-editor-dtcon>

    <table class="table">
        <tbody>
            <tr>
                <td>基本</td>
                <td>
                    <button class="button is-small"            target={opts.target} action="now" onclick={opts.clickSetDate}>今</button>
                    <button class="button is-small is-warging" target={opts.target} action="revert-start" onclick={opts.clickSetDate}>元に戻す</button>
                </td>
            </tr>
            <tr>
                <td>関連</td>
                <td>
                    <button class="button is-small {isHide('before_end')}"  target={opts.target} action="before-end"  onclick={opts.clickSetDate}>前の作業の終了</button>
                    <button class="button is-small {isHide('after_start')}" target={opts.target} action="after-start" onclick={opts.clickSetDate}>後の作業の開始</button>
                </td>
            </tr>
            <tr>
                <td>クリア</td>
                <td>
                    <button class="button is-small" target={opts.target} action="clear-under-hour" onclick={opts.clickSetDate}>分と秒</button>
                    <button class="button is-small" target={opts.target} action="clear-under-minute" onclick={opts.clickSetDate}>秒</button>
                </td>
            </tr>
        </tbody>
    </table>

    <script>
     this.isHide = (code) => {
         let target = this.opts.target;

         if (target=='start' && code=='before_end')
             return '';

         if (target=='end' && code=='after_start')
             return '';

         return 'hide';
     };
    </script>

</modal-purge-result-editor-dtcon>
