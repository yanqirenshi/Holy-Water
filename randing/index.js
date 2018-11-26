window.onload = function() {
    document.getElementById("sign-in-button").onclick = function() {
        signIn();
    };
};

function getUri () {
    return 'http://satoshi-iwasaki.local:8080/hw/api/v1/sign/in';
};

function signIn () {
    let email    = document.getElementById("email").value;
    let password = document.getElementById("password").value;

    let uri = getUri();

    fetch(uri, {
        method: 'POST',
        body: {
            email: email,
            password: password
        }
    });
};
