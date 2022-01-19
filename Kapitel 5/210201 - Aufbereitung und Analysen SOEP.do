* Vergleiche mit SOEP v35 (1994-2018)

clear

use "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Daten\pl soep 35 - work.dta"

* version 15

set more off

**********************************************************************

sort pid syear

* Faelle auswahlen / Analysesample erstellen

* Ziel: Nur jene Personen in Sample, die...
* (a) bis 2012 befragt wurden
* (b) 18 bis 35 Jahre alt waren (2013)
* (c) abhaengig beschaeftigt waren
* (d) in einer festen Partnerschaft (verheiratet oder unverheiratet)

* zu (a)
drop if syear>2013

sort pid syear

* zu (b)
drop if ple0010_h>1995 | ple0010_h<1978

sort pid syear

* Exkurs: Altersvariable generieren:

gen age=2013-ple0010_h

sort pid syear

* zu (c)
by pid: drop if syear==2013 & plb0022_h>2

sort pid syear

* zu (d)

gen pld0132_h_rek=.

replace pld0132_h_rek=1 if pld0132_h==1
replace pld0132_h_rek=0 if pld0132_h==2

by pid: drop if syear==2013 & pld0132_h_rek==0

sort pid syear

bysort pid: drop if pld0132_h_rek==1 & pld0132_h_rek[_n-1]==0 	// Fruehere Partnerschaften loeschen

replace pld0132_h_rek=1 if pld0137==1							// Korrektur: Kohabitierende Personen als "in fester Partnerschaft lebend" deklarieren 
replace pld0132_h_rek=1 if pld0131==1 | pld0131==2				// Korrektur: Verheiratete Personen als "in fester Partnerschaft lebend" deklarieren 
replace pld0132_h_rek=1 if pld0152==1							// Korrektur: Personen mit Kindern als "in fester Partnerschaft lebend" deklarieren 

list pid syear pld0132_h_rek in 1/40, sepby(pid)

**********************************************************************

sort pid syear

* Merge mit pgen, um Bildungsstand (pgpsbil), Einkommen und Kein Bildungsabschluss zu inkludieren

merge m:1 pid syear using "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Daten\pgen.dta", keepusing(pgpsbil pglabnet pgpbbil03)

drop if _merge==2
drop _merge

* Personen ausschließen, die sich 2013 noch in Ausbildung befinden

sort pid syear

by pid: drop if syear==2013 & (pgpbbil03==2 | pgpbbil03==3)

**********************************************************************

sort pid syear

* Mergen pequiv, um Partnerschaftsstatus und Beziehung zu Head of Household zu inkludieren

merge m:1 pid syear using "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Daten\pequiv - soep 35.dta", keepusing(d11104 d11105)

drop if _merge==2
drop _merge

***********************************

* Personen mit unvollstaendigen bzw. zu kurzen Biographien droppen

sort pid syear

gen time_max=.

by pid: replace time_max=_N

* Personen droppen, die nicht im Jahr 2013 befragt wurden

gsort pid-syear		// Faelle absteigend nach Erhebungsjahr fuer jede Person soriteren

by pid: drop if syear[1]!=2013	// Die je erste Reihe pro Person(=Erhebungsjahr) als Kriterium fuer Loeschen nehmen

list pid syear time_max in 1/50, sepby(pid)

* Personen droppen, die nur eine Befragungswelle haben:

sort pid syear

by pid: drop if time_max==1

list pid syear time_max in 1/250, sepby(pid)

* Personen droppen, die zur Befragungswelle ein Missing haben beim Partnerschaftsstatus

by pid: drop if pld0132_h_rek==. & syear==2013

* In urspruenglicher Form sortieren:

sort pid syear

**********************************************************************

* Aufbereiten: Partnerschaftsereignisse

sort pid syear

* Partnerschaften ausschließen, die vor jener lagen, die zum Interviewzeitpunkt bestand

* Tag-Variable erstellen fuer Partnerschaften, die vor der Partnerschaft bestanden, die zum Interviewzeitpunkt bestanden

gen pld0132_h_tag=.

