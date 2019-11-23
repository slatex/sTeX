AUX = localpath.tex
include ../../make/Makefile.in

# We generate a file localpath.tex which is needed for the tests.
localpaths.tex:
	@echo "\defpath{MathHub}{`pwd`}\mhcurrentrepos{../mathhub}" >localpath.tex

pre: localpaths.tex

