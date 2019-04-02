<home_requtest-area>
    <p class={isHide()}>
        依頼メッセージ未読: <a href="#home/requests"><span class="count">999</span></a> 件
    </p>

    <script>
     this.isHide = () => {
         return 'hide';
     };
    </script>

    <style>
     home_requtest-area > p {
         color: #fff;
         font-weight: bold;
         font-size: 14px;
         line-height: 38px;
     }

     home_requtest-area .count {
         color: #f00;
         font-size: 21px;
     }
    </style>
</home_requtest-area>