by pid: replace pld0132_h_tag=1 if pld0132_h_rek==1 & pld0132_h_rek[_n+1]==0

by pid: egen tag_count=sum(pld0132_h_tag) if pld0132_h_tag==1

sort pid syear

gsort pid-syear

by pid: replace tag_count=tag_count[_n-1] if tag_count[_n-1]==1

by pid: replace tag_count=tag_count[_n-1] if tag_count[_n-1]==2

by pid: replace tag_count=tag_count[_n-1] if tag_count[_n-1]==3

sort pid syear

drop if tag_count==1 | tag_count==2 | tag_count==3

sort pid syear

list pid syear pld0132_h_rek pld0132_h_tag tag_count in 1/200, sepby(pid)

* Beispiel

sort pid syear

list pid syear pld0132_h_rek pld0132_h_tag tag_count if pid==78905

**********************************************************************

* Feste Partnerschaft

bysort syear: tab pld0132_h_rek

gen partner_year=.

replace partner_year=syear if pld0132_h_rek==1

tab partner_year

sort pid syear

list pid syear pld0132_h_rek partner_year

* Generieren: Zeit Partnerschaft

bysort pid: gen partner_time = sum(!missing(partner_year)) if partner_year!=.

list pid syear pld0132_h_rek partner_year partner_time in 1/100, sepby(pid)

* bysort pid: replace partner_time=partner_time[_n-1] if partner_time==. & pld0132_h_rek==1

list pid syear pld0132_h_rek partner_year partner_time in 1/100, sepby(pid)

sort pid syear

***********************************

* Partnerschaftsstatus bereinigen

* Sort again

sort pid syear

* Bereinigen um Personen...

* ... die geschieden sind:

drop if pld0131==4

sort pid syear

* ... die verwitwet sind:

drop if pld0131==5

* ... keine Angaben zu Familienstand

* sort pid syear

* drop if pld0131==-1 | pld0131==-2

**********************************************************************

sort pid syear

* Variablen fuer Deskriptionen zu Berufsereignishaeufigkeiten aufbereiten

* Befristung

gen plb0037_h_dich=. 

replace plb0037_h_dich=1 if plb0037_h==2
replace plb0037_h_dich=0 if plb0037_h==1 | plb0037_h==3 | plb0037_h<0

* Geringfuegige Beschaeftigung

gen plb0187_h_dich=.

replace plb0187_h_dich=1 if plb0187_h==1 | plb0187_h==2
replace plb0187_h_dich=0 if plb0187_h==2 | plb0187_h==3 | plb0037_h==3 | plb0187_h<0

* Personen ausschließen, die zum Erhebungszeitpunkt (2013) in geringfuegiger Beschaeftigung waren:

by pid: drop if plb0187_h_dich==1 & syear==2013

* Zeitarbeit

gen plb0041_dich=.

replace plb0041_dich=1 if plb0041==1
replace plb0041_dich=0 if plb0041==2 | plb0037_h==3 | plb0041<0

* Personen ausschließen, die zum Erhebungszeitpunkt (2013) in Zeitarbeit waren:

by pid: drop if plb0041_dich==1 & syear==2013

sort pid syear

* Kurzarbeit

gen plc0057_h_dich=.

replace plc0057_h_dich=1 if plc0057_h==1
replace plc0057_h_dich=0 if plc0057_h==2 | plb0037_h==3 | plc0057_h<0

* Personen ausschließen, die zum Erhebungszeitpunkt (2013) in Kurzarbeit waren:

by pid: drop if plc0057_h_dich==1 & syear==2013

sort pid syear

* Arbeitslosigkeit

gen plb0021_dich=.

replace plb0021_dich=1 if plb0021==1
replace plb0021_dich=0 if plb0021==2 | plb0037_h==3 | plb0021<0

* Personen ausschließen, die zum Erhebungszeitpunkt (2013) arbeitslos waren:

by pid: drop if plb0021_dich==1 & syear==2013

sort pid syear

* Schulische oder berufliche Ausbildung

gen plg0012_dich=.

replace plg0012_dich=1 if plg0012==1 | plg0008==1
replace plg0012_dich=0 if plg0012==2 | plg0008==-2 | plb0037_h==3

