TEX	= pdflatex
LFLAGS	= -halt-on-error
CRR	= cr_16-04.tex cr_02-04.tex cr_03-03.tex cr_10-02.tex cr_18-02.tex cr_18-03.tex cr_24-02.tex cr_26-03.tex cr_30-01.tex 
PDF     = $(CRR:.tex=.pdf) 

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

clean: proper
	rm -f *.pdf
