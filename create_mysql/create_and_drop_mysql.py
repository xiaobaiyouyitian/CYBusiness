#!/usr/bin/env python
#coding:utf-8

import sys
import traceback
from migrate import *

from models.session_mysql import engine, base_metadata, TicketItem

base_metadata.bind = engine

tables = [
    TicketItem,
    UserBaseItem,
    UserBriefItem,
    UserDetailItem,
    UserOtherItem,
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
