
(function () {

    var hintKey   = liberator.globalVariables.hint_tombloo_key   || 'r';
    var hintXPath = liberator.globalVariables.hint_tombloo_xpath || '//img';

    hints.addMode(
            hintKey,
            'Share by Tombloo',
            function (elem) {
                var tombloo = Cc['@tombfix.github.io/tombfix-service;1'] || Cc['@brasil.to/tombloo-service;1'];
                var tomblooService = tombloo.getService().wrappedJSObject.Tombloo.Service;

                var d = window.content.document;
                var w = window.content.wrappedJSObject;
                var context = {
                    document: d,
                    window:   w,
                    title:    "hogehoge",
                    target:   elem,
                };
                for (let p in w.location) {
                    context[p] = w.location[p];
                }

                var extractors = tomblooService.check(context);
                //        console.log(extractors);
                tomblooService.share(context, extractors[0], false);
            },
            function () hintXPath
    );

})();
