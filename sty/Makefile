# recurse into the directories. 
DISTDIRS = cmath cmathml cnx dcm hwexam metakeys mikoslides modules omdoc omtext\
	   presentation problem rdfmeta reqdoc sproof sref statements workaddress\
           smultiling tikzinput smglom mathhub structview
MAKEDIRS = $(DISTDIRS) #physml owl2onto

all ltxml package doc filedate checksum enablechecksum disablechecksum clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

TDSCOLL = stex
TDS.tex = stex.tex stex.sty stex.sty.ltxml stex-logo.sty stex-logo.sty.ltxml ctansvn.sty
TDS.doc = README stex.pdf
TDS.src = 

include make/Makefile.ctan

# generate the documentation
stex.pdf: stex.tex $(SOURCS)
	pdflatex $(firstword $<)
	@if (grep Citation $(patsubst %.tex, %.log, $(firstword $<)) > /dev/null);\
	    then bibtex $(patsubst %.tex, %, $(firstword $<));fi
	@if (grep "Writing glossary file" $(patsubst %.tex, %.log, $(firstword $<)) > /dev/null);\
	   then makeindex -s gglo.ist\
		-o $(patsubst %.tex, %.gls, $(firstword $<))\
		$(patsubst %.tex, %.glo, $(firstword $<)); fi
	@if (grep "Writing index file" $(patsubst %.tex, %.log, $(firstword $<)) > /dev/null);\
	   then makeindex -s stex.ist\
		-o $(patsubst %.tex, %.ind, $(firstword $<))\
		$(patsubst %.tex, %.idx, $(firstword $<)); fi
	@if (grep Rerun $(patsubst %.tex, %.log, $(firstword $<)) > /dev/null);\
	   then pdflatex $(firstword $<); fi
	@if (grep Rerun $(patsubst %.tex, %.log, $(firstword $<)) > /dev/null);\
	    then pdflatex $(firstword $<); fi

# auxiliary for debugging
echo:
	echo $(DISTDIRS)
