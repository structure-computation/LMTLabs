browser = google-chrome

all: compilation
	xdotool search "__CorreliOnline__" windowactivate key F5 || ${browser} html/CorreliOnline.html

# launch with server
srv: compilation
	make -C Soja server
	Soja/server/soja_server --port=8888 --xdotoolcmd='search __CorreliOnline__ windowactivate key F5' --browsercmd=${browser} --start-page=html/CorreliOnline.html

conv:
	metil_comp -I../LMT/include conversion/unv2js.cpp

#.PHONY: Soja
Soja:
	git clone git@github.com:hleclerc/Soja.git Soja

.PHONY: compilation
compilation: Soja
	make -C Soja compilation
	python bin/make.py