* Personen ausschließen, die zum Erhebungszeitpunkt (2013) in Ausbildung waren:

by pid: drop if plg0012_dich==1 & syear==2013

sort pid syear

* Sonstige Erwerbsepisoden

gen plb0037_sonst_dich=.

replace plb0037_sonst_dich=1 if plb0037_h==3
replace plb0037_sonst_dich=0 if plb0037_h==1 | plb0037_h==2 | plb0037_h<0

* Personen ausschließen, die zum Erhebungszeitpunkt (2013) anderweitig erwerbstaetig waren:

by pid: drop if plb0037_sonst_dich==1 & syear==2013

sort pid syear

**********************************************************************

* Prozesszeiten generieren

* Personenzeit generieren:

sort pid syear

gen person_time=.

bysort pid: replace person_time=_n

gen person_time_max=.

bysort pid: replace person_time_max=_N

list pid syear person_time person_time_max in 1/40, sepby(pid)

sort pid syear

* Ungueltige Zeitangaben loeschen

drop if person_time==.

drop if partner_time==.

drop if person_time==0

drop if partner_time==0

* Checken, ob noch einzeilige (max. Partnerschaftsdauer=1) Beobachtungen enthalten sind:

by pid: gen partner_time_max=_N

list pid syear partner_time partner_time_max if partner_time_max==1, sepby(pid)

drop if partner_time_max==1

sort pid syear

list pid syear partner_time partner_time_max if partner_time_max==1, sepby(pid)

list pid syear partner_time partner_time_max in 1/100, sepby(pid)

**********************************************************************

* Bereinigen auf eine Person pro Haushalt

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

sort hid pid

drop if hid==hid[_n-1] & pid!=pid[_n-1]

list hid pid in 1/200, sepby(pid)

**********************************************************************

* Partnerschaftsereignisse generieren

**********************************************************************

sort pid syear

* Zusammenzug mit Partner

bysort syear: tab pld0137

gen cohabitation_year=.

replace cohabitation_year=syear if pld0137==1

tab cohabitation_year

sort pid syear

list pid syear pld0137 cohabitation_year pld0138 pld0139 in 1/40 if pld0137==1, sepby(pid)

* Generieren: Zeit Kohabitation

sort pid syear

bysort pid: gen cohabitation_time = sum(!missing(cohabitation_year)) if cohabitation_year!=.

list pid syear pld0137 cohabitation_year cohabitation_time in 1/40, sepby(pid)

**********************************************************************

sort pid syear

* Heirat

gen marriage_year=.

replace marriage_year=syear if pld0134==1

tab marriage_year

list pid syear pld0134 marriage_year pld0135 pld0136 in 1/40 if pld0134==1, sepby(pid)

* Generieren: Zeit Heirat

sort pid syear

bysort pid: gen marriage_time = sum(!missing(marriage_year)) if marriage_year!=.

list pid syear pld0134 marriage_year marriage_time in 1/40, sepby(pid)

**********************************************************************

sort pid syear

* Geburt erstes Kind

gen child_year=.

replace child_year=syear if pld0152==1

tab child_year

list pid syear pld0152 child_year pld0153 pld0154 in 1/40 if pld0152==1, sepby(pid)

* Generieren: Zeit Geburt erstes Kind

sort pid syear

bysort pid: gen child_time = sum(!missing(child_year)) if child_year!=.

list pid syear pld0134 child_year child_time in 1/40, sepby(pid)

***********************************

* Partnerzeit neu generieren

* Faelle ausschließen, die im Jahr 2013 kein Interview haben

gsort pid-syear

by pid: drop if syear[1]!=2013

sort pid syear

sort pid syear

drop partner_time

bysort pid: gen partner_time = sum(!missing(partner_year)) if partner_year!=.

***********************************

* Absolute Berufsereignishaeufigkeiten (nach Episoden)

* Gesamtepisoden in Monaten:

* Befristung
tab plb0037_h_dich

* Unbefristet
tab plb0037_h if plb0037_h>0

