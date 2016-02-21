#!/usr/bin/env python
#coding:utf-8

'''
this project for CY and only a practice
'''

import sys
import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.options
import tornado.escape

from config import etc
from utils import log

from views import user

reload(sys)
sys.setdefaultencoding('utf8')


class Application(tornado.web.Application):
    
    def __init__(self):

        settings = dict(
	    template_path=etc.path_tempalte,
	    static_path=etc.path_static,
	    cookie_secret=etc.cookie_secret,
	    login_url=r"guest",
	    xsrf_cookies=False,
	    debug=True
	)
        
        handlers = [
            (r'/login/', user.LoginHandler),
            (r'/top/', user.TopHandler),
            (r'/admin/', user.AdminHandler),
            (r'/admin2/', user.Admin2Handler),
            (r'/admin3/', user.Admin3Handler),
            (r'/admin4/', user.Admin4Handler),
            (r'/admin5/', user.Admin5Handler),
            (r'/admin6/', user.Admin6Handler),
            (r'/admin7/', user.Admin7Handler),
            (r'/admin8/', user.Admin8Handler),
            (r'/admin9/', user.Admin9Handler),
            (r'/admin10/', user.Admin10Handler),
            (r'/admin11/', user.Admin11Handler),
            (r'/admin12/', user.Admin12Handler),
	]

	tornado.web.Application.__init__(self, handlers, **settings)

def main(p_port):
    if p_port == 0:
        print 'port could not be set as 0'
	log.e('port could not be set as 0')
	exit(1)
    log.c('www listening on port : %s' % p_port)
    app = Application()
    app.listen(p_port)
    log.i(app.settings['template_path'])
    log.i(app.settings['static_path'])
    tornado.ioloop.IOLoop.instance().start()


if __name__ == '__main__':
    main(10000)


