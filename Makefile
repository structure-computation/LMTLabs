browser = google-chrome

all: compilation
	xdotool search "__CorreliOnline__" windowactivate key F5 || ${browser} html/CorreliOnline.html

#.PHONY: Soja
Soja:
	git clone git@sc1.ens-cachan.fr:Soja-github Soja

.PHONY: compilation
compilation: Soja
	make -C Soja compilation
	python bin/make.py
