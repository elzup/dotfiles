liberator.globalVariables.multi_requester_siteinfo = [
    {
        map:            'sam',
        bang:           true,
        name:           'amazon',
        description:    'Amazon 検索',
        url:            'http://www.amazon.co.jp/s/?field-keywords=%s'
    }, {
        map:            'sc',
        bang:           true,
        name:           'googlescholar',
        description:    'Google Scholar 検索',
        url:            'https://scholar.google.co.jp/scholar?q=%s'
    }, {
        map:            'stw',
        bang:           true,
        name:           'twilog',
        description:    'Twilog 検索',
        url:            'http://twilog.org/_elzup_/search?word=%s&ao=a'
    }, {
        map:            'stf',
        bang:           true,
        name:           'favlog',
        description:    'Favolog 検索',
        url:            'http://favolog.org/tweets.rb?id=_elzup_&w=%s&k=tw'
    }, {
        map:            'stg',
        bang:           true,
        name:           'togetter',
        description:    'Togatter 検索',
        url:            'http://togetter.com/search?q=%s'
    }, {
        map:            'sn',
        bang:           true,
        name:           'nico',
        description:    'ニコニコ動画 検索',
        url:            'http://www.nicovideo.jp/search/%s?track=nicouni_search_keyword'
    }, {
        map:            'sty',
        bang:           true,
        name:           'yahootweet',
        description:    'Yahoo リアルタイム検索',
        url:            'http://realtime.search.yahoo.co.jp/search?p=%s&ei=UTF-8'
    }, {
        map:            'san',
        bang:           true,
        name:           'annict',
        description:    'Annict 検索',
        url:            'https://annict.com/search?q=%s'
    }, {
        name:           'rubygems',
        bang:           true,
        description:    'search rubygems.org',
        url:            'http://rubygems.org/search?utf8=%E2%9C%93&query=%s'
    }
];

// map:            ',me',                          // optional: keymap for this siteinfo call
// bang:           true,                           // optional:
// args:           'any'                           // optional:
// name:           'ex',                           // required: subcommand name
// description:    'example',                      // required: commandline short help
// url:            'http://example.com/?%s',       // required: %s <-- replace string
// xpath:          '//*',                          // optional: default all
// srcEncode:      'SHIFT_JIS',                    // optional: default UTF-8
// urlEncode:      'SHIFT_JIS',                    // optional: default srcEncode
// ignoreTags:     'img',                          // optional: default script, syntax 'tag1,tag2,……'
// extractLink:    '//xpath'                       // optional: extract permalink
