TEST = test.tex
# recurse into the directories. 
MAKEDIRS = source doc

all package doc: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done
	ls
	pdflatex test.en.tex
