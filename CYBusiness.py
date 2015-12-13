#!/usr/bin/env python
#coding:utf-8

'''
this project for CY and only a practice
'''

import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.options
import etc
from views import user_api

from tornado.options import define, options
define("port", default=8000, help="run on the given port", type=int)

class Application(tornado.web.Application):
    
    def __init__(self):

        settings = dict(
	    template_path=etc.path_tempalte,
	    static_path=etc.path_static,
	    cookie_secret=etc.cookie_secret,
	    login_url=r"/signin",
	    xsrf_cookies=False,
	)
        
        handlers = [
            (r"/", user_api.WelcomeHandler),
            (r"/signin", user_api.SignInHandler),
	    (r"/signout", user_api.SignOutHandler),
	    (r"/signup", user_api.SignUpHandler),
        ]

	tornado.web.Application.__init__(self, handlers, **settings)


if __name__ == '__main__':
    tornado.options.parse_command_line()
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()
