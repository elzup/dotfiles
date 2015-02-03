var INFO =
xml`<plugin
  name="webSearch"
  version="0.2.1"
  href="http://github.com/sugilog"
  summary="vimperator plugin for user customisable web search commands"
  xmlns="http://vimperator.org/namespaces/liberator"
>
  <author email="sugilog@gmail.com">sugilog</author>
  <license>MPL 1.1/GPL 2.0/LGPL 2.1</license>
  <project name="Vimperator" minVersion="2.3"/>
  <item>
  <tags>:[custom command]</tags>
  <spec>:[custom command] <a>keyword</a></spec>
  <description>
    <p>user custom command to search with keyword on web searvice</p>
    <p>command without bang will be searched with new tab as default</p>
    <p>command with bang will be searched with current tab as default</p>
  </description>
  </item>
</plugin>`

// ref: http://vimperator.g.hatena.ne.jp/teramako/20110303/1299154988
// ref: copy.js

liberator.plugins.webSearch = (function() {
  if (typeof liberator.globalVariables.webSearchTemplates == 'undefined') {
    liberator.globalVariables.webSearchTemplates = [];
  }

  var templates = [
{ names: 'wsalc', description: 'search alc', 
url: 'http://eow.alc.co.jp/%KEYWORD%/UTF-8/', tabOpen: true,
urlWithoutKeyword: 'http://www.alc.co.jp' 
},
{ names: ['wsthesaurus'], description: 'search weblioシソーラス類語辞典', tabOpen: true,
url: 'http://thesaurus.weblio.jp/content/%KEYWORD%',
urlWithoutKeyword: 'http://thesaurus.weblio.jp/'
},
  { names: ['wsejje'], description: 'search weblio英和和英辞典', tabOpen: true,
url: 'http://ejje.weblio.jp/content/%KEYWORD%',
urlWithoutKeyword: 'http://ejje.weblio.jp/'
},
  { names: ['wsyoutube'], description: 'search YouTube', tabOpen: true,
url: 'http://www.youtube.com/results?search_query=%KEYWORD%',
urlWithoutKeyword: 'http://www.youtube.com'
},
  { names: ['wskanjifont'], description: 'search moji.tekkai.com', tabOpen: true,
url: 'http://moji.tekkai.com/zoom/%KEYWORD%/page.html',
urlWithoutKeyword: 'http://moji.tekkai.com'
},
  { names: ['wsforvo'], description: 'search FORVO 固有名詞 発音ガイド', tabOpen: true,
url: 'http://ja.forvo.com/search/%KEYWORD%/',
urlWithoutKeyword: 'http://ja.forvo.com/'
},
  { names: ['wsgithub'], description: 'gitub検索', tabOpen: true,
url: 'https://github.com/search?q=%KEYWORD%',
urlWithoutKeyword: 'https://github.com/'
},
  { names: ['wsnico'], description: 'search ニコニコ動画', tabOpen: true,
url: 'http://www.nicovideo.jp/search/%KEYWORD%',
urlWithoutKeyword: 'http://www.nicovideo.jp/'
},
  { names: ['wstwitterfind'], description: 'search Twitter検索', tabOpen: true,
url: 'http://t-proj.org/twitter/?q=%KEYWORD%',
urlWithoutKeyword: 'http://t-proj.org/twitter/'
},
  { names: ['wsgoogleimg'], description: 'google 画像検索', tabOpen: true,
url: 'https://www.google.co.jp/search?hl=ja&site=imghp&tbm=isch&source=hp&biw=1164&bih=722&q=%KEYWORD%',
urlWithoutKeyword: 'https://www.google.co.jp/imghp?hl=ja&tab=wi'
},
  { names: ['wsgoogletrend'], description: 'google トレンド検索', tabOpen: true,
url: 'https://www.google.co.jp/trends/explore#q=%KEYWORD%&cmpt=q',
urlWithoutKeyword: 'https://www.google.co.jp/trends/'
},
  { names: ['wslogsoku'], description: 'ログ速', tabOpen: true,
url: 'http://www.logsoku.com/search?q=%KEYWORD%',
urlWithoutKeyword: 'http://www.logsoku.com/'
},
  { names: ['wstwitterfollow'], description: 'Twitter フォローTL', tabOpen: true,
url: 'https://twitter.com/search?f=follows&q=%KEYWORD%',
urlWithoutKeyword: 'https://twitter.com/search'
},
  { names: ['wstwilog'], description: 'Twilog user', tabOpen: true,
      url: 'http://twilog.org/%KEYWORD%/',
urlWithoutKeyword: 'http://twilog.org/'
},
  { names: ['wsnetslang'], description: 'search ネット用語辞典', tabOpen: true,
url: 'http://netyougo.com/?s=%KEYWORD%',
urlWithoutKeyword: 'http://netyougo.com/'
}]


  templates = templates.concat(
    liberator.globalVariables.webSearchTemplates.map(function(t) {
      return { names: t.names, description: t.description, url: t.url, tabOpen: t.tabOpen, urlWithoutKeyword: t.urlWithoutKeyword, addQmark: t.addQmark }
    })
  );

  templates.forEach(function(template) {
    if (typeof template.names == 'string') {
      template.names = [template.names];
    }

    if (typeof template.urlWithoutKeyword == 'undefined') {
      if (template.url.match(/^((http|https):\/\/[a-z0-9.:@-]+\/)/i)) {
        template.urlWithoutKeyword = RegExp.$1;
      }
    }

    commands.addUserCommand(
      template.names,
      template.description,
      function(arg) {
        if (arg == '') {
          openWithoutKeyword(template.urlWithoutKeyword, tabOpenStatus(arg.bang, template.tabOpen));
        }
        else {
          openWithKeyword(template.url, arg, tabOpenStatus(arg.bang, template.tabOpen));
        }
      },
      {
        argCount : ((typeof template.urlWithoutKeyword == 'undefined') ? '+' : '*'),
        bang     : true
      },
      true
    );

    if (typeof template.urlWithoutKeyword != 'undefined' && typeof template.addQmark != 'undefined') {
      liberator.modules.quickmarks.add(template.addQmark, template.urlWithoutKeyword);
    }
  });

  var openWithKeyword = function(url, keyword, tabOpen) {
    liberator.open(
      url.replace(/%KEYWORD%/, encodeURIComponent(keyword.join('+'))),
      ((tabOpen) ? liberator.NEW_TAB : liberator.CURRENT_TAB)
    );
  }

  var openWithoutKeyword = function(url, tabOpen) {
    liberator.open(
      url,
      ((tabOpen) ? liberator.NEW_TAB : liberator.CURRENT_TAB)
    );
  }

  var tabOpenStatus = function(bang, userSetting) {
    if (typeof userSetting == 'undefined') {
      return !bang;
    }
    else {
      return ((userSetting) ? !bang : bang);
    }
  }
})();

