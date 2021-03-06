DOCS = $(patsubst %.tex,%.pdf,$(wildcard */*.tex))

PICTURES = $(patsubst %.dia,%.pdf,$(wildcard */*/*.dia)) \
        $(patsubst %.svg,%.pdf,$(wildcard */*.svg)) \
        $(patsubst %.eps,%.pdf,$(wildcard */*.eps))
ARTEFACTS = *.pyg *.snm *.toc *.vrb *.aux *.nav *.out

all: $(PICTURES) $(DOCS)

%.pdf: %.svg
	inkscape -D -A $@ $<

%.pdf: %.eps
	epstopdf --outfile=$@ $^

%.eps: %.dia
	dia -e $@ -t eps $^

# Compile twice to get the correct page numbering
%.pdf: %.tex
	$(PDFLATEX_ENV) pdflatex -shell-escape $^
	$(PDFLATEX_ENV) pdflatex -shell-escape $^

clean:
	$(RM) -r *.dia~ *.log _minted* $(PICTURES) $(ARTEFACTS)
