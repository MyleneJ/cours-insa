DOC = cours_insa.tex

PICTURES = $(patsubst %.dia,%.pdf,$(wildcard */*.dia)) \
        $(patsubst %.svg,%.pdf,$(wildcard */*.svg)) \
        $(patsubst %.eps,%.pdf,$(wildcard */*.eps))

all: $(PICTURES)
	$(PDFLATEX_ENV) pdflatex -shell-escape $(DOC)

%.pdf: %.svg
	inkscape -D -A $@ $<

%.pdf: %.eps
	epstopdf --outfile=$@ $^

%.eps: %.dia
	dia -e $@ -t eps $^

clean:
	$(RM) -r common/*.pdf *.pdf *.pyg *.snm *.toc *.vrb *.aux *.nav *.out *.dia~ *.log _minted* $(PICTURES)
