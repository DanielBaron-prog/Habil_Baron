* Vergleiche mit Allbus-Daten 2012

clear

use "E:\DATEN\ALLBUS\Allbus 2012 - Stata\ZA4614_v1-1-1.dta"

* version 15

set more off

*****

* Schulabschluss:

tab v230 if v246!=0 & v246!=7 & v246<10 & (v220>=18 & v220<=35) & (v230<6)

* Berufliche Stellung

tab v246 if v246!=0 & v246!=7 & v246>10 & (v220>=18 & v220<=35)

*****

* Durchschnittliches monatliches Erwerbseinkommen (in Euro)

tab v344 if (v220>=18 & v220<=35)
sum v344 if (v220>=18 & v220<=35) & v344<60000 & v246!=0

*****

******************************

* Kap. 5.1.2
* TABELLE 4
* TABELLE 5

******************************

* Subjektive Schichteinschaetzung:

tab v17 if v17<6 & (v220>=18 & v220<=35) & (v230<6)
sum v17 if v17<6 & (v220>=18 & v220<=35) & (v230<6), detail

* z-Transformation fuer Vergleich mit AGIPEB 2012_13

egen z_v17 = std(v17) if v17<6 & (v220>=18 & v220<=35) & (v230<6)

sum z_v17 if v17<6 & (v220>=18 & v220<=35) & (v230<6), detail

*****

* Einschaetzung eigene wirtschaftliche Lage, aktuell, Befragte

* Invertieren:

gen v119_inv=.

replace v119_inv=1 if v119==5
replace v119_inv=2 if v119==4
replace v119_inv=3 if v119==3
replace v119_inv=4 if v119==2
replace v119_inv=5 if v119==1

tab v119_inv if (v220>=18 & v220<=35) & (v230<6)
sum v119_inv if (v220>=18 & v220<=35) & (v230<6), detail

* z-Transformation fuer Vergleich mit AGIPEB 2012_13

egen v119_inv_z = std(v119_inv)	if (v220>=18 & v220<=35) & (v230<6) // Standardisiert

sum v119_inv_z if (v220>=18 & v220<=35) & (v230<6), detail

*****

* Zufriedenheit mit Beruf

* Invertieren:

gen v690_inv=.

replace v690_inv=1 if v690==7
replace v690_inv=2 if v690==6
replace v690_inv=3 if v690==5
replace v690_inv=4 if v690==4
replace v690_inv=5 if v690==3
replace v690_inv=6 if v690==2
replace v690_inv=7 if v690==1

tab v690_inv if (v220>=18 & v220<=35) & (v230<6)
sum v690_inv if (v220>=18 & v220<=35) & (v230<6), detail

* z-Transformation fuer Vergleich mit AGIPEB 2012_13

egen v690_inv_z = std(v690_inv)	if (v220>=18 & v220<=35) & (v230<6) // Standardisiert

sum v690_inv_z if (v220>=18 & v220<=35) & (v230<6), detail

*****

* Politische Selbsteinschaetzung (Links-Rechts)

tab v101 if (v220>=18 & v220<=35) & (v230<6) & v101!=99
sum v101 if (v220>=18 & v220<=35) & (v230<6) & v101!=99, detail

* z-Transformation fuer Vergleich mit AGIPEB 2012_13

egen v101_z = std(v101) if (v220>=18 & v220<=35) & (v230<6) & v101!=99 // Standardisiert

sum v101_z if (v220>=18 & v220<=35) & (v230<6) & v101!=99, detail

*****

******************************

* Kap. 5.1.2
* TABELLE 6

******************************

* Konfessionszugehoerigkeit

tab v188 if (v220>=18 & v220<=35) & (v230<6) & (v188<7)

*****

******************************

* Kap. 5.1.2
* TABELLE 6

******************************

* Staatsangehoerigkeit

gen v6_rec=.

replace v6_rec=1 if v6==1 | v6==2
replace v6_rec=0 if v6==3 | v6==4

tab v6_rec if (v220>=18 & v220<=35) & (v230<6)