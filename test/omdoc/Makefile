MAKEDIRS = metakeys pathsuris tikzinput presentation sref cmath workaddress omdoc\
	   modules sproof structview omtext\
           dcm statements smultiling problem stex hwexam mathhub/source mikoslides smglom

all clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

test: all
