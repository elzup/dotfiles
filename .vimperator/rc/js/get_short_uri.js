function getShortUri(url) {
    let uri = 'https://www.googleapis.com/urlshortener/v1/url';
    let xhr = new XMLHttpRequest();
    xhr.open("post", uri, false);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(JSON.stringify({ longUrl: url }));
    return JSON.parse(xhr.responseText).id;
}

commands.addUserCommand(
    ["shorturi"],
    "get google short URI this page",
    function(args, bang, count){
        let url = buffer.URL;
        if (args[0]) {url = args[0];}
        let result = getShortUri(url);
        util.copyToClipboard(result);
        liberator.echo('Created shortURL: ' + result + "<--" + url);
    }
);
