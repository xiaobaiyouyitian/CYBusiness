#!/usr/bin/env python
#coding:utf-8

import sys
import random
import socket
import time

from sqlalchemy import create_engine, MetaData, Column, Integer, String
from sqlalchemy.dialects.mysql import BIGINT, INTEGER
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

from config import etc
from config.etc import machine_no_dict
from utils import log

machine_name = socket.gethostname()
machine_no = machine_no_dict[machine_name]
def order_generator():
    t = time.time()
    m = machine_no
    i = random.randint(0, 1024)
    l = (int(t * 1000) << 22) | (m << 22) | i
    return l


engine = create_engine(
    'mysql://' + etc.mysql_user + ':' + etc.mysql_passwd + '@' + etc.mysql_host + ':' + str(
        etc.mysql_port) + '/' + etc.mysql_db_name,
    encoding='utf-8', pool_size=100, pool_recycle=3600,
    echo=False)

Session = sessionmaker()
Session.configure(bind=engine)

base_metadata = MetaData()


# SessionCM

class SessionCM(object):
    def __enter__(self):
        self.session = Session()
	return self.session
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        try:
	    self.session.rollback()
	except:
	    log.e('session rollback error')
	self.session.close()



# BaseTable

def id_generator():
    with SessionCM() as db_session:
        db_session.execute("replace into ticket32 (stub) values ('a');")
	ticket = db_session.execute("select LAST_INSERT_ID();")
	if not ticket:
	    raise
	return ticket.fetchone()[0]


class _Base(object):
    id = Column('id', BIGINT(unsigned=True),primary_key=True, default=id_generator)

BaseTable = declarative_base(metadata=base_metadata, cls=_Base)



# ticket32

TicketTable = declarative_base(metadata=base_metadata)
class TicketItem(TicketTable):
    __tablename__ = 'ticket32'

    id = Column(INTEGER(unsigned=True), index=True, nullable=False, primary_key=True)
    stub = Column(String(length=1), nullable=False, unique=True, default='')




if __name__ == '__main__':
    pass


