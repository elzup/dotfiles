
gBrowser.addTab = liberator.eval(
    '(' +
    gBrowser.addTab.toSource()
            .replace(/var\s*aRelatedToCurrent;/, 'var aRelatedToCurrent = true;')
            .replace(/aRelatedToCurrent\s*=\s*params\.relatedToCurrent;/, 'aRelatedToCurrent = params.relatedToCurrent === undefined ? true : params.relatedToCurrent;') +
    ')',
    gBrowser.addTab);
