RNCDIR 		= ../rnc
BUT.rnc 	= 
OMDOC.rnc 	= $(shell ls $(RNCDIR)/omdoc/*rnc)
LATEXML.rnc 	= $(shell ls $(RNCDIR)/LaTeXML/*rnc)
SRC.rnc 	= $(RNCDIR)/omdoc+ltxml.rnc $(RNCDIR)/ltxml+omdoc.rnc
SRC.rng 	= $(SRC.rnc:%.rnc=%.rng)

all:		$(SRC.rng) #$(TARGET.xsd) 

clean:		
		rm -f *~ 
distclean:	clean

# for the moment we do not install
# install:	$(SRC.rnc) $(SRC.rng) 
# 	cp $(SRC.rnc) $(SRC.rng) $(HOME)/vc/svn/omdoc.org/www/rnc

test:

$(SRC.rng): %.rng: %.rnc $(OMDOC.rnc) $(LATEXML.rnc)
#		rnc2rng $< $@
		trang -I rnc -O rng $< $@
		mv ../rnc/*.rng .
