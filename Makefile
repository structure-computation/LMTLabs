browser = google-chrome
soda_cm = ext/Soda/soda --base-dir html -l --start-page /CorreliOnline.html --title-page __CorreliOnline__
#  -C "xterm -e 'make -C../CorrelationClient; exit' &"

all: compilation
	xdotool search "__CorreliOnline__" windowactivate key F5 || ${browser} html/CorreliOnline.html

# launch with server
soda: compilation ext/Soda
	make -C ext/Soda
	${soda_cm}

# launch with server
soda_valgrind: compilation ext/Soda
	make -C ext/Soda
	valgrind ${soda_cm}

Soja:
	test -e Soja || ( test -e ../Soja && ln -s `pwd`/../Soja . ) || git clone git@github.com:hleclerc/Soja.git

ext/Soda:
	mkdir -p ext; cd ext; test -e Soda || ( test -e ../../Soda && ln -s `pwd`/../../Soda . ) || git clone git@github.com:hleclerc/Soda.git

conv:
	metil_comp -I../LMT/include conversion/unv2js.cpp

.PHONY: compilation
compilation: Soja
	make -C Soja compilation
	mkdir -p html/Soja
	install Soja/gen/* html/Soja
	python bin/make.py
