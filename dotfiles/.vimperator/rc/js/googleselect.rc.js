liberator.globalVariables.googleSelectConfigs = [
    {
        name: 'qiita mypage',
        url: 'https?://qiita\.com/?$',
        element_css_selector: 'h3.r a',
        marker_posfix: {
            top: '0.0em',
            left: '-1.0em'
        }
    }, {
        name: 'qiita search',
        url: 'https?://qiita\.com/search',
        element_css_selector: '.searchResultContainer_main .searchResult_itemTitle a',
        marker_posfix: {
            top: '0.0em',
            left: '1.0em'
        }
    }, {
        name: 'github repo files',
        url: 'https?://github\.com',
        element_css_selector: 'table.files tr td.content a',
        marker_posfix: {
            top: '0.0em',
            left: '59em'
        }
    }, {
        name: 'github search',
        url: 'https?://github\.com/search',
        element_css_selector: '.repo-list-name a',
        marker_posfix: {
            top: '0.0em',
            left: '-1.0em'
        }
    }, {
        name: 'don cps',
        url: 'https?://.*\.don\.cps\.im\.dendai\.ac\.jp',
        element_css_selector: '.articles h2.title a',
        marker_posfix: {
            top: '0.0em',
            left: '-1.0em'
        }
    }, {
        name: 'anico',
        url: 'https?://anicobin\.ldblog\.jp',
        element_css_selector: '.article-continue',
        marker_posfix: {
            top: '0.0em',
            left: '-1.0em'
        }
    }, {
        name: 'github scholar',
        url: 'https?://scholar\.google\.co\.jp',
        element_css_selector: '#ires .r a',
        marker_posfix: {
            top: '0.0em',
            left: '-1.0em'
        }
    }, {
        name: 'Atcoder Qs',
        url: 'https?://.*.contest.atcoder.jp/assignments',
        element_css_selector: '.table-wb td:nth-of-type(2) a.linkwrapper',
        marker_posfix: {
            top: '0.0em',
            left: '-1.0em'
        }
    }, {
        name: 'AOJ solution',
        url: 'http?://judge.u-aizu.ac.jp/onlinejudge/solution.jsp',
        element_css_selector: 'table.tableRanking td:nth-of-type(2) a',
        marker_posfix: {
            top: '0.0em',
            left: '-1.0em'
        }
    }, {
        name: 'firefox filer',
        url: 'file://',
        element_css_selector: '.file,.dir',
        marker_posfix: {
            top: '0.0em',
            left: '-1.0em'
        }
    }
];
