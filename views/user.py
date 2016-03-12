#!/usr/bin/env python
#coding:utf8

import tornado.web

class ApiHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/api.html')

    def post(self):
        pass

class BackBbonusPpresellHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/back_bonus_presell.html')

    def post(self):
        pass

class CinemaListHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/cinema_list.html')

    def post(self):
        pass

class CityTableHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/city_table.html')

    def post(self):
        pass

class GetBonusHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/get_bonus.html')

    def post(self):
        pass

class OrderConfirmHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/order_confirm.html')

    def post(self):
        pass

class OrderErrorHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/order_error.html')

    def post(self):
        pass

class OrderErrorSummaryHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/order_error_summary.html')

    def post(self):
        pass


class OrderListHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/order_list.html')

    def post(self):
        pass


class OrdersRefundHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/orders_refund.html')

    def post(self):
        pass

class PayQueryHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/pay_query.html')

    def post(self):
        pass


class PlayCheckHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/play_check.html')

    def post(self):
        pass

class QryinvalidcodeHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/qryinvalidcode.html')

    def post(self):
        pass

class QueryBonusHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/query_bonus.html')

    def post(self):
        pass

class UserActiveInfoHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/user_active_info.html')

    def post(self):
        pass


class WandaSectionsHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('mario/wanda_sections.html')

    def post(self):
        pass









    
