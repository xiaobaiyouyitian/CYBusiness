#!/usr/bin/env python
#coding:utf-8

import traceback
from migrate import *
from models.user_data_mysql import UserBaseItem
from models.session_mysql import engine, base_metadata, TicketItem


base_metadata.bind = engine


tables = [
    UserBaseItem,
    TicketItem,
    ]


def create_tables(tables):
    for table in tables:
        try:
	    table.__table__.create()
	except:
	    print traceback.format_exc()


def drop_tables(tables):
    for table in tables:
        try:
	    table.__table__.drop()
	except:
	    print traceback.format_exc()


if __name__ == '__main__':
    create_tables(tables)
