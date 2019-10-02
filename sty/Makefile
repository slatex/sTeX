# recurse into the directories. 
DISTDIRS = stex cmath dcm hwexam metakeys mikoslides modules omdoc omtext\
	   presentation problem sproof sref statements workaddress\
           smultiling tikzinput smglom mathhub structview
MAKEDIRS = $(DISTDIRS)

all package doc clean distclean biber stycls: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done
ltds lctan filedate checksum enablechecksum disablechecksum: 
	@for d in $(DISTDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done

TDSCOLL = stex# lowercase by CTAN rules
TDS.tex = stex.tex stex.sty stex-logo.sty ctansvn.sty
TDS.doc = README stex.pdf
TDS.src = 

include make/Makefile.ctan

# auxiliary for debugging
echo:
	echo $(DISTDIRS)
