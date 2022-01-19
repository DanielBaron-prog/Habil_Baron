clear

use "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Daten\Daten_AGIPEB_30-STATA.dta"

* version 13

set more off

* log using 180305-output.log, replace

*****************************
*
* Variablen im Datensatz:
*
* id

* AV:

* skala_spw3
* Items: v31 v32 v33

* Fuer CFA zudem

* skala_ssa
* Items: v52_inv v53 v54 v55 v56 v57

* skala_bs
* Items: v59_inv v60_inv v61 v62 v63_inv v64_inv v66

* UV:
 
* v17
* v78

* KV:

* v163_zentr
* v192_dich
* v7
* v8
* pb4_event = kohabitation mit Partner_in?
* pb1_event = Verheiratet?
* pb2_event = Kind geboren?

* Partnerdaten (hier nicht verwendet):

* v245 = PartnerIn aktuell befristet?
* v166 = PartnerIn Einkommen
* v216_dich = PartnerIn höchster Schulbildungsabschluss

*****************************

* renames

rename pb1_1 pb1_event
rename pb2_kind_event pb2_event
rename pb3_urlaub_event pb3_event
rename pb4_haushalt_event pb4_event
rename pb5_kasse_event pb5_event
rename pb6_spareinlage_event pb6_event
rename pb7_auto_event pb7_event
rename pb8_immobilie_event pb8_event

* Alte, nicht korrekte Variablen loeschen:

drop v500

*****************************

*****************************

* Gleichgeschlechtliche Paare droppen

drop if v8==0 & v10==0
drop if v8==1 & v10==1

*****************************

* Faelle ausschliessen, die weniger als 20 Stunden pro Woche arbeiten

drop if v45<=19

******************************

* Aufbereitung Missings

replace v7=. if v7==-999

replace v8=. if v8==-999

replace v8_m=. if v8_m==-999

replace v15=. if v15>100

replace v16=. if v16>100

replace v17=. if v17==-999

replace v245=. if v245==8
replace v245=. if v245==9

replace v28=. if v28==8 | v28==9
replace v29=. if v29==8 | v29==9
replace v30=. if v30==8 | v30==9
replace v31=. if v31==8 | v31==9
replace v32=. if v32==8 | v32==9
replace v33=. if v33==8 | v33==9
replace v34=. if v34==8 | v34==9
replace v35=. if v35==8 | v35==9

replace v192=. if v192>6

replace v398_dich=. if v398_dich>2

replace v78=. if v78>11

replace v49_dich=. if v49_dich==88

*************************

* Invertieren

gen v35_inv=.

replace v35_inv=1 if v35==5
replace v35_inv=2 if v35==4
replace v35_inv=3 if v35==3
replace v35_inv=4 if v35==2
replace v35_inv=5 if v35==1

gen v31_inv=.

replace v31_inv=1 if v31==5
replace v31_inv=2 if v31==4
replace v31_inv=3 if v31==3
replace v31_inv=4 if v31==2
replace v31_inv=5 if v31==1

*************************

* Weitere Missings

replace v39_alle=. if v39_alle>10

replace v52=. if v52==8 | v52==9 | v52==-999
replace v52_inv=. if v52_inv==8 | v52_inv==9 | v52_inv==-999

replace v53=. if v53==8 | v53==9 | v53==-999

replace v54=. if v54==8 | v54==9 | v54==-999

replace v55=. if v55==8 | v55==9 | v55==-999

replace v56=. if v56==8 | v56==9 | v56==-999

replace v57=. if v57==8 | v57==9 | v57==-999

replace v58=. if v58==8 | v58==9 | v58==-999

replace v59=. if v59==8 | v59==9 | v59==-999
replace v59_inv=. if v59_inv==8 | v59_inv==9 | v59_inv==-999

replace v60=. if v60==8 | v60==9 | v60==-999
replace v60_inv=. if v60_inv==8 | v60_inv==9 | v60_inv==-999

replace v61=. if v61==8 | v61==9 | v61==-999

replace v62=. if v62==8 | v62==9 | v62==-999

replace v63=. if v63==8 | v63==9 | v63==-999
replace v63_inv=. if v63_inv==8 | v63_inv==9 | v63_inv==-999

replace v64=. if v64==8 | v64==9 | v64==-999
replace v64_inv=. if v64_inv==8 | v64_inv==9 | v64_inv==-999

