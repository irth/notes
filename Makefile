MD_FILES := $(wildcard *.md)
HTML_FILES := $(patsubst %.md,out/%.html,$(MD_FILES))

.PHONY: all
all: $(HTML_FILES) out/main.css

out/%.html: %.md
	mkdir -p out
	pandoc $< --css=main.css --template=template/template -o $@

out/main.css: 
	cp template/main.css out/

clean:
	rm -rf out

.PHONY: %.fmt
%.fmt: %.md
	 pandoc $< -s -o $<


FAKE_FMT_FILES := $(patsubst %.md,%.fmt,$(MD_FILES))

.PHONY: fmt
fmt: $(FAKE_FMT_FILES)


.PHONY: publish
publish:
	rsync -r out/ wkwolek@denali.kcir.pwr.edu.pl:public_html/other_notes
