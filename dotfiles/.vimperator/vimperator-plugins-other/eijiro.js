/**
 * eijiro
 *
 * @author halt feits <halt.feits@gmail.com>
 * @version 1.0
 */

(function(){
    var url = 'http://eow.alc.co.jp/[word]/UTF-8/?ref=sa';
    vimperator.commands.add(new vimperator.Command(
        ["eijiro"],
        function (args) {
            vimperator.open(url.replace('[word]', args));
        },
        {
            shortHelp: 'eijiro e/j word translator'
        }
    ));
})();
