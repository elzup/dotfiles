(function () {

// ts: "T"ombloo "S"ervice
let tomblooService;
try { tomblooService = getTombloo(); }
catch (e) {
    liberator.log(e.message, 0);
    return;
}

with (tomblooService) {

commands.addUserCommand(
    ['tomblooAction'],
    'Execute Tombloo actions',
    function (args) {
        let f = Tombloo.Service.actions[args.literalArg];
        (f instanceof Function)
            ? f.execute()
            : liberator.echoerr(args.literalArg + ' is not Tombloo Action.');
    },
    {
        literal: 0,
        completer: function (context) {
            context.title = ['Tombloo Actions'];

            let names = Tombloo.Service.actions.names;
            let candidates = [[n, n] for([, n] in Iterator(names))];
            context.completions = candidates.filter(
                function ($_) this.test($_[0]),
                new RegExp(context.filter, 'i')
            );
        },
    }
);

commands.addUserCommand(
    ['tombloo'],
    'Post by Tombloo',
    function (args) {
        liberator.log(args.literalArg, 0);
        let f = Tombloo.Service.extractors[args.literalArg];
        (typeof f === 'object')
            ? Tombloo.Service.share(getContext(), f, args.bang)
            : liberator.echoerr(args.string + ' is not Tombloo command');
    },
    {
        literal: 0,
        bang: true,
        completer: function (context) {
            context.title = ['Tombloo'];

            let extensions = Tombloo.Service.check(getContext());
            let candidates = [[e.name, e.name] for ([, e] in Iterator(extensions))];
            context.completions = candidates.filter(
                function($_) this.test($_[0]),
                new RegExp(context.filter, 'i')
            );
        }
    }
);

} // with (tomblooService)

// helper ---
function getTombloo() {
    const serviceIds = ['@tombfix.github.io/tombfix-service;1', '@brasil.to/tombloo-service;1'];

    for each (let serviceId in serviceIds) {
        if (Cc[serviceId]) {
            return Cc[serviceId].getService().wrappedJSObject;
        }
    }
    throw new Error('Tombloo or Tombfix is not found. install from https://github.com/tombfix/core');
}

function getContext() {
    const doc = window.content.document;
    const win = window.content.wrappedJSObject;

    function getTarget() {
        if (/^http:\/\/reader\.livedoor\.com/.test(buffer.URL)) {
            let item = win.get_active_item && win.get_active_item(true);
            return item ? item.element : doc;
        } else {
            return doc;
        }
    }

    return implant(
        implant(
            {
                document:   doc,
                window:     win,
                title:      doc.title.toString() || '',
                selection:  win.getSelection().toString(),
                target:     getTarget(),
                //event     : event,
                //mouse     : mouse,
                //menu      : gContextMenu,
            },
            {}
        ),
        win.location
    );
}

// stuff ---
function implant(dst, src, keys){
    if (keys) {
        keys.forEach(function(key) { dst[key] = src[key]; });
    }
    else {
        for (let key in src) dst[key] = src[key];
    }

    return dst;
}

})();