replace v65=. if v65==8 | v65==9 | v65==-999

replace v66=. if v66==8 | v66==9 | v66==-999

replace v163=. if v163==999999
replace v163=. if v163==999998

replace v192=. if v192==-999

replace v192_dich=. if v192_dich>1

replace v191=. if v191>5

replace v413proz=. if v413proz==-999

replace v414proz=. if v414proz==-999

replace v415proz=. if v415proz==-999

replace pb1_event=. if pb1_event==8
replace pb1_event=. if pb1_event==9

replace pb2_event=. if pb2_event==8
replace pb2_event=. if pb2_event==9

replace pb3_event=. if pb3_event==8
replace pb3_event=. if pb3_event==9

replace pb3_event=. if pb3_event==8
replace pb3_event=. if pb3_event==9

replace pb4_event=. if pb4_event==8
replace pb4_event=. if pb4_event==9

replace pb5_event=. if pb5_event==8
replace pb5_event=. if pb5_event==9

replace pb6_event=. if pb6_event==8
replace pb6_event=. if pb6_event==9

replace pb7_event=. if pb7_event==8
replace pb7_event=. if pb7_event==9

replace pb8_event=. if pb8_event==8
replace pb8_event=. if pb8_event==9

replace v154=. if v154>100

*replace v430proz=. if v430proz==-999

replace skala_bs=. if skala_bs==-999

replace skala_ssa=. if skala_ssa==-999

replace v77=. if v77==-999

replace v77=. if v77==99

replace v129=. if v129>1

gen v122_inv=.

replace v122_inv=1 if v122==0
replace v122_inv=0 if v122==1

replace v122_inv=. if v122_inv>1

replace v137=. if v137>1

replace v137_inv=. if v137_inv>1

replace v245 = . if v245==-999

replace v164_neu=. if v164_neu>7

replace v164_4kat=. if v164_4kat>4

replace v165=. if v165>99997

replace v165=0 if v165==99997

replace v166_neu=. if v166_neu>7

replace v166_4kat = . if v166_4kat>4

replace v216_dich = . if v216_dich==-999

replace pb2_1=. if pb2_1==-999

* Rekodierung p2_1

replace pb2_1=0 if pb2_1==1
replace pb2_1=1 if pb2_1==2

replace pb2_1 = . if pb2_1==-999


replace skala_spw=. if skala_spw==-999

replace skala_spw3=. if skala_spw3==-999

replace v31=. if v31==-999

replace v32=. if v32==-999

replace v33=. if v33==-999

replace v34=. if v34==-999

replace v45=. if v45==999
replace eb1_11=. if eb1_11==999
replace eb2_11=. if eb2_11==999
replace eb3_11=. if eb3_11==999
replace eb4_11=. if eb4_11==999
replace eb5_11=. if eb5_11==999
replace eb6_11=. if eb6_11==999
replace eb7_11=. if eb7_11==999
replace eb8_11=. if eb8_11==999
replace eb9_11=. if eb9_11==999
replace eb10_11=. if eb10_11==999

replace v121=. if v121>100

replace v141=. if v141>100

replace v129=.

replace v129=v129_dez*100

replace v129=. if v129>100
replace v141=. if v141>100
replace v248=. if v248>100

replace v142=. if v142>5
replace v143=. if v143>5
replace v144=. if v144>5
replace v145=. if v145>5
replace v146=. if v146>5
replace v147=. if v147>5
replace v148=. if v148>5
replace v149=. if v149>5
replace v150=. if v150>5
replace v151=. if v151>5
replace v152=. if v152>5
replace v153=. if v153>5
replace v155=. if v155>5
replace v155_inv=. if v155_inv>5
replace v156=. if v156>5
replace v156_inv=. if v156_inv>5
replace v157=. if v157>5
replace v157_inv=. if v157_inv>5
replace v158=. if v158>5
replace v158_inv=. if v158_inv>5
replace v159=. if v159>5
replace v159_inv=. if v159_inv>5
replace v160=. if v160>5
replace v160_inv=. if v160_inv>5
replace v161=. if v161>5
replace v161_inv=. if v161_inv>5
replace v162=. if v162>5
replace v162_inv=. if v162_inv>5

* replace v430proz=. if v430proz==-999

