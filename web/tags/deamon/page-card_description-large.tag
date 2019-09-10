<page-card_description-large style="width:{w()}px; height:{h()}px;">

    <div>
        <div class="editor">
            <div>
                <textarea class="textarea"
                          placeholder="Write Markdown"
                          onkeyup={keyUp}
                          ref="md">
                </textarea>
            </div>

            <div class="preview">
                <description-markdown source={markdownVal()}></description-markdown>
            </div>
        </div>

        <div class="controller" style="display:flex; justify-content:space-between;">
            <button class="button is-small"
                    onclick={clickCancel}>Cancel</button>

            <button class="button is-small is-danger"
                    onclick={clickSave}
                    disabled={isDisable()}>Save</button>
        </div>
    </div>

    <script>
     this.w = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(hw.htVal('size.w', this.opts), 56, 11);
     };
     this.h = () => {
         let hw = new HolyWater();

         return hw.pageCardDescriptionSize(hw.htVal('size.h', this.opts), 24, 11);
     };
    </script>

    <script>
     this.markdown = null;
     this.markdownVal = () => {
         if (this.markdown)
             return this.markdown;

         this.markdown = this.opts.source;
         this.refs.md.textContent = this.markdown;

         return this.markdown;
     };
     this.isDisable = () => {
         if (this.markdown==this.opts.source)
             return 'disabled';

         return '';
     }
     this.on('mount', () => {
         if (this.opts.source.deamon)
             this.markdown = this.opts.source;
     });
     this.keyUp = (e) => {
         this.markdown = e.target.value;
         this.tags['description-markdown'].update();
     };
     this.clickCancel = () => {
         this.opts.callback('close');
     };
     this.clickSave = () => {
         this.opts.callback('save', { contents: this.markdown });
     };
    </script>

    <style>
     page-card_description-large {
         display: flex;

         margin-bottom: 11px;

         background: #fff;
         border-radius: 8px;

         display:flex;
         flex-direction:column;
     }
     page-card_description-large > div {
         display: flex;
         flex-direction: column;
         height: 100%;
     }
     page-card_description-large > div > .editor {
         padding-top: 11px;
         flex-grow: 1;
         display: flex;
         height: 100%;
     }
     page-card_description-large > div > .editor > div {
         height: 100%;
         flex-grow: 1;
         width: 50%;
     }
     page-card_description-large > div > .editor .textarea{
         border: none;
         width:100%;
         height:100%;
         resize: none;
         box-shadow: none;
         padding-left: 22px;

         background: #fdfdfd;
         font-size: 12px;
     }
     page-card_description-large > div > .editor .preview{
         overflow: auto;
         padding: 11px;
     }
     page-card_description-large > div > .controller {
         padding: 11px;
     }
    </style>

</page-card_description-large>
