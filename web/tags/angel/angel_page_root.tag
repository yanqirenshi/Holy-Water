<angel_page_root>
    <section class="section">
        <div class="container">
            <h1 class="title">パスワード変更</h1>
            <h2 class="subtitle">準備中</h2>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title" style="text-shadow: 0px 0px 11px #ffffff;">サインアウト</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <button class="button is-danger"
                        style="margin-left:22px; margin-top:11px;box-shadow: 0px 0px 11px #ffffff;"
                        onclick={clickSignOut}>Sign Out</button>
            </div>
        </div>
    </section>

    <script>
     this.clickSignOut = () => {
         ACTIONS.signOut();
     };
    </script>
</angel_page_root>
