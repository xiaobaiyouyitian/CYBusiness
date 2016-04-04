#!/usr/bin/env python
#coding:utf8

import tornado.web

from config import etc
from utils import log
from models import sql
from tornado import gen

class LoginHandler(tornado.web.RequestHandler):

    @gen.coroutine
    def get(self):
        self.render('login.html')

    @gen.coroutine
    def post(self):
        try:
            name = self.get_argument('name')
            password = self.get_argument('password')
            if not name or not password:
                self.render('login.html')
            if sql.user_base(name, password):
                self.redirect('/index/')
        except Exception, e:
            log.i(e)



class IndexHandler(tornado.web.RequestHandler):

    @gen.coroutine
    def get(self):
        self.render('index.html')





    
