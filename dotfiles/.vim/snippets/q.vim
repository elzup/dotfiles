snippet link
abbr [link][]
options word
    [${1:#:link_id}][]${2}
snippet linkid
abbr [link][id]
options word
    [${1:#:link}][${2:id}]${3}
snippet linkurl
abbr [link](url)
options word
    [${1:#:link}](http://${2:#:url})${3}
snippet linkemail
abbr [link](email)
options word
    [${1:#:link}](mailto:${2:#:email})${3}
snippet linkurltitle
abbr [link](url "title")
options word
    [${1:#:link}](${2:#:url} "${3:#:title}")${4}

snippet idurl
abbr [id]: url "title"
options word
    [${1:#:id}]: http://${2:#:url} "${3:#:title}"
snippet idemail
abbr [id]: email "title"
options word
    [${1:#:id}]: mailto:${2:#:url} "${3:#:title}"

snippet altid
abbr ![alt][id]
options word
    ![${1:#:alt}][${2:#:id}]${3}
snippet alturl
abbr ![alt](url)
options word
    ![${1:#:alt}](${2:#:url})${3}
snippet alturltitle
abbr ![alt](url "title")
options word
    ![${1:#:alt}](${2:#:url} "${3:#:title}")${4}

snippet emphasis1
abbr *emphasis*
options word
    *${1}*${2}
snippet emphasis2
abbr _emphasis_
options word
    _${1}_${2}

snippet strong1
abbr **strong**
options word
    **${1}**${2}

snippet strong2
abbr __strong__
options word
    __${1}__${2}

snippet code
abbr `code`
options word
    \`${1}\`${2}

snippet codeblock
abbr code block
options head
    \`\`\`${1:#:language}
    ${2:#:code }
    \`\`\`
