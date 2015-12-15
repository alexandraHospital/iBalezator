TEX	= pdflatex
LFLAGS	= -halt-on-error
STR	= STR.tex
PDF     = $(STR:.tex=.pdf) 

all: $(PDF)

%.pdf: %.tex 
	$(TEX) $(LFLAGS) $<

.PHONY: all proper clean

proper:
	rm -f *.aux
	rm -f *.log
	rm -f *.nav
	rm -f *.out
	rm -f *.snm
	rm -f *.toc

clean: proper
	rm -f *.pdf
