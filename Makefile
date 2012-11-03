#! /usr/bin/make -f

TARGET   = cowfortune
prefix   = /usr/local
bindir   = $(prefix)/games

all:

install:
	install -t '$(DESTDIR)$(bindir)' '$(TARGET)'

uninstall:
	rm -f '$(DESTDIR)$(bindir)/$(TARGET)'
