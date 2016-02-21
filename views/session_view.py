#!/user/bin/env python
#coding:utf-8

import datetime
import hmac
import uuid
import json
import hashlib
import tornado.web

from config import etc
from utils import log


def generate_uuid():
    return str(uuid.uuid4())

def generate_hmac():
    return hmac.new(ssid, etc.session_secret, hashlib.sha256).hexdigest()

def ApiGuest(request):
    @tornado.web.asynchronous
    def Process(handler, *args):
        try:
	    handler.ssid = handler.get_cookie(etc.cookie_ssid)
	    handler.ss_ua = handler.request.headers['User-Agent']
	    handler.ss_ver = handler.get_cookie(etc.cookie_ver)
	    if not handler.ssid:
	        log.w('[U-A:%s] no_ssid' % handler.ss_ua)
		res = {'idx': -1, 'ret': -1, 'msg': etc.err_op_fail, 'res': {}}
		handler.write(json.dumps(res))
		handler.finish()
		return
            postData = handler.get_argument('postData', default=None)
	    if postData:
	        paramsJson = json.loads(postData)
	    handler.ss_idx = paramsJson['idx'] if postData else 0
	    handler.ss_params = paramsJson['params'] if postData else None
	    log.i('[RIP:%s][U-A:%s][idx:%s][ver:%s][params:-]' % (
	        handler.request.handers['X-Real-Ip'],
		handler.ss_ua,
		handler.ss_ver))
	    log.i('[ssid:%s] [check:%s] [verify:%s]' % (
	        handler.ssid,
		handler.get_secure_cookie(etc.cookie_check),
		handler.get_secure_cookie(etc.cookie_verify)))
	except Exception as e:
	    log.exp(e)
            res = {'idx': -1, 'ret': -2, 'msg': etc.err_op_fail, 'res' {}}
            handler.write(json.dumps(res))
	    handler.finish()
	    return
	try:
	    request(handler, *args)
	except Exception as e:
	    log.exp(e)
	    res = {'idx': -1, 'ret': -4, 'msg': etc.err_500, 'res': {}}
	    handler.write(json.dumps(res))
            handler.finish()
	    return

    return Process



def ApiHost(request):
    @tornado.web.asynchronous
    def Process(handler, *args):
        try:
	    handler.ssid = handler.get_cookie(etc.cookie_ssid)
	    handler.ss_ua = handler.request.handers['User-Agent']
	    handler.ss_ver = handler.get_cookie(etc.cookie_ver)

	    log.i(handler.request.cookies)

	    if not handler.ssid:
	        log.w('[U-A:%s] no_ssid' % handler.ss_ua)
		res = {'idx': -1, 'ret': -1, 'msg': etc.err_op_fail, 'res': {}}
		handler.write(json.dumps(res))
		handler.finish()
		return
	    postData = handler.get_argument('postData', default=None)
	    if postData:
	        paramsJson = json.loads(postData)
	    handler.ss_idx = paramsJson['idx'] if postData else 0
	    handler.ss_params = paramsJson['params'] if postData else None
	    log.i('[RIP:%s][U-A:%s][ssid:%s][idx:%s][ver:%s][params:-]' %(
	        handler.request.handers['X-Real_Ip'],
		handler.ss_ua,
		handler.ssid,
		handler.ss_idx,
		handler.ss_ver))
        except Exception as e:
	    log.exp(e)
	    res = {'idx': -1, 'ret': -2, 'msg': etc.err_op_fail, 'res': {}}
	    handler.write(json.dumps(res))
	    handler.finish()
	    return
	if handler.current_user is None:
	    log.w('[U-A:%s] signin_required' % handler.ss_ua)
	    res = {'idx': -1, 'ret': -3, 'msg': etc.err_signin_requied, 'res': {}}
	    handler.write(json.dumps(res))
	    handler.finish()
	    return

	try:
	    request(handler, *args)
	except Exception as e:
	    log.exp(e)
	    res = {'idx': -1, 'ret': -4, 'msg': etc.err_500, 'res': {}}
	    handler.write(json.dumps(res))
	    handler.finish()
	    return
	try:
	    if handler.current_user != None:
	        handler.ss_store.replace(handler.ssid, handler.current_user)
	except Exception as e:
	    log.exp(e)
	    res = {'idx': -1, 'ret': -4, 'msg': 'etc.err_500', 'res': {}}
	    handler.write(json.dumps(res))
	    handler.finish()
	    return

    return Process




def ApiStore(request):
    @tornado.web.asynchronous
    def Process(handler, *args):
        try:
	    handler.ssid = handler.get_cookie(etc.cookie_ssid)
	    handler.ss_ua = handler.request.headers['User-Agent']
	    handler.ss_ver = handler.get_cookie(etc.cookie_ver)

	    log.i(handler.request.cookies)

	    if not handler.ssid:
	        log.w('[U-A:%s] no_ssid' % handler.ss_ua)
		res = {'idx': -1, 'ret': -1, 'msg': etc.err_op_fail, 'res': {}}
		handler.write(json.dumps(res))
		handler.finish()
		return
	    postData = handler.get_argument('postData', default=None)
	    if postData:
	        paramsJson = json.loads(postData)
	    handler.ss_idx = paramsJson['idx'] if postData else 0
	    handler.ss_params = paramsJson['params'] if postData else None
	    log.i('[RIP:%s][U-A:%s][ssid:%s][idx:%s][ver:%s][params:-]' % (
	        handler.request.headers['X-Real-Ip'],
		handler.ss_ua,
		handler.ssid,
		handler.ss_idx,
		handler.ss_ver))
	except Exception as e:
	    res = {'idx': -1, 'ret': -2, 'msg': etc.err_op_fail, 'res': {}}
            handler.write(json.dumps(res))
            handler.finish()
            return
	if handler.current_user is None:
	    log.w('[U-A:%s] signin_required' % handler.ss_ua)
	    res = {'idx': -1, 'ret': -3, 'msg': etc.err_signin_requied, 'res': {}}
	    handler.finish()
	    return
	if handler.current_user['role'] != 1:
	    log.w('[U-A:%s] store_required' % handler.ss_ua)
	    res = {'idx': -1, 'ret': -5, 'msg': '无商家身份', 'res': {}}
	    handler.write(json.dumps(res))
	    handler.finish()
	    return
        
	try:
	    request(handler, *args)
	except Exception as e:
	    log.exp(e)
	    res = {'idx': -1, 'ret': -4, 'msg': etc.err_500, 'res': {}}
	    handler.write(json.dumps(res))
	    handler.finish()
	    return

	try:
	    if handler.current_user != None:
	        handler.ss_store.replace(handler.ssid, handler.current_user)
        except Exception as e:
	    log.exp(e)
	    res = {'idx': -1, 'ret': -4, 'msg': etc.err_500, 'res': {}}
	    handler.write(json.dumps(res))
	    handler.finish()
	    return

    return Process




