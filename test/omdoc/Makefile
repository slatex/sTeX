MAKEDIRS = metakeys pathsuris presentation cmath modules structview\
           statements problem hwexam mathhub/source smglom
# the following still need content:
EDIRS = tikzinput sref workaddress omdoc sproof omtext dcm smultiling stex mikoslides
all clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

test: all
