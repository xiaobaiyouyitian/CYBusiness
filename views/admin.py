#!/usr/bin/env pyhon
#coding:utf-8

import uuid
import base64

import tornado.web

from config import etc
from utils import log
from models import sql
from tornado import gen


class BaseHandler(tornado.web.RequestHandler):
    "继承RequestHandler,重写get_current_user方法."

    def get_current_user(self):
        "返回值即为self.current_user的值."
        try:
            cookie = self.get_secure_cookie(etc.cookie_name)
            if cookie:
                user = sql.get_user_base_by_cookie(cookie)
                if user:
                    return user
                return {}
            return {}
        except Exception, e:
            log.d(e)


class AdminLoginHandler(BaseHandler):
    "登录接口,/admin/login/"

    def get(self):
        try:
            notice_str = ''
            self.render('admin_login.html', notice=notice_str)
        except Exception, e:
            log.d(e)

            
    def post(self):
        try:
            name = self.get_argument('name')
            password = self.get_argument('password')
            if not name or not password:
                notice_str = '不能为空!'
                self.render('admin_login.html', notice=notice_str)
                return
            user = sql.get_user_base_by_name_password(name, password)
            if user:
                cookie = base64.b64encode(uuid.uuid4().bytes + uuid.uuid4().bytes)
                sql.save_session_by_userid_and_cookie(user['id'], cookie)
                self.set_secure_cookie(etc.cookie_name, cookie)
                self.redirect('/admin/')
            else:
                notice_str = '没有该用户，请重新输入!'
                self.render('admin_login.html', notice = notice_str)
        except Exception, e:
            log.d(e)
                

class AdminHandler(BaseHandler):
    "首页接口,`/admin/`"

    @tornado.web.authenticated
    "`authenticated`装饰器,当self.current_user为空时,自行跳转到login_url指向的地址."
    def get(self):
        try:
            current_user = self.current_user['name']
            self.render('admin.html', name=current_user)
        except Exception, e:
            log.d(e)


class AdminLogoutHandler(BaseHandler):
    "登出接口,`/admin/logout/`"

    @tornado.web.authenticated
    def get(self):
        try:
            self.clear_cookie(etc.cookie_name)
            self.redirect('/admin/')
        except Exception, e:
            log.d(e)


class AdminPublicGoodsHandler(BaseHandler):
    "发布商品,`/admin/public/goods/`"

    @tornado.web.authenticated
    def get(self):
        try:
            current_user = self.current_user['name']
            notice_str = ''
            self.render('admin_public_goods.html', name=current_user,
                        notice=notice_str)
        except Exception, e:
            log.d(e)

    @tornado.web.authenticated
    def post(self):
        try:
            name = self.get_argument('name')
            price = self.get_argument('price')
            picture = self.get_argument('picture')
            types = self.get_argument('types')
            explain = self.get_argument('explain', '')
            current_user = self.current_user['name']

            if not name or not price or not picture or not types:
                notice_str = '商品名称、商品价格、图片、种类必须填写!'
            else:
                userid = self.current_user['id']
                goodsid = sql.save_goods_info(userid, name, price, picture, types, explain)
                if goodid:
                    notice_str = '您成功添加一件商品,请继续添加!'
                else:
                    notice_str = '商品添加失败,请重新添加!'
            self.render('admin_public_goods.html', name=current_user,
                        notice=notice_str)
        except Exception, e:
            log.d(e)
            

class AdminCheckGoods(BaseHandler):
    "查看全部商品接口,`/admin/check/goods/`"

    @tornado.web.authenticated
    def get(self):
        try:
            goods = sql.query_goods_by_userid(self.current_user['id'])
            current_user = self.current_user['name']
            if goods:
                goods_name = goods['name']
                del goods['name']
                goods['goods_name'] = goods_name
                notice_str = ''
            else:
                notice_str = '您还没有发布商品!'
            self.render('admin_check_goods.html', name=current_user, goods=goods,
                        notice=notice_str)
        except Exception, e:
            log.d(e)

                    
                




