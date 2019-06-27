<modal-create-after-impure-center>

    <h1 class="title is-6">Copy</h1>

    <button class="button is-small"
            onclick={clickCopy}>←</button>

    <script>
     this.clickCopy = () => {
         this.opts.callback('copy');
     };
    </script>

    <style>
     modal-create-after-impure-center {
         display:flex;
         flex-direction: column;
         justify-content: center;

         padding-left: 22px;
         padding-right: 22px;
     }
    </style>

</modal-create-after-impure-center>
