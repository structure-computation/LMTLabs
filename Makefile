
GIT_SUBMODULES = ext/Soja ext/Soda 

browser					 = google-chrome

soda_serve	= ext/Soda/soda --base-dir html




all: Soja_javascripts ext/Soda
	# xdotool search "__EcosystemMecanic__"	 windowactivate key F5 || ${browser} html/EcosystemMechanic.html
	# xdotool search "__EcosystemBiologic__" windowactivate key F5 || ${browser} html/EcosystemBiotech.html

# launch with server
mechanic: Soja_javascripts ext/Soda
	${soda_serve} -l --start-page /EcosystemMechanic.html --title-page __EcosystemMechanic__

# launch with server
biotech: Soja_javascripts ext/Soda
	${soda_serve} -l --start-page /EcosystemBiotech.html	--title-page __EcosystemBiotech__

# launch with server
sc: Soja_javascripts ext/Soda
	${soda_serve}

# TODO: Suppress if useless (soda_cm not defined)
# launch with server
soda_valgrind: Soja_javascripts ext/Soda
	valgrind ${soda_cm}

# TODO: explain
conv:
	metil_comp -I../LMT/include conversion/unv2js.cpp

	
Soja_javascripts: ext/Soja
	mkdir		-p html/Soja
	install ext/Soja/gen/*	html/Soja
	python	bin/make.py

ext/Soja: init_submodules
	make		-C ext/Soja			compilation
	
ext/Soda: init_submodules
	make		-C ext/Soda
	
	
# Soja and Soda are now git submodule.
init_submodules: 
	(test -e ext/Soda && test -e ext/Soja) || (git submodule init; git submodule update)
	
clean_submodules: 
	$(foreach submodule, $(GIT_SUBMODULES), make -C	 $(submodule) clean;)

clean:
	
clean_all: clean clean_submodules

.PHONY: Soja_javascripts init_submodules

