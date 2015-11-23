# recurse into the directories. 
DISTDIRS = cmath cmathml cnx dcm hwexam metakeys mikoslides modules omdoc omtext\
	   presentation problem rdfmeta reqdoc sproof sref statements workaddress\
           smultiling tikzinput smglom mathhub structview
MAKEDIRS = $(DISTDIRS) #physml owl2onto

all ltxml package doc ltds lctan filedate checksum enablechecksum disablechecksum clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done

TDSCOLL = stex
TDS.tex = stex.tex stex.sty stex.sty.ltxml stex-logo.sty stex-logo.sty.ltxml ctansvn.sty
TDS.doc = README stex.pdf
TDS.src = 

include make/Makefile.ctan

