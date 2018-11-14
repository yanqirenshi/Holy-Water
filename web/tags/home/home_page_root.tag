<home_page_root>
    <div class="bucket-area">
        <home_page_root-buckets></home_page_root-buckets>
    </div>

    <div class="contetns-area">
        <div style="height:100%;">
            <div class="card-container">
                <div style="overflow: hidden; padding-bottom: 222px;">
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                    <impure-card></impure-card>
                </div>
            </div>
        </div>
    </div>

    <style>
     home_page_root {
         height: 100%;
         width: 100%;
         padding: 22px 0px 0px 22px;

         display: flex;
     }

     home_page_root > .contetns-area {
         height: 100%;
         margin-left: 11px;

         flex-grow: 1;
     }

     home_page_root > .contetns-area > div {
         display: flex;
         flex-direction: column;
     }

     home_page_root > .contetns-area > div > .card-container {
         padding-right: 22px;
         display: block;
         overflow: scroll;
         overflow-x: hidden;
         flex-grow: 1;
     }
    </style>
</home_page_root>