* Geringfuegige Beschaeftigung
tab plb0187_h_dich

* Zeitarbeit
tab plb0041_dich

* Kurzarbeit
tab plc0057_h_dich

* Arbeitslosigkeit
tab plb0021_dich

* Schulische oder berufliche Ausbildung
tab plg0012_dich

* Sonstige Erwerbsepisoden
tab plb0037_sonst_dich

*****

sort pid syear

by pid: gen gt=_n

* Vorlaeufige Ereignisvariable:

gen ee=0

sort pid syear

* STSET

stset gt, failure(ee=1) id(pid)

stdes

stsum

*****

******************************

* Kap. 5.1.3
* TABELLE 8

******************************

* Berechnung der Berufsereignishaeufigkeiten nach Episoden in Monaten

* Gesamtepisoden in Monaten:

disp 4719*12 // (=56628)

*****

* Befristung - Episoden in Monaten

disp 930*12

* Anteil Befristung an Gesamtepisoden

disp 11160/56628

*****

* Unbefristet - Episoden in Monaten

tab plb0037_h

disp 2774*12

* Anteil Unbefristet an Gesamtepisoden

disp 33288/56628

*****

* Geringfuegige Beschaeftigung - Episoden in Monaten

disp 148*12

* Anteil Geringfuegige Beschaeftigungan Gesamtepisoden

disp 1776/56628

*****

* Zeitarbeit - Episoden in Monaten

disp 63*12

* Anteil Zeitarbeit an Gesamtepisoden

disp 756/56628

*****

* Kurzarbeit - Episoden in Monaten

disp 38*12

* Anteil Kurzarbeit an Gesamtepisoden

disp 456/56628

*****

* Arbeitslosigkeit - Episoden in Monaten

disp 161*12

* Anteil Arbeitslosigkeit an Gesamtepisoden

disp 1932/56628

*****

* Schulische oder berufliche Ausbildung - Episoden in Monaten

disp 659*12

* Schulische oder berufliche Ausbildung - Anteil an Gesamtepisoden

disp 7908/56628

*****

* Sonstige Erwerbsepisoden - Episoden in Monaten

disp 207*12

* Sonstige Erwerbsepisoden - Anteil an Gesamtepisoden

disp 2448/56628

*************************************************************

* Durchschnittliche Episodenhaeufigkeiten pro Person in ausgewaehlten Kategorien (AGIPEB und SOEP)

disp 25923/533		// Durchschnittliche Anzahl an Befristungsepisoden pro Person, die mindestens eine Befristungsepisode berichtet hat (AGIPEB)

disp 11016/387		// Durchschnittliche Anzahl an Befristungsepisoden pro Person, die mindestens eine Befristungsepisode berichtet hat (SOEP)

disp 51917/759		// Durchschnittliche Anzahl an unbefristeten Episoden pro Person, die mindestens eine unbefristete Episode berichtet hat (AGIPEB)

disp 32760/709		// Durchschnittliche Anzahl an unbefristeten Episoden pro Person, die mindestens eine unbefristete Episode berichtet hat (SOEP)

*************************************************************

******************************

* Kap. 5.2.2
* TABELLE 1

******************************

* Berufsereignishaeufigkeiten (nach Personen)

* Gesamtpersonen:

* STSET

stset gt, failure(ee=1) id(pid)

stsum		// 809

*****

* Befristung:

stsum if plb0037_h_dich==1

* Nicht befristet:

disp 809-388

* Relative Haeufigkeiten:

disp 388/809		// Anteil Befristet

disp 421/809		// Anteil Nicht befristet

*****

* Unbefristete Beschäftigung:

stsum if plb0037_h==1

* Nicht unbefristet:

disp 809-706

* Relative Haeufigkeiten:

disp 706/809		// Unbefristete Beschäftigung

disp 103/809		// Anteil Nicht unbefristet

*****

* Geringfuegige Beschaeftigung:

stsum if plb0187_h_dich==1

* Nicht Geringfuegige Beschaeftigung:

disp 809-91

* Relative Haeufigkeiten:

disp 91/809		// Anteil Geringfuegige Beschaeftigung

