browser = google-chrome
mecanic_cm = ext/Soda/soda --base-dir html -l --start-page /EcosystemMecanic.html --title-page __EcosystemMecanic__
biologic_cm = ext/Soda/soda --base-dir html -l --start-page /EcosystemBiologic.html --title-page __EcosystemBiologic__
science_store_cm = ext/Soda/soda --base-dir html



all: Soja_javascripts
	xdotool search "__EcosystemMecanic__" windowactivate key F5 || ${browser} html/EcosystemMecanic.html
	xdotool search "__EcosystemBiologic__" windowactivate key F5 || ${browser} html/EcosystemBiologic.html

# launch with server
mechanic: Soja_javascripts ext/Soda
	${mecanic_cm}

# launch with server
biotech: Soja_javascripts ext/Soda
	${biologic_cm}

# launch with server
sc: Soja_javascripts ext/Soda
	${science_store_cm}

# launch with server
soda_valgrind: Soja_javascripts ext/Soda
	valgrind ${soda_cm}

Soja:
	test -e Soja || ( test -e ../Soja && ln -s `pwd`/../Soja . ) || git clone git@github.com:hleclerc/Soja.git

ext/Soda:
	mkdir -p ext; cd ext; test -e Soda || ( test -e ../../Soda && ln -s `pwd`/../../Soda . ) || git clone git@github.com:hleclerc/Soda.git
	make -C ext/Soda

conv:
	metil_comp -I../LMT/include conversion/unv2js.cpp

.PHONY: Soja_javascripts
Soja_javascripts: Soja
	make    -C Soja    compilation
	mkdir   -p html/Soja
	install Soja/gen/* html/Soja
	python  bin/make.py
