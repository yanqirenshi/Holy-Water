<home_page_root-impures>
    <div class="flex-parent" style="height:100%;">
        <div class="card-container">
            <div style="overflow: hidden; padding-bottom: 222px;">
                <impure-card each={opts.data.list}></impure-card>
            </div>
        </div>
    </div>

    <style>
     home_page_root-impures .flex-parent {
         display: flex;
         flex-direction: column;
     }

     home_page_root-impures .card-container {
         padding-right: 22px;
         display: block;
         overflow: scroll;
         overflow-x: hidden;
         flex-grow: 1;
     }
    </style>
</home_page_root-impures>
