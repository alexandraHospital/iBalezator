TEX	= pdflatex
LFLAGS	= -halt-on-error
CDC	= cahier_des_charges

all: $(CDC).pdf

$(CDC).pdf: $(CDC).tex
	$(TEX) $(LFLAGS) $(CDC).tex

clean:
	rm -f *.aux
	rm -f *.log
	rm -f *.nav
	rm -f *.out
	rm -f *.pdf
	rm -f *.snm
	rm -f *.toc