replace skala_bs=. if skala_bs==-999

replace skala_ssa=. if skala_ssa==-999

replace v77=. if v77==-999

replace v77=. if v77==99

replace v129=. if v129>1

* gen v122_inv=.

* replace v122_inv=1 if v122==0
* replace v122_inv=0 if v122==1

* replace v122_inv=. if v122_inv>1

replace v137=. if v137>1

replace v137_inv=. if v137_inv>1

replace v245 = . if v245==-999

replace v164_neu=. if v164_neu>7

replace v164_4kat=. if v164_4kat>4

replace v165=. if v165>99997

replace v165=0 if v165==99997

replace v166_neu=. if v166_neu>7

replace v166_4kat = . if v166_4kat>4

replace v216_dich = . if v216_dich==-999

replace pb2_1=. if pb2_1==-999

replace v216=. if v216>5

replace v240=. if v240>8

replace v236=. if v236>2

replace v242=. if v242>80

replace v246=. if v246>2

replace v247=. if v247>2

replace v391=. if v391==97
replace v391=. if v391==98
replace v391=. if v391==99

replace v391_3kat=. if v391_3kat==8
replace v391_3kat=. if v391_3kat==9

replace v391_dummy=. if v391_dummy==8
replace v391_dummy=. if v391_dummy==9

replace v391_dummy_kath=. if v391_dummy_kath==8
replace v391_dummy_kath=. if v391_dummy_kath==9

replace v393=. if v393==97 | v393==98 | v393==99
replace v393=. if v393==97 | v393==99

replace v393_3kat=. if v393_3kat==8
replace v393_3kat=. if v393_3kat==9

* Umkodieren Variablen Staatsangehoerigkeit

replace v425_dich=0 if v425_dich==1
replace v425_dich=1 if v425_dich==2

replace v426_dich=0 if v426_dich==1
replace v426_dich=1 if v426_dich==2
replace v426_dich=. if v426_dic>2

*******************************************************************************************************

* Relative Anteile von Erwerbstypen korrigieren

replace v415=0 if v415==.
replace v415proz=0 if v415proz==.

replace v416=0 if v416==.
replace v416proz=0 if v416proz==.

replace v417=0 if v417==.
replace v417proz=0 if v417proz==.

replace v418=0 if v418==.
replace v418proz=0 if v418proz==.

******************************

* Einkommen in Tausend Euro:

gen v163_in_t=v163/1000

* Einkommen Partner in Tausend Euro:

gen v165_in_t=v165/1000

******************************

* Korrigieren: Anzahl gemeinsamer Kinder

replace v124=0 if v124==.

******************************

*******************************************************************************************************

* Variablen erstellen für Angabe, ob jemals eine spezifische Erwerbsepisode vorlauf

* Erstellen Variable "Jemals befristet gewesen?" (v500)

gen v500 = .

replace v500 = 0 if v413==0
replace v500 = 1 if v413>0

label variable v500 "Jemals befristet gewesen?"

* lab def v500 0 "Nein" 1 "Ja"

label values v500 v500

tab v500

* Erstellen Variable "Jemals unbefristet gewesen?" (v501)

gen v501 = .

replace v501 = 0 if v500==1
replace v501 = 1 if v500==0

label variable v501 "Jemals unbefristet gewesen?"

label values v501 v500

tab v501

* Erstellen Variable "Jemals arbeitslos gewesen?" (v503)

gen v503 = .

replace v503 = 0 if v415==0
replace v503 = 1 if v415>0

label variable v503 "Jemals arbeitslos gewesen?"

label values v503 v500

tab v503

* Erstellen Variable "Jemals in Leih- oder Zeitarbeit gewesen?" (v503)

gen v504 = .

replace v504 = 0 if v418==0
replace v504 = 1 if v418>0

label variable v504 "Jemals Leih- oder Zeitarbeit gewesen?"

label values v504 v500

tab v504

* Erstellen Variable "Jemals in Kurzarbeit gewesen?" (v503)

gen v505 = .

replace v505 = 0 if v417==0
replace v505 = 1 if v417>0

label variable v505 "Jemals Kurzarbeit gewesen?"

label values v505 v500

tab v505

* Erstellen Variable "Jemals geringuegig beschaeftigt gewesen?" (v503)

gen v506 = .

