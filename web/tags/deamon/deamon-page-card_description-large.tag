<deamon-page-card_description-large>

    <div>
        <div class="editor" style="">
            <div>
                <textarea class="textarea"
                          placeholder="Write Markdown"
                          onkeyup={keyUp}></textarea>
            </div>

            <div class="preview">
                <description-markdown source={markdown}></description-markdown>
            </div>
        </div>

        <div class="controller" style="display:flex; justify-content:space-between;">
            <button class="button is-small"
                    onclick={clickCancel}>Cancel</button>
            <button class="button is-small is-danger"
                    onclick={clickSave}>Save</button>
        </div>
    </div>

    <script>
     this.markdown = '';
     this.keyUp = (e) => {
         this.markdown = e.target.value;
         this.tags['description-markdown'].update();
     };
     this.clickCancel = () => {
         this.opts.callback('close');
     };
     this.clickSave = () => {
     };
    </script>

    <style>
     deamon-page-card_description-large {
         display: flex;
         width:  calc(11px * 66 + 11px * 65);
         height: calc(11px * 33 + 11px * 32);

         margin-bottom: 11px;

         background: #fff;
         border-radius: 8px;

         display:flex;
         flex-direction:column;
     }
     deamon-page-card_description-large > div {
         display: flex;
         flex-direction: column;
         height: 100%;
     }
     deamon-page-card_description-large > div > .editor {
         padding-top: 11px;
         flex-grow: 1;
         display: flex;
     }
     deamon-page-card_description-large > div > .editor > div {
         height: 100%;
         flex-grow: 1;
         width: 50%;
     }
     deamon-page-card_description-large > div > .editor .textarea{
         border: none;
         width:100%;
         height:100%;
         resize: none;
         box-shadow: none;
         padding-left: 22px;
     }
     deamon-page-card_description-large > div > .editor .preview{
         overflow: auto;
         padding: 11px;
         background:#eeeeee;
     }
     deamon-page-card_description-large > div > .controller {
         padding: 11px;
     }
    </style>

</deamon-page-card_description-large>
