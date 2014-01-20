# -*- coding: ISO-8859-1 -*-
import os, sys, subprocess
from subprocess import *


#Pour deleter tout les programmes lancer par SC_GlobalManager
if os.path.isfile("SC_GlobalManager_PID"):
  a2=os.system("kill -9 `cat SC_GlobalManager_PID` >/dev/null")
  a2=os.system("rm SC_GlobalManager_PID")

#Ensuite et seulement ensuite, on va chercher les process que l'on avait créer sinon SC_GlobalManager les relance !

a3=os.popen("ps aux")
print 'Arrêt de issim'
while True:
  line = a3.readline()
  if 'issim' in line:
    if 'start' in line:
      cut = line.split()
      print '  issim pid = ' + cut[1]
      a1=os.popen('kill -9 '+cut[1])
      print '     issim                     [stop]'
  if not line:    
    break



a3=os.popen("ps aux")
service_name=['Soda server              ',
              'GlobalManager server     ']

print 'Arrêt des services'
while True:
  line = a3.readline()
  
  if 'ext/Soda/soda' in line:
    cut = line.split()
    print '  Soda/soda pid = ' + cut[1]
    a1=os.popen('kill -9 '+cut[1])
    print '     '+service_name[1]+'                     [stop]'
  if not line:    
    break



