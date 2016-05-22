liberator.log('_vimperatorrc.js loading');
let plugin_paths = [
    '~/.vimperator/vimperator-plugins-other/',
    '~/.vimperator/vimperator-plugins/',
    '~/.vimperator/vimperator-plugins-other/caisui/vimperator/plugin/',
    '~/.vimperator/vimperator-plugins-other/websearch.vimpr.git/'
];
liberator.execute("let g:plugin_loader_roots = '" + (plugin_paths.join(',')) + "'");

let plugin_names = [
    '_libly',
    'alert',
    'auto_source',
    'caret-hint',
    'copy',
    'echopy',
    'feedSomeKeys_3',
    'google-exopen',
    'googleselect',
    'hint-tombloo_elzup',
    'imekeys',
    'longcat',
    'memo',
    'namakubi',
    'nicontroller',
    'nume',
    'pushfind',
    'toggler',
    'tombloo_elzup',
    'twittperator',
    'uaSwitchLite',
    'websearch',
    'youtubeamp',
    'smooth-scroll',
    'multi_requester',
    'trunk'
];
liberator.execute("let g:plugin_loader_plugins = '" + (plugin_names.join(',')) + "'");

// liberator.glovalVariables.plugin_loader_roots = <>
//   ~/.vimperator/vimperator-plugins-other/
//   ~/.vimperator/vimperator-plugins/
//   ~/.vimperator/vimperator-plugins-other/caisui/vimperator/plugin/
//   ~/.vimperator/vimperator-plugins-other/websearch.vimpr/
// </>.toString().split(/\s+/).filter(function(n) !/^!/.test(n));
// 
// liberator.globalVariables.plugin_loader_plugins = <>
//   _libly
//   alert
//   auto_source
//   caret-hint
//   copy
//   echopy
//   feedSomeKeys_3
//   google-exopen
//   googleselect
//   hint-tombloo_elzup
//   imekeys
//   longcat
//   memo
//   nicontroller
//   nume
//   pushfind
//   toggler
//   tombloo_elzup
//   twittperator
//   uaSwitchLite
//   websearch
//   youtubeamp
//   smooth-scroll
//   trunk
// </>.toString().split(/\s+/).filter(function(n) !/^!/.test(n));


liberator.log('_vimperatorrc.js loaded');
// liberator.registerObserver('enter', function () liberator.echo('Initialized.'));
