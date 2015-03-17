# Copyright 2012 lynix <lynix47@gmail.com>
# Copyright 2013 JinTu <JinTu@praecogito.com>, lynix <lynix47@gmail.com>
# Copyright 2014 barracks510 <barracks510@gmail.com>
# Copyright 2015 barracks510 <barracks510@gmail.com>
#
# This file is part of Aquaeronix.
#
# Aquaeronix is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Aquaeronix is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Aquaeronix. If not, see <http://www.gnu.org/licenses/>.

CC = gcc
CFLAGS = -Wall -ansi -std=gnu99 -pedantic -I /usr/include -O2

$(shell   mkdir -p bin/ obj/ lib/)

JRPCC_PREFIX = /usr/

# Uncomment this if you want to debug
#CFLAGS += -D'DEBUG=TRUE'

ifdef DEBUG  
	CFLAGS += -g
endif

LIB_OBJS=obj/libaquaero5.o


.PHONY: all default clean 

default : bin/rpcd

all : bin/rpcd lib/libaquaero5.a lib/libaquaero5.so

bin/rpcd: obj/rpcd.o obj/libaquaero5.o
	$(CC) $(CFLAGS) -L $(JRPCC_PREFIX)/lib -ljsonrpcc -o $@ $^
  
obj/libaquaero5.o: libaquaero5.c libaquaero5.h \
		aquaero5-user-strings.h aquaero5-offsets.h
	$(CC) $(CFLAGS) -fPIC -o $@ -c $<

obj/rpcd.o: rpcd.c $(JRPCC_PREFIX)/include/jsonrpc-c.h
	$(CC) $(CFLAGS) -I $(JRPCC_PREFIX)/include -I /usr/include/libev/ -o $@ -c $<


# Static library file
lib/libaquaero5.a: $(LIB_OBJS)
	ar cr $@ $^

# Dynamic library file
lib/libaquaero5.so: $(LIB_OBJS)
	$(CC) -shared -o $@ $^

clean :
	rm -f bin/rpcd obj/*.o lib/*.a lib/*.so

install :
	install -C bin/rpcd /usr/rpcd
	install -C obj/rpcd.o /obj/rpcd.o
	install -C obj/libaquaero5.o /obj/libaquero5.o
	install -C lib/libaquaero5.so /lib/libaquaero5.so
	install -C lib/libaquaero5.a /lib/libaquaero5.a

