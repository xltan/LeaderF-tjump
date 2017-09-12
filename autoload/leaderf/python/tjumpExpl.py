#!/usr/bin/env python
# -*- coding: utf-8 -*-

import vim
import re
import time
from leaderf.utils import *
from leaderf.tagExpl import TagExplorer, TagExplManager

#*****************************************************
# TjumpExplorer
#*****************************************************
class TjumpExplorer(TagExplorer):
    def getContent(self, *args, **kwargs):
        tagname = args[0]
        taglist = lfEval('taglist("%s")' % tagname)
        
        taglist = [tag for tag in taglist if tag['name'] == tagname]
        if len(taglist) == 0:
            return None
        if len(taglist) == 1:
            lfCmd('tag %s' % tagname)
            return []

        for tag in taglist:
            current_file = 1 if lfEval("fnamemodify('%s', ':p')" % tag['filename']) == vim.current.buffer.name else 0
            tag['pri'] = current_file
            tag['filename'] = tag['filename'].replace('\\\\', '/')
        taglist.sort(key=lambda v: -v['pri'])
        content = map(lambda v: '%s\t%s\t%s;"\t%s' % \
            (v['filename'], v['name'], v['cmd'], v['kind']), taglist)
        return content

    def getStlCategory(self):
        return 'Tjump'

#*****************************************************
# TjumpExplManager
#*****************************************************
class TjumpExplManager(TagExplManager):
    def _getExplClass(self):
        return TjumpExplorer

    def _defineMaps(self):
        lfCmd("call leaderf#Tjump#Maps()")

    def startExplorer(self, win_pos, *args, **kwargs):
        self._cli.setNameOnlyFeature(self._getExplorer().supportsNameOnly())
        self._cli.setRefineFeature(self._supportsRefine())
        content = self._getExplorer().getContent(*args, **kwargs)
        if content is None:
            lfCmd("echohl Error | redraw | echo ' No tag found!' | echohl NONE")
            return
		if not content:
			return
        self._getInstance().enterBuffer(win_pos)

        self._getInstance().setStlCategory(self._getExplorer().getStlCategory())
        self._setStlMode()
        self._getInstance().setStlCwd(self._getExplorer().getStlCurDir())

        if lfEval("g:Lf_RememberLastSearch") == '1' and self._launched:
            pass
        else:
            lfCmd("normal! gg")
            self._index = 0

        self._start_time = time.time()

        if isinstance(content, list):
            self._content = content
            self._iteration_end = True
            self._getInstance().setStlTotal(len(content)//self._getUnit())
            if lfEval("g:Lf_RememberLastSearch") == '1' and self._launched:
                pass
            else:
                self._getInstance().setBuffer(content)
            self.input()
        else:
            if lfEval("g:Lf_CursorBlink") == '0':
                self._getInstance().initBuffer(content, self._getUnit(), self._getExplorer().setContent)
                self._content = self._getInstance().buffer[:]
                self._iteration_end = True
                self.input()
            else:
                self._content = []
                self._iteration_end = False
                self._backup = None
                self.input(content)

        self._launched = True

    def _acceptSelection(self, *args, **kwargs):
        if len(args) == 0:
            return
        line = args[0]
        # {tagfile}<Tab>{tagname}<Tab>{tagaddress}[;"<Tab>{tagfield}..]
        tagfile, tagname, right = line.split('\t', 2)
        res = right.split(';"\t', 1)
        tagaddress = res[0]
        try:
            lfCmd("hide edit %s" % escSpecial(tagfile))
        except vim.error as e: # E37
            lfPrintError(e)

        if tagaddress[0] not in '/?':
            lfCmd(tagaddress)
        else:
            lfCmd("norm! gg")
            # In case there are mutiple matches.
            if len(res) > 1:
                result = re.search('(?<=\t)line:\d+', res[1])
                if result:
                    line_nr = result.group(0).split(':')[1]
                    lfCmd(line_nr)
                else: # for c, c++
                    keyword = "(class|enum|struct|union)"
                    result = re.search('(?<=\t)%s:\S+' % keyword, res[1])
                    if result:
                        tagfield = result.group(0).split(":")
                        name = tagfield[0]
                        value = tagfield[-1]
                        lfCmd("call search('\m%s\_s\+%s\_[^;{]*{', 'w')" % (name, value))

            pattern = "\M" + tagaddress[1:-1]
            lfCmd("call search('%s', 'w')" % escQuote(pattern))

        if lfEval("search('\V%s', 'wc')" % escQuote(tagname)) == '0':
            lfCmd("norm! ^")
        lfCmd("norm! zz")

    def _getDigest(self, line, mode):
        """
        specify what part in the line to be processed and highlighted
        Args:
            mode: 0, return the full path
                  1, return the name only
                  2, return the directory name
        """
        if not line:
            return ''
        return line.split('\t', 1)[0]

#*****************************************************
# tjumpExplManager is a singleton
#*****************************************************
tjumpExplManager = TjumpExplManager()

__all__ = ['tjumpExplManager']
