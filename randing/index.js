window.onload = function() {
    document.getElementById("sign-in-button").onclick = function() {
        signIn();
    };
};

function getUri () {
    let config = HOLY_WATER_CONFIG.api;
    let url = config.shceme + '://' + config.host + ':' + config.port + config.path.signin;

    return url;
};

function signIn () {
    let email    = document.getElementById("email").value;
    let password = document.getElementById("password").value;

    let uri = getUri();

    let contents = {
        method: 'POST',
        body: JSON.stringify({
            email: email,
            password: password
        }),
        headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
        }
    };

    fetch(uri, contents)
        .then((res) => {
            location.pathname = /hw/;
        })
        .then(console.log)
        .catch(console.error);
};
