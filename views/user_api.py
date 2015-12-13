#!/usr/bin/env python
#coding:utf-8

import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.options
import os.path

class BaseHandler(tornado.web.RequestHandler):
    def get_current_user(self):
        return self.get_secure_cookie("username")


class SignInHandler(BaseHandler):
    def get(self):
        self.render('login.html')

    def post(self):
        self.set_secure_cookie("username", self.get_argument("username"))
	self.redirect("/")


class WelcomeHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        self.render('index.html', user=self.current_user)


class SignOutHandler(BaseHandler):
    @tornado.web.authenticated
    def get(self):
        self.clear_all_cookies()
	self.redirect("/")


class SignUpHandler(BaseHandler):
    def get(self):
        pass

    