replace v506 = 0 if v416==0
replace v506 = 1 if v416>0

label variable v506 "Jemals geringuegig beschaeftigt gewesen?"

label values v506 v500

tab v506

*******************************************************************************************************

* Generieren Wochenarbeitszeit - Gesamtvariable

gen v45_ges=.

replace v45_ges=eb1_11 if v45_ges==.
replace v45_ges=eb2_11 if v45_ges==.
replace v45_ges=eb3_11 if v45_ges==.
replace v45_ges=eb4_11 if v45_ges==.
replace v45_ges=eb5_11 if v45_ges==.
replace v45_ges=eb6_11 if v45_ges==.
replace v45_ges=eb7_11 if v45_ges==.
replace v45_ges=eb8_11 if v45_ges==.
replace v45_ges=eb9_11 if v45_ges==.
replace v45_ges=eb10_11 if v45_ges==.

tab v45_ges

replace v45_ges=v45 if v45_ges==.

tab v45_ges

sum v45_ges

*******************************************************************************************************

* Generieren Monatliches Nettoeinkommen (Befragte) - Gesamtvariable

gen v164_ges=.

replace v164_ges=1 if v164==1 | v163<400
replace v164_ges=2 if v164==1 | (v163>=400 & v163<800)
replace v164_ges=3 if v164==4 | (v163>=800 & v163<1100)
replace v164_ges=4 if v164==5 | (v163>=1100 & v163<1400)
replace v164_ges=5 if v164==6 | (v163>=1400 & v163<1700)
replace v164_ges=6 if v164==7 | (v163>=1700 & v163<2000)
replace v164_ges=7 if v164==8 | (v163>=2000 & v163<2500)
replace v164_ges=8 if v164==9 | (v163>=2500 & v163<3000)
replace v164_ges=9 if (v164==10 | v164==11 | v164==12) | (v163>=3000 & v163<99997)

lab def v164_ges 1 "bis unter 400 Euro" 2 "400 bis unter 800 Euro" 3 "800 bis unter 1100 Euro" 4 "1100 bis unter 1400" 5 "1400 bis unter 1700" ///
6 "1700 bis unter 2000" 7 "2000 bis unter 2500" 8 "2500 bis unter 3000" 9 "3000 Euro und mehr"

lab val v164_ges v164_ges

tab v164_ges

* Generieren Monatliches Nettoeinkommen (Partner_innen) - Gesamtvariable

gen v166_ges=.

replace v166_ges=1 if v166==1 | v165<400
replace v166_ges=2 if v166==1 | (v165>=400 & v165<800)
replace v166_ges=3 if v166==4 | (v165>=800 & v165<1100)
replace v166_ges=4 if v166==5 | (v165>=1100 & v165<1400)
replace v166_ges=5 if v166==6 | (v165>=1400 & v165<1700)
replace v166_ges=6 if v166==7 | (v165>=1700 & v165<2000)
replace v166_ges=7 if v166==8 | (v165>=2000 & v165<2500)
replace v166_ges=8 if v166==9 | (v165>=2500 & v165<3000)
replace v166_ges=9 if (v166==10 | v166==11 | v166==12) | (v165>=3000 & v165<99997)

lab def v166_ges 1 "bis unter 400 Euro" 2 "400 bis unter 800 Euro" 3 "800 bis unter 1100 Euro" 4 "1100 bis unter 1400" 5 "1400 bis unter 1700" ///
6 "1700 bis unter 2000" 7 "2000 bis unter 2500" 8 "2500 bis unter 3000" 9 "3000 Euro und mehr"

lab val v166_ges v166_ges

tab v166_ges

*******************************************************************************************************

* umbenennung der erwerbsschleifen um reshape zu ermoeglichen *

rename  eb1beginn eb_beginn1
rename  eb2beginn eb_beginn2
rename  eb3beginn eb_beginn3
rename  eb4beginn eb_beginn4
rename  eb5beginn eb_beginn5
rename  eb6beginn eb_beginn6
rename  eb7beginn eb_beginn7
rename  eb8beginn eb_beginn8
rename  eb9beginn eb_beginn9
rename  eb10beginn eb_beginn10
rename  eb11beginn eb_beginn11
rename  eb12beginn eb_beginn12

