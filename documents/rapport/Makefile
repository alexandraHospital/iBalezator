TEX	= pdflatex
LFLAGS	= -halt-on-error
RAP     = rapport

all: $(RAP).pdf

$(RAP).pdf: $(RAP).tex
	$(TEX) $(LFLAGS) $(RAP).tex

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

