<angel_page class="page-contents">

    <section class="section">
        <div class="container">

            <section class="section">
                <div class="container">
                    <h1 class="title is-4 hw-text-white">パスワード変更</h1>
                    <h2 class="subtitle hw-text-white">準備中</h2>
                </div>
            </section>

            <section class="section">
                <div class="container">
                    <h1 class="title is-4 hw-text-white">サインアウト</h1>
                    <h2 class="subtitle hw-text-white"></h2>
                    <div class="contents">
                        <button class="button is-danger hw-box-shadow"
                                style="margin-left:22px; margin-top:11px;"
                                onclick={clickSignOut}>Sign Out</button>
                    </div>
                </div>
            </section>
        </div>
    </section>

    <script>
     this.clickSignOut = () => {
         ACTIONS.signOut();
     };
    </script>
</angel_page>
