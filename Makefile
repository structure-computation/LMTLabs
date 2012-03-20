browser = google-chrome

all: compilation
	xdotool search "__CorreliOnline__" windowactivate key F5 || ${browser} html/CorreliOnline.html

# launch with server
srv: compilation Soda
	make -C Soda
	Soda/soda -cp Soda/Celo

Soda:
	git clone git@sc1.ens-cachan.fr:Sodat Soda

Soja:
	git clone git@github.com:hleclerc/Soja.git Soja

conv:
	metil_comp -I../LMT/include conversion/unv2js.cpp

html/plugins: plugins
	ln -sf `pwd`/plugins html/

html/gen: gen
	ln -sf `pwd`/gen html/

html/gen/Soja: Soja html/gen
	ln -sf `pwd`/Soja html/gen/

.PHONY: compilation
compilation: html/gen/Soja html/plugins
	make -C Soja compilation
	python bin/make.py
