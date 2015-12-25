liberator.globalVariables.googleSelectConfigs = [
    {
        name: 'qiita mypage',
        url: 'https?://qiita\.com/?$',
        element_css_selector: '.activities .item-box-title h1 a',
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
        element_css_selector: '.codesearch-results .repo-list-item h3 a,.code-list-item p.title a:nth-of-type(2),.issue-list-item p.title a,.user-list-info>a',
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
        name: 'github scholar',
        url: 'https?://scholar\.google\.co\.jp',
        element_css_selector: '#gs_ccl .gs_r h3 a',
        marker_posfix: {
            top: '0.0em',
            left: '-1.0em'
        }
    }
];