disp 718/809		// Anteil Nicht Geringfuegige Beschaeftigung

*****

* Zeitarbeit:

stsum if plb0041_dich==1

* Nicht Zeitarbeit:

disp 809-52

* Relative Haeufigkeiten:

disp 52/809		// Anteil Zeitarbeit

disp 757/809		// Anteil Nicht Zeitarbeit

*****

* Kurzarbeit:

stsum if plc0057_h_dich==1

* Nicht Kurzarbeit:

disp 809-33

* Relative Haeufigkeiten:

disp 33/809		// Anteil Kurzarbeit

disp 776/809		// Anteil Nicht Kurzarbeit

*****

* Arbeitslosigkeit:

stsum if plb0021_dich==1

* Nicht Arbeitslosigkeit:

disp 809-94

* Relative Haeufigkeiten:

disp 94/809		// Anteil Arbeitslosigkeit

disp 715/809		// Anteil Nicht Arbeitslosigkeit

*****

* Schulische oder berufliche Ausbildung:

stsum if plg0012_dich==1

* Nicht Schulische oder berufliche Ausbildung:

disp 809-301

* Relative Haeufigkeiten:

disp 301/809		// Anteil Schulische oder berufliche Ausbildung

disp 508/809		// Anteil Nicht Schulische oder berufliche Ausbildung

*****

* Sonstige Erwerbsepisoden:

stsum if plb0037_sonst_dich==1

* Nicht Sonstige Erwerbsepisoden:

disp 809-104

* Relative Haeufigkeiten:

disp 104/809		// Anteil Sonstige Erwerbsepisoden

disp 705/809		// Anteil Nicht Sonstige Erwerbsepisoden

***********************************
***********************************
***********************************

* Partnerschaftsereignisse - deskriptive Statistiken

******************************

* Kap. 5.1.3
* TABELLE 8

******************************

* Kohabitationsdauer

* Ereignisbiographie vervollstaendigen

by pid: replace pld0137=1 if pld0137[_n-1]==1

by pid: replace pld0137=0 if pld0137<0

list pid syear pld0137 partner_time in 1/50, sepby(pid)

* STSET

stset partner_time, failure(pld0137=1) id(pid)

stdes

stsum 

sts list

sts graph

* Personenhaeufigkeiten:

disp 809-403

disp 403/809

disp 406/809

*****

* Heiratsdauer

* Ereignisbiographie vervollstaendigen

by pid: replace pld0134=1 if pld0134[_n-1]==1

by pid: replace pld0134=0 if pld0134<0

list pid syear pld0134 in 1/50, sepby(pid)

* STSET

stset partner_time, failure(pld0134=1) id(pid)

stdes

stsum

sts list

sts graph

* Personenhaeufigkeiten:

disp 809-312

disp 312/809

disp 497/809

*****

* Geburt erstes Kind-Dauer

* Ereignisbiographie vervollstaendigen

by pid: replace pld0152=1 if pld0152[_n-1]==1

by pid: replace pld0152=0 if pld0152<0

list pid syear pld0152 in 1/50, sepby(pid)

* STSET

stset partner_time, failure(pld0152=1) id(pid)

stdes

stsum

sts list

sts graph

* Personenhaeufigkeiten:

disp 809-258

disp 258/809

disp 551/809

***********************************

* Deskriptive Statistiken - Sozialstruktur und Erwerbssituation (Querschnitt 2012)

* Befristung

tab plb0037_h_dich if syear==2013

******************************

* Kap. 5.2.1
* TABELLE 12

******************************

* Geschlechtsunterschiede nach Befristung

* Geschlecht x Befristung

phi plb0037_h_dich pla0009_v2 if syear==2013, col

phi plb0037_h_dich pla0009_v2 if syear==2013, row

* 1=Maennlich
* 2=Weiblich

******************************

* Kap. 5.2.1
* TABELLE 13

******************************

* Bildungsunterschiede nach Befristungsepisode

* Bildungsstand dichotomisieren

gen pgpsbil_dich=.

