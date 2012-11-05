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
	if git status > /dev/null 2>&1 ; then \
		git archive HEAD --format=tar.gz \
			--prefix="$(PACKAGE)-$$(git describe | cut -d/ -f2)/" > \
			"../$(PACKAGE)-$$(git describe | cut -d/ -f2).tar.gz" ; \
	else \
		rm -rf "$(DISTNAME)" ; \
		mkdir "$(DISTNAME)" && \
		ln $(DISTFILES) "$(DISTNAME)" && \
		tar c "$(DISTNAME)" | \
		gzip -cn > "../$(DISTNAME).tar.gz" ; \
		rm -rf "$(DISTNAME)" ; \
	fi

.PHONY: all install uninstall dist