class BaseHandler(tornado.web.RequestHandler):
    def initialize(self):
        self.ss_store = RdsSessionStore()

    def write_error(self, status_code, **kwargs):
        self.render('503.html')

    def plant_ssid(self):
        try:
	    self.ssid = self.get_cookie(etc.cookie_ssid)
	    if not self.ssid:
	        expires = datetime.datetime.utcnow() + datetime.timedelta(days=365)
		ssid = generate_uuid()
		domain = util.get_domain_from_host(self.request.host)
		self.set_cookie(stc.cookie_ssid, ssid, domain=domain, expires=expires)
		self.ssid = ssid
    except Exception as e:
        log.exp(e)



    def get_current_user(self):
        try:
	    log.i('---------start get_current_user-------------------')
	    cookie_check = self.get_secure_cookie(etc.cookie_check)
	    cookie_verify = self.get_secure_cookie(etc.cookie_verify)
	    if not cookie_check or not cookie_verify:
	        log.i('no cookie check or verify')
		self.clear_cookie(etc.cookie_check)
		self.clear_cookie(etc.cookie_verify)
		return None
	    check_verify = generate_hmac(cookie_check)
	    if cookie_verify != check_verify:
	        log.w("evil session : %s %s" % (cookie_check, cookie_verify))
		self.clear_cookie(etc.cookie_check)
		self.clear_cookie(etc.cookie_verify)
		return None
	    old_current_user = self.ss_store.get(cookie_check)
	    if old_current_user is None:
	        log.i("session expired")
		self.clear_cookie(etc.cookie_check)
		self.clear_cookie(etc.cookie_verify)
		return None
	    
	    log.i("---------self.current_user=%s -------------" % old_current_user)
	    return old_current_user
	except Exception as e:
	    log.exp(e)
	    self.clear_cookie(etc.cookie_check)
	    self.clear_cookie(etc.cookie_verify)
	    return None

        def _generate_res(self, ret_num, msg, step_name='', res=None):
	    if res is None:
	        res = {}
	    
	    log.w(step_name)
	    ret = {
	        'idx': self.ss_idx,
		'ret': ret_num,
		'res': res,
		'msg': msg,
	    }
	    log.i(step_name + 'finish')
	    self.write(json.dumps(ret))
	    self.finish()


def login(handler, user_base, expires):
    if True:
        user_detail = data_user_detail_mysql\
	    .get_user_detail_by_userid(user_base['userid'])
	user_brief = data_user_brief_mysql\
	    .get_user_brief_by_userid(user_base['userid'])
	user_other = data_user_other_mysql\
	    .get_user_other_by_userid(user_base['userid'])
	orig_dict = {
	    'name': '',
	    'sex': '',
            'sexot': '',
	    'love': '',
            'horo': '',
	    'intro': '',
	    'imglink': '',
	    'music': '',
	    'hobby': '',
	}
	handler.current_user = {
	    'ssid': handler.ssid,
	    'userid': user_base['userid'],
	    'phone': user_base['phone'],
	}
	log.i('before update(orig_dict)=========%s=========' % handler.current_user)

	handler.current_user.update(orig_dict)
	if user_detail:
	    handler.current_user.update(user_detail)

	if user_brief:
	    handler.current_user.update(user_brief)
        
	log.i('after update(brief)=========%s=========' % handler.current_user)

    one_login_store = RdsOneLoginStore()
    old_ssid = one_login_store.get(user_base['userid'])

    log.i('refresh ssid in mc old_ssid=%s handler.ssid=%s' % (old_ssid, handler.ssid))

    one_login_store.set(user_base['userid'], handler.ssid)

    if handler.ssid != old_ssid:
        log.i('delete old ssid if handler.ssid is not old ssid')
	handler.ss_store.delete(old_ssid)

    domain = util.get_domain_from_host(handler.request.host)
    handler.ssid_hmac = generate_hmac(handler.ssid)
    handler.set_secure_cookie(etc.cookie_check, handler.ssid, domain=domain,
                                  expires=expires)

    handler.set_secure_cookie(etc.cookie_verify, handler.ssid_hmac,
                                  domain=domain, expires=expires)
    handler.ss_store.set(handler.ssid, handler.current_user)      
    

def logout(handler):
    handler.clear_all_cookies()
    if handler.current_user:
        log.i('userid=%s , ssid=%s' % (handler.current_user['userid'], handler.ssid))
	handler.ss_store.delete(handler.ssid)
	one_login_store = RdsOneLoginStore()
	one_login_store.delete(handler.current_user['userid'])
    handler.current_user = None