replace pgpsbil_dich=1 if pgpsbil==3 | pgpsbil==4
replace pgpsbil_dich=0 if pgpsbil==1 | pgpsbil==2 | pgpsbil==5 | pgpsbil==6

* Bildung x Befristung

phi plb0037_h_dich pgpsbil_dich if syear==2013, col

phi plb0037_h_dich pgpsbil_dich if syear==2013, row

tab pgpsbil_dich if syear==2013

******************************

* Kap. 5.2.1
* TABELLE 14

******************************

* t-test: Altersunterschiede nach Befristung

robvar age if syear==2013, by(plb0037_h_dich) // Levene-Statistik --> W0

ttest age if syear==2013, by(plb0037_h_dich) unequal // t-Test

* t-test: Einkommen und Befristung

* Missings deklarieren

replace pglabnet=. if pglabnet<0

robvar pglabnet if syear==2013, by(plb0037_h_dich) // Levene-Statistik --> W0

ttest pglabnet if syear==2013, by(plb0037_h_dich) // t-Test

* Sorge um eigene wirtschaftliche Lage

* Missings bereinigen:

replace plh0033=. if plh0033==-1

gen plh0033_inv=.

replace plh0033_inv=1 if plh0033==3
replace plh0033_inv=2 if plh0033==2
replace plh0033_inv=3 if plh0033==1

tab plh0033_inv if plh0033_inv>0 & syear==2013
sum plh0033_inv if plh0033_inv>0 & syear==2013

* Z-Transformation

egen plh0033_z = std(plh0033)

sum plh0033_z if syear==2013, detail

* t-test (mit Befristung): Sorge um wirtschaftliche Lage

robvar plh0033 if syear==2013, by(plb0037_h_dich) // Levene-Statistik --> W0

ttest plh0033 if syear==2013, by(plb0037_h_dich) // t-Test

reg plh0033_inv plb0037_h_dich pglabnet pgpsbil_dich pla0009_v2 if syear==2013

******************************

* Kap. 5.2.1
* TABELLE 15

******************************

* Zufriedenheit mit Arbeitsstelle

* Missings deklarieren
replace plh0173=. if plh0173<=0

tab plh0173 if syear==2013
sum plh0173 if syear==2013

egen plh0173_z = std(plh0173)

sum plh0173_z if syear==2013, detail

* t-test (mit Befristung): Arbeitszufriedenheit

robvar plh0173 if syear==2013, by(plb0037_h_dich) // Levene-Statistik --> W0

ttest plh0173 if syear==2013, by(plb0037_h_dich) // t-Test

* Sorge um Sicherheit der Arbeitsstelle

* Missings deklarieren

replace plh0042=. if plh0042<=0

gen plh0042_inv=.

replace plh0042_inv=1 if plh0042==3
replace plh0042_inv=2 if plh0042==2
replace plh0042_inv=3 if plh0042==1

tab plh0042 if syear==2013
sum plh0042 if syear==2013

egen plh0042_z = std(plh0042)

sum plh0042_z if syear==2013, detail

* t-test (mit Befristung): Arbeitsplatzsicherheit

robvar plh0042 if syear==2013, by(plb0037_h_dich) // Levene-Statistik --> W0

ttest plh0042 if syear==2013, by(plb0037_h_dich) // t-Test


**********************************************************************

******************************

* Kap. 5.1.3
* TABELLE 11

******************************

* Deskriptive Statistiken - Subjektive Partnerschaftseinstellungen (Querschnitt 2013)

* Zufriedenheit mit Familienleben (Proxy fuer Partnerschaftszufriedenheit bei verpartnerten Personen)

tab plh0180 if plh0180>=0 & syear==2013
sum plh0180 if plh0180>=0 & syear==2013

* Z-Transformation:

egen plh0180_z = std(plh0180) if plh0180>=0

sum plh0180_z if syear==2013, detail

* t-test (mit Befristung): Zufriedenheit mit Familienleben

robvar plh0180 if plh0180>=0 & syear==2013, by(plb0037_h_dich) // Levene-Statistik --> W0

ttest plh0180 if plh0180>=0 & syear==2013, by(plb0037_h_dich) // t-Test