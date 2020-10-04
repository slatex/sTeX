MAKEDIRS = 02-metakeys 01-pathsuris 03-presentation 05-cmath 07-modules 12-structview\
           13-statements 16-problem 17-tikzinput 20-hwexam\
	   otherarchive/source 21-mathhub/source 22-smglom/source
# the following still need content:
EDIRS = 04-sref 06-workaddress 08-omdoc 09-sproof 10-dcm 11-omtext 14-smultiling 15-stex 19-mikoslides
all clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

test: all
