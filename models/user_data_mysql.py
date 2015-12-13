#!/usr/bin/env python
#coding:utf-8

from session_mysql import BaseTable, SessionCM
from sqlalchemy import Column, Unicode, UnicodeText, TIMESTAMP, func, Integer
from sqlalchemy.dialects.mysql import BIGINT
from config import log

'''
id: 用户的userid，
username: 用户的name  
password: 用户的password
phone： 用户的手机号
'''

class UserBaseItem(BaseTable):
    __tablename__ = 'user_base_item'

    username = Column(Unicode(255), nullable=False)
    password = Column(Unicode(65), nullable=False)
    phone = Column(Unicode(65), index=True, unique=True, nullable=False)
    ctime = Column(TIMESTAMP, server_default=func.now())

    def to_dict(self):
        res = {}
	res['userid'] = self.id
	res['username'] = self.username
	res['password'] = self.password
	res['phone'] = self.phone
	res['ctime'] = self.ctime
	return res

    def __repr__(self):
        return '%s' % (self.phone)


def add_data_to_user_base_item(p_item):
    new_item = UserBaseItem(**p_item)
    try:
        with SessionCM() as db_session:
	    db_session.add(new_item)
	    db_session.commit()
	    return new_item.to_dict()
    except Exception as e:
        log.exp(e)
	return False



def get_user_base_item_by_userid(p_userid):
    try:
        with SessionCM() as db_session:
	    item = db_session.query(UserBaseItem).filter_by(id=p_userid)
	    if not item:
	        return None
	    return item.to_dict()
    except Exception as e:
        log.exp(e)
	return None

    
def get_user_base_item_by_phone(p_phone):
    try:
        with SessionCM() as db_session:
	    item = db_session.query(UserBaseItem).filter_by(phone=p_phone)
	    if not item:
	        return None
	    return item.to_dict()
    except Exception as e:
        log.exp(e)
	return None


if __name__ == '__main__':
    item = {}
    item['username'] = 'xiaoli'
    item['password'] = '123456'
    item['phone'] = '23453235543'
    add_data_to_user_base_item(item)





