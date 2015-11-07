
function myline() {
    git ls-files | xargs -n1 git --no-pager blame -f -w|grep $1 | wc -l
}

function git() { hub "$@" }
eval "$(hub alias -s)"