rename  eb1ende eb_ende1
rename  eb2ende eb_ende2
rename  eb3ende eb_ende3
rename  eb4ende eb_ende4
rename  eb5ende eb_ende5
rename  eb6ende eb_ende6
rename  eb7ende eb_ende7
rename  eb8ende eb_ende8
rename  eb9ende eb_ende9
rename  eb10ende eb_ende10
rename  eb11ende eb_ende11
rename  eb12ende eb_ende12

rename  eb1dauer eb_dauer1
rename  eb2dauer eb_dauer2
rename  eb3dauer eb_dauer3
rename  eb4dauer eb_dauer4
rename  eb5dauer eb_dauer5
rename  eb6dauer eb_dauer6
rename  eb7dauer eb_dauer7
rename  eb8dauer eb_dauer8
rename  eb9dauer eb_dauer9
rename  eb10dauer eb_dauer10
rename  eb11dauer eb_dauer11
rename  eb12dauer eb_dauer12

rename  eb1_typ eb_typ1
rename  eb2_typ eb_typ2
rename  eb3_typ eb_typ3
rename  eb4_typ eb_typ4
rename  eb5_typ eb_typ5
rename  eb6_typ eb_typ6
rename  eb7_typ eb_typ7
rename  eb8_typ eb_typ8
rename  eb9_typ eb_typ9
rename  eb10_typ eb_typ10
rename  eb11_typ eb_typ11
rename  eb12_typ eb_typ12

*******************************************************************************************************

* Grundlegende Deskriptionen (Abschnitt 5.1.1)
* Darstellungen nur im Text

*******************************************************************************************************

* Screening-Kriterium und Standarddemographie

* Befristung im Lebenslauf (Screening-Kriterium):

tab v500

* Befristung ztum Erhebungszeitpunkt:

tab v17

* Vergleich nach beruflicher Stellung und Bildungsstand:

tab v17 v39_alle, col
tab v17 v39_alle, row

tab v192_dich v39_alle, col
tab v192_dich v39_alle, row

* Alter:

sum v7

* Geschlecht:

tab v8

* Verteilung Wochenarbeitszeit, differenziert nach Geschlechtergruppen

robvar v45_ges, by(v8) // Levene-Statistik --> W0

ttest v45_ges, by(v8) // t-Test

* Bildung:

tab v192

tab v192_dich

*******************************************************************************************************

* Erwerbsbezogene Deskriptionen (Abschnitt 5.1.2)

*******************************************************************************************************

******************************

* Kap. 5.1.2
* TABELLE 1

******************************

* Haeufigkeiten Befristung
tab v17

*****************

* Personen, die durchlaufen haben...

* ... befristete Beschaeftigung

tab v500

* ... unbefristete Beschaftigung

tab v501

* ... geringfuegige Beschaefitung

tab v506

* ... Leih- oder Zeitarbeit

tab v504

* ... Kurzarbeit

tab v505

* ... Arbeitslosigkeit

tab v503

*******************************************************************************************************

* Partnerschaftsbezogene Deskriptionen (Abschnitt 5.1.3)

*******************************************************************************************************

******************************

* Kap. 5.1.3
* TABELLE 8

******************************

* Partnerschaftsereignisse

tab pb3_event
tab pb5_event
tab pb6_event
tab pb4_event
tab pb1_event
tab pb2_event
tab pb7_event
tab pb8_event

* Kontrolle pb2_event (Kind) vs. pb7_event (Auto)

tab pb2_event pb7_event

******************************

* Kap. 5.1.3
* TABELLE 9

******************************

* Deskription frueher Befristungserfahrungen und -ereignisse:

* Fruehere Ehen - ja/nein:

tab v122_inv

* Anzahl frueher Ehen:

tab v123

* Kinder aus frueheren Beziehungen - ja/nein:

tab v137_inv

* Anzahl Kinder aus frueheren Beziehungen

tab v138

tab v122_inv v137_inv

* Alter:

sum v7

* ANMERKUNG: Fuer detaillierte partnerschaftsbiographische Deskriptionen siehe entsprechenden Do Files

*******************************************************************************************************

******************************

* Kap. 5.1.3
* TABELLE 10 und 11

******************************

* Subjektive Partnerschaftsmerkmale

* Partnerschaftszufriedenheit

sum v154

* z-Transformation fuer Vergleich mit Pairfam 2012/13

