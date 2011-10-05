browser = google-chrome

all: compilation
	xdotool search __CorreliOnline__ windowactivate key F5 || ${browser} html/CorreliOnline.html

Soja:
	git clone git@sc1.ens-cachan.fr:Soja-github Soja

compilation: Soja
	make -C Soja compilation
	python bin/make.py
