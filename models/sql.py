#!/usr/bin/env python

import torndb


db = torndb.Connection("localhost", "cybusiness", "root", "123")


def get_user_base_by_name_password(name, password):
    user = db.get("select * from user_base where name = '%s' and password = '%s' " \
                  % (name, password))
    return user


def get_user_base_by_cookie(cookie):
    user = db.get("select * from user_base where session = '%s'" \
                  % cookie)
    return user


def save_session_by_userid_and_cookie(userid, cookie):
    db.execute("update user_base set session = '%s' where id = %d" \
               % (cookie, userid))
    

def query_goods_by_userid(userid):
    sql = "select * from user_goods where id = %s"
    return db.query(sql, userid)
    

