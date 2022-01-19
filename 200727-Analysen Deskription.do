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

*****************************

* Aufbereitung Missings

replace v7=. if v7==-999

replace v8=. if v8==-999

replace v8_m=. if v8_m==-999

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

*************************

* Weitere Missings

replace v52=. if v52==8 | v52==9 | v52==-999
replace v52_inv=. if v52_inv==8 | v52_inv==9 | v52_inv==-999

replace v53=. if v53==8 | v53==9 | v53==-999

replace v54=. if v54==8 | v54==9 | v54==-999

replace v55=. if v55==8 | v55==9 | v55==-999

replace v56=. if v56==8 | v56==9 | v56==-999

replace v57=. if v57==8 | v57==9 | v57==-999

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

replace v154=. if v154==999

*replace v430proz=. if v430proz==-999

replace skala_bs=. if skala_bs==-999

replace skala_ssa=. if skala_ssa==-999

replace v77=. if v77==-999

replace v77=. if v77==99


replace v245 = . if v245==-999

replace v166_4kat = . if v166_4kat==-999

replace v166_4kat = . if v166_4kat==98

replace v166_4kat = . if v166_4kat==99

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

* Erstellen Variable "Jemals befristet gewesen?" (v500)

*gen v500 = .

*replace v500 = 0 if v413==0
*replace v500 = 1 if v413>0
*replace v500 = -999 if v500==.

*label variable v500 "Jemals befristet gewesen?"

*label define lblname 0 "Nein" 1 "Ja"

*label values v500 lblname

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

* Grundlegende Deskriptionen (Abschnitt 5.1)

* Deskriptive Statistiken / Stichprobenbeschreibung

* Erwerbs- und soziooekonomische Situation

tab v17

sum v413proz

tab v45_ges

sum v45_ges

sum v163

tab v49_dich

sum v78

tab v192

tab v192_dich

tab v8

sum v7

* Erwerbs- und soziooekonomische Situation (Einstellungen):

sum v16

sum v53

sum v191

* Partnerschaftsbezogene Merkmale

sum pb_dauer

tab pb4_event

tab pb2_event

tab pb1_event

tab pb8_event

* Partnerschaftsbezogene Merkmale (Einstellungen)

sum v154

* Partnerdaten

tab v245

sum v166

sum v216_dich

*******************************************************************************************************

* Bivariate Deskriptionen (Abschnitt 5.2)

* t-test

* Vergleiche zwischen Befristungsgruppen

robvar v31, by(v17) // Levene-Statistik --> W0

ttest v31, by(v17) // t-Test

*****

robvar v163, by(v17) // Levene-Statistik --> W0

ttest v163, by(v17) // t-Test

*****

robvar v45_ges, by(v17) // Levene-Statistik --> W0

ttest v45_ges, by(v17) // t-Test

*****

robvar pb_dauer, by(v17) // Levene-Statistik --> W0

ttest pb_dauer, by(v17) unequal // t-Test

*****

* Vergleiche zwischen Geschlechtergruppen --> W0

robvar v45_ges, by(v8) // Levene-Statistik --> W0

ttest v45_ges, by(v8) // t-Test

*****
	
*******************************************************************************************************
