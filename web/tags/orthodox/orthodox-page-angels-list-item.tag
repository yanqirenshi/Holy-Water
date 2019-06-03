<orthodox-page-angels-list-item>

    <div>
        <h1 class="title is-5 hw-text-white">{opts.duty.name}</h1>

        <div if={angels().length==0}
             style="margin-bottom:22px; padding-left:22px;">
            <p class="hw-text-white" style="font-size: 18px; font-weight:bold;">
                空席
            </p>
        </div>

        <div class="angels">
            <div each={angel in angels()}
                 class="angel hw-box-shadow-light">
                <p>{angel.name}</p>
            </div>
        </div>

    </div>

    <script>
     this.angels = () => {
         let list = this.opts.source.angels.filter((angel) => {
             return angel.orthodox_duty_id == this.opts.duty.id;
         });

         return list.sort((a, b) => {
             return (a.orthodox_angel_appointed_at > b.orthodox_angel_appointed_at) ? 1 : -1;
         });
     };
    </script>

    <style>
     orthodox-page-angels-list-item .title:not(:last-child) {
         margin-bottom: 11px;
         border-bottom: 1px solid #fff;
     }

     orthodox-page-angels-list-item .angels {
         display: flex;
         flex-wrap: wrap;
         padding-left:22px;
         margin-top:22px;
     }
     orthodox-page-angels-list-item .angel {
         width: 88px;
         height: 88px;
         background: #fff;
         border-radius: 88px;
         margin-right: 11px;
         margin-bottom: 11px;

         border: 1px solid #eeeeee;
         font-size: 12px;

         display: flex;
         justify-content: center;
     }
     orthodox-page-angels-list-item .angel > p {
         align-self: center;
         font-weight: bold;
     }
    </style>

</orthodox-page-angels-list-item>
