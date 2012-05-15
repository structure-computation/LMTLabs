browser = google-chrome

all: compilation
	xdotool search "__CorreliOnline__" windowactivate key F5 || ${browser} html/CorreliOnline.html

# launch with server
srv: compilation ext/Soda
	make -C ext/Soda
	ext/Soda/soda --start-page /CorreliOnline.html

Soda:
	git clone git@sc1.ens-cachan.fr:Sodat Soda

Soja:
	git clone git@github.com:hleclerc/Soja.git Soja

conv:
	metil_comp -I../LMT/include conversion/unv2js.cpp

.PHONY: compilation
compilation:
	make -C Soja compilation
	mkdir -p html/Soja
	install Soja/gen/* html/Soja
	python bin/make.py