egen v154_z = std(v154) // Standardisiert

sum v154_z, detail

* Subjektive Partnerschaftsstabilitaet

tab v143
sum v143

* z-Transformation fuer Vergleich mit Pairfam 2012/13

egen v143_z = std(v143) // Standardisiert

sum v143_z, detail

* Geschlechterrollenbilder

tab v161
sum v161

* z-Transformation fuer Vergleich mit Pairfam 2012/13

egen v161_z = std(v161) // Standardisiert

sum v161_z, detail

* Heiratswunsch

tab v121
sum v121

* z-Transformation fuer Vergleich mit Pairfam 2012/13

egen v121_z = std(v121) // Standardisiert

sum v121_z, detail

* Kinderwunsch

tab v129
sum v129

* z-Transformation fuer Vergleich mit Pairfam 2012/13

egen v129_z = std(v129) // Standardisiert

sum v129_z, detail

* Immobilienwunsch

tab v141
sum v141

*******************************************************************************************************

* Abschnitt 5.2 - Subjektive erwerbs- und partnerschaftsbezogene Merkmale befristeter und unbefristeter Beschaeftigter

******************************

* Kap. 5.2.1
* TABELLE 12

******************************

* Geschlecht x Befristung

phi v17 v8, col

phi v17 v8, row

******************************

* Kap. 5.2.1
* TABELLE 13

******************************

* Bildung x Befristung

tab2 v17 v192 if v192>1, col chi V

* Bildung (dichotomisiert) x Befristungserfahrungen

phi v17 v192_dich, col

phi v17 v192_dich, row

phi v17 v192_dich, row

******************************

* Kap. 5.2.1
* TABELLE 14

******************************

* t-test: Alter

robvar v7, by(v17) // Levene-Statistik --> W0

ttest v7, by(v17) unequal // t-Test

* t-test: Einkommen

robvar v163, by(v17) // Levene-Statistik --> W0

ttest v163, by(v17) unequal // t-Test

* t-test: Einschaetzung finanzielle Lage des eigenen Haushalts

robvar v191, by(v17) // Levene-Statistik --> W0

ttest v191, by(v17) // t-Test

reg v191 v17 v192_dich, beta

* t-test: Subjektive Schichtzugehoerigkeit

robvar v77, by(v17) // Levene-Statistik --> W0

ttest v77, by(v17) // t-Test

* t-test: Politische Selbsteinschaetzung

robvar v78, by(v17) // Levene-Statistik --> W0

ttest v78, by(v17) // t-Test

******************************

* Kap. 5.2.2
* TABELLE 15

******************************

* t-test: Berufliche Zufriedenheit

robvar v16, by(v17) // Levene-Statistik --> W0

ttest v16, by(v17) // t-Test

* t-test Arbeitsplatzsicherheit

robvar v53, by(v17) // Levene-Statistik --> W0

ttest v53, by(v17) unequal // t-Test

* t-test: Umsetzung Zukunftspläne

robvar v58, by(v17) // Levene-Statistik --> W0

ttest v58, by(v17) // t-Test

* t-test: Einschaetzung Unmoeglichkeit Umsetzen private Entscheidungen (invertiert)

robvar v31_inv, by(v17) // Levene-Statistik --> W0

ttest v31_inv, by(v17) unequal // t-Test

******************************

* Kap. 5.2.3
* TABELLE 16

******************************

* t-test: Partnerschaftszufriedenheit

robvar v154, by(v17) // Levene-Statistik --> W0

ttest v154, by(v17) // t-Test

* t-test: Einschaetzung lange andauern Beziehung

robvar v143, by(v17) // Levene-Statistik --> W0

ttest v143, by(v17) unequal // t-Test

* t-test: Einschaetzung Frau zuhause bleiben

robvar v161, by(v17) // Levene-Statistik --> W0

ttest v161, by(v17) // t-Test

* t-test: Heiratswunsch

robvar v121, by(v17) // Levene-Statistik --> W0

ttest v121, by(v17) // t-Test

* t-test: Kinderwunsch

robvar v129, by(v17) // Levene-Statistik --> W0

ttest v129, by(v17) // t-Test

* t-test: Immobilienwunsch

robvar v141, by(v17) // Levene-Statistik --> W0

ttest v141, by(v17) unequal // t-Test