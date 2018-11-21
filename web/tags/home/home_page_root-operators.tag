<home_page_root-operators>
    <div>
        <button class="button is-danger {isHide()}"
                action="open-modal-create-impure"
                onclick={clickButton}>
            「やること」を追加
        </button>
    </div>

    <script>
     this.isHide = () => {
         return this.opts.maledict ? '' : 'hide'
     };
     this.findUp = (element, nodeName) => {
         if (!element) return null;

         if (element.nodeName == nodeName)
             return element;

         return this.findUp(element.parentElement, nodeName);
     };
     this.clickButton = (e) => {
         let button = this.findUp(e.target, 'BUTTON');

         opts.callback(button.getAttribute('action'), this.opts.maledict);
     };
    </script>

    <style>
     home_page_root-operators {
         position: fixed;
         bottom: 22px;
         right: 33px;
     }
     home_page_root-operators .button {
         border-radius: 3px;
         margin-left: 11px;
     }
    </style>
</home_page_root-operators>
