#!/usr/bin/env python
#coding:utf-8

import sys
import os
import logging

'''
Applcation etc
'''

path_tempalte = os.path.join(sys.path[0], "template")
path_static = os.path.join(sys.path[0], "static")

cookie_name = 'cyb_cookie'

cookie_secret = "bZJc2sWbQLKos6GkHn/VB9oXwQt8S0R0kRvJ5/xJ89E="


'''
mysql etc
'''
mysql_user = 'root'
mysql_passwd = '123'
mysql_host = 'localhost'
mysql_port = 3306
mysql_db_name = 'cybusiness'

machine_no_dict = {
    'localhost': 1,
    'root': 2,
    'hhk-PC': 3,
    }


'''
log
'''
logfile = os.path.join('path_log', 'CYBusiness')
LOG_LEVEL = logging.DEBUG



