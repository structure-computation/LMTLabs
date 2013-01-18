browser          = google-chrome
mechanic_cm      = ext/Soda/soda --base-dir html -l --start-page /EcosystemMechanic.html --title-page __EcosystemMechanic__
biologic_cm      = ext/Soda/soda --base-dir html -l --start-page /EcosystemBiotech.html  --title-page __EcosystemBiotech__
science_store_cm = ext/Soda/soda --base-dir html



all: Soja_javascripts
  # xdotool search "__EcosystemMecanic__"  windowactivate key F5 || ${browser} html/EcosystemMechanic.html
  # xdotool search "__EcosystemBiologic__" windowactivate key F5 || ${browser} html/EcosystemBiotech.html

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



conv:
	metil_comp -I../LMT/include conversion/unv2js.cpp

.PHONY: Soja_javascripts
Soja_javascripts: 
	make    -C ext/Soja     compilation
	mkdir   -p html/Soja
	install ext/Soja/gen/*  html/Soja
	python  bin/make.py


# Soja and Soda are now git submodule and thus are not anymore cloned in the makefile.
Soja:
  # test  -e Soja || ( test -e ../Soja && ln -s `pwd`/../Soja . ) || git clone git@github.com:hleclerc/Soja.git

ext/Soda:
  # mkdir -p ext; cd ext; test -e Soda || ( test -e ../../Soda && ln -s `pwd`/../../Soda . ) || git clone git@github.com:hleclerc/Soda.git
	make  -C ext/Soda