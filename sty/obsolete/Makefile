# recurse into the directories. 
DISTDIRS = 
MAKEDIRS = $(DISTDIRS) cmathml cnx physml #physml owl2onto

all package doc clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done
ltds lctan filedate checksum enablechecksum disablechecksum: 
	@for d in $(DISTDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done

TDSCOLL = stex
TDS.doc = README
TDS.src = 
