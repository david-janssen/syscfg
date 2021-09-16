#!/usr/bin/env python


import subprocess

def get_pass(service, cmd):
    return subprocess.check_output(cmd, )

def include_p_gmail(n):
    return n in ['[Gmail]/All Mail', '[Gmail]/Drafts', '[Gmail]/Trash']

def nametrans_gmail(n):
    return {'[Gmail]/All Mail': 'all',
            '[Gmail]/Drafts':   'drafts',
            '[Gmail]/Trash':    'trash'}.get(n, '')
