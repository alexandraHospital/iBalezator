TEX	= pdflatex
LFLAGS	= -halt-on-error
PRE	= presentation_16_04.tex presentation_26-03.tex
PDF     = $(PRE:.tex=.pdf)

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
