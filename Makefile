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
	install -D '$(TARGET)' '$(DESTDIR)$(bindir)/$(TARGET)'

uninstall:
	rm -f '$(DESTDIR)$(bindir)/$(TARGET)'

dist:
	@rm -rf "$(DISTNAME)"
	mkdir "$(DISTNAME)" && \
	ln $(DISTFILES) "$(DISTNAME)" && \
	tar c "$(DISTNAME)" | gzip -cn > "../$(DISTNAME).tar.gz"
	rm -rf "$(DISTNAME)"

dist-git: dist
	@if test -n '$(ENABLE_GIT)'; then \
		ln -s "$(DISTNAME).tar.gz" "../$(PACKAGE)_$(VERSION).orig.tar.gz" && \
		git tag -a -m "release $(VERSION)" "upstream/$(VERSION)" && \
		pristine-tar commit "../$(DISTNAME).tar.gz" ; \
	else \
		echo "dist-git target is disabled by default to avoid accidental runs."; \
		echo "This target modifies the git reposity, creating new tags and commits."; \
		echo "To execute it, use ENABLE_GIT make dist-git"; \
	fi

.PHONY: all install uninstall dist dist-git
