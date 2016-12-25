# -*- coding: utf-8 -*-
import subprocess


class Py3status:

    def cmus(self):
        try:
            output = self.py3.command_output(['cmus-remote', '-Q'])
        except:
            return {
                'full_text': '',
                'cached_until': self.py3.time_in(5)
            }
        title = ''
        artist = ''
        status = ''
        for line in output.split('\n'):
            if line.startswith('status paused'):
                status = ''
            if line.startswith('status playing'):
                status = ''
            if line.startswith('status stopped'):
                status = ''
            if line.startswith('file '):
                title = ''.join(line.split('/')[-1].split('.')[:-1])
            if line.startswith('tag title '):
                _title = ''.join(line.split('tag title ')[1:])
                if len(_title)>0:
                    title = _title
            if line.startswith('tag artist '):
                _artist = ''.join(line.split('tag artist ')[1:])
                if len(_artist)>0:
                    artist = _artist
        out = status + '  ' + artist + ': ' + title
        if status == '':
            out = ''
        return {
            'full_text': out,
            'cached_until': self.py3.time_in(1)
        }
