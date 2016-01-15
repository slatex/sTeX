PREFIX = ../..
DTX.sty.base = owl2onto
DTX.cls.base = 
TDSCOLL = stex
CTANPREFIX = /sty
PACKAGE = owl2onto
EXAMPLE = test
TARGET = test.tex
include $(PREFIX)/make/Makefile.vars
include $(PREFIX)/make/Makefile.in

test.owl2: test.tex.xml $(STEXDIR)/xsl/owl2post.xsl
	xsltproc -o $@ $(STEXDIR)/xsl/owl2post.xsl $<
