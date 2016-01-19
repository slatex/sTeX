PREFIX 		= ../
DIRS		= 
TARGET.base	= once #m0039 s0039
TARGET.pdf 	= $(TARGET.base:%=%.pdf)

all::		$(TARGET.pdf) $(TARGET.cnx)

$(TARGET.pdf): %.pdf: %.tex 
		pdflatex $(firstword $<) 

