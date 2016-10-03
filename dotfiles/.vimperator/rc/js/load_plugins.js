liberator.log('_vimperatorrc.js loading');
let plugin_paths = [
    '~/.vimperator/vimperator-plugins/'
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
    'imekeys',
    'longcat',
    'memo',
    'nume',
    'pushfind',
    'toggler',
    // 'twittperator',      error
    'uaSwitchLite',
    'websearch',
    'smooth-scroll',
    'multi_requester',
    // 'pluginManager',     error
    'trunk'
];
liberator.execute("let g:plugin_loader_plugins = '" + (plugin_names.join(',')) + "'");


liberator.log('_vimperatorrc.js loaded');
// liberator.registerObserver('enter', function () liberator.echo('Initialized.'));
