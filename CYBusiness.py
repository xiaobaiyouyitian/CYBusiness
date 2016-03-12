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
            (r'/api/', user.ApiHandler),
            (r'/back/bonus/presell/', user.BackBbonusPpresellHandler),
            (r'/cinema/list/', user.CinemaListHandler),
            (r'/city/table/', user.CityTableHandler),
            (r'/get/bonus/', user.GetBonusHandler),
            (r'/order/confirm/', user.OrderConfirmHandler),
            (r'/order/error/', user.OrderErrorHandler),
            (r'/order/error/summary/', user.OrderErrorSummaryHandler),
            (r'/order/list/', user.OrderListHandler),
            (r'/orders/refund/', user.OrdersRefundHandler),
            (r'/pay/query/', user.PayQueryHandler),
            (r'/play/check/', user.PlayCheckHandler),
            (r'/qryinvalidcode/', user.QryinvalidcodeHandler),
            (r'/query/bonus/', user.QueryBonusHandler),
            (r'/user/active/info/', user.UserActiveInfoHandler),
            (r'/wanda/sections/', user.WandaSectionsHandler),
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
    main(8000)


