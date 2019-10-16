DOCS = $(wildcard */*.tex)

PICTURES = $(patsubst %.dia,%.pdf,$(wildcard */*/*.dia)) \
        $(patsubst %.svg,%.pdf,$(wildcard */*.svg)) \
        $(patsubst %.eps,%.pdf,$(wildcard */*.eps))
ARTEFACTS = *.pyg *.snm *.toc *.vrb *.aux *.nav *.out

all: $(PICTURES)
	$(PDFLATEX_ENV) pdflatex -shell-escape $(DOCS)

%.pdf: %.svg
	inkscape -D -A $@ $<

%.pdf: %.eps
	epstopdf --outfile=$@ $^

%.eps: %.dia
	dia -e $@ -t eps $^

clean:
	$(RM) -r *.dia~ *.log _minted* $(PICTURES) $(ARTEFACTS)
