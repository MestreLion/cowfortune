#! /usr/bin/make -f

PACKAGE   := cowfortune
TARGET    := $(PACKAGE)
VERSION   := $(shell grep -m1 '^VERSION=' '$(TARGET)' | cut -d= -f2)
DISTNAME  := $(PACKAGE)-$(VERSION)
DISTFILES := cowfortune Makefile README
prefix    := /usr/local
bindir    := $(prefix)/games

all:

install:
	install -t '$(DESTDIR)$(bindir)' '$(TARGET)'

uninstall:
	rm -f '$(DESTDIR)$(bindir)/$(TARGET)'

dist:
	rm -rf "$(DISTNAME)"
	mkdir "$(DISTNAME)" && \
	ln $(DISTFILES) "$(DISTNAME)" && \
	tar c "$(DISTNAME)" | gzip -cn > "../$(DISTNAME).tar.gz"
	rm -rf "$(DISTNAME)"

.PHONY: all install uninstall dist
