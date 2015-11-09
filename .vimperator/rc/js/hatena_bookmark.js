// mapping
// 空(null)を指定すれば hints や nnoremap を上書きしなくなる
//    (注: 現バージョンではデフォルト値で上書きされてます。将来修正予定です)

liberator.globalVariables.hBookmark_shortcuts = {
    hintsAdd     : 'CA',
    hintsComment : 'CC',
    add          : ['CA'],
    comment      : ['CC']
};

// コマンドの設定
// ここから下の設定は、はてなブックマーク拡張のバージョン 1.2.4a1 以降で有効です。
liberator.globalVariables.hBookmark_commands = {
        hbsearch             : 'hb[search]',
        hbsearch_tab         : 'hbt[absearch]',
        hbsearch_comment     : 'hbc[omment]',
        hbsearch_comment_tab : 'hbtc[omment]',
        hbsearch_url         : 'hbu[rl]',
        hbsearch_url_tab     : 'hbtu[rl]',
        hbsearch_title       : 'hbti[tle]',
        hbsearch_title_tab   : 'hbtti[tle]',
};

// :hb! url 等の bang(!) 付きで開いた場合の挙動。
// 標準ははてブエントリーページを開く entryPage が設定されている。
// 他に新規タブで開く openNewTab がある。
// また、文字列ではなく自分で定義した関数をセットすることもできる。
liberator.globalVariables.hBookmark_bangFunction = 'entryPage';

// 検索時の wait(ms)
liberator.globalVariables.hBookmark_search_interval = 1000;
// 一度に検索する limit
liberator.globalVariables.hBookmark_search_limit = 10;
// 検索時の表示の最大件数。この件数に達するまで検索し続ける。
liberator.globalVariables.hBookmark_search_max_limit = 100;

if (typeof hBookmark != 'undefined') {
    liberator.loadScript('chrome://hatenabookmark/content/vimperator/plugin/hatenabookmark.js', {__proto__: this});
} else {
    console.log('unload hBookmark, hBookmark firefox addon undefined');
}

