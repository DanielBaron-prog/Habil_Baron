* Aufbereitung AGIPEB-Daten fuer Episodensplitting

* Daten: AGIPEB Vers. 30 

****************************

clear

use "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Daten\Daten_AGIPEB_30-STATA.dta"

* version 13

set more off

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

replace v49_dich=. if v49_dich>1

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

replace v158=. if v158==8 | v158==9
replace v158_inv=. if v158_inv==8 | v158_inv==9

replace v160=. if v160==8 | v160==9
replace v160_inv=. if v160_inv==8 | v160_inv==9

replace v161=. if v161==8 | v161==9
replace v161_inv=. if v161_inv==8 | v161_inv==9

replace v163=. if v163==999999
replace v163=. if v163==999998

replace v192=. if v192==-999

replace v192_dich=. if v192_dich>1

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

replace v413proz=0 if v413proz==.

replace v414proz=0 if v414proz==.

replace v415proz=0 if v415proz==.

replace v416proz=0 if v416proz==.

replace v417proz=0 if v417proz==.

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
******************************
******************************

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

***********************************************************
***********************************************************

* Personen droppen, die bereits Kinder aus frueherer Partnerschaft haben

drop if v137_inv==1


***********************************************************

* Dummy-Kodierung Variable "Bildung" (v192_abifh)

gen v192_abifh=.

move v192_abifh v192

replace v192_abifh=1 if v192==4 | v192==5

replace v192_abifh=0 if v192==1 | v192==2 | v192==3

replace v192_abifh=. if v192==6 | v192==9

tab v192_abifh

* Missingwerte deklarieren fuer v398_dich und v192 und v216

replace v398_dich=. if v398_dich==7 | v398_dich==8 | v398_dich==9

replace v192=. if v192==8 | v192==9

replace v192_abifh=. if v192==8 | v192==9

replace v192_dich=. if v192==8 | v192==9

replace v192_dich=. if v192_dich==8 | v192_dich==9

replace v216=. if 192==8 | v192==9

***********************************************************
***********************************************************

*************************************************************

* MI fuer spaetere EDA

* Literatur:

* White, Ian R. & Royston, Patrick (2009): Imputing Missing Covariate Values for the Cox Model. In: Statistics in Medicine, 28, 15, S. 1982-1998.
* Cleves et al. (2010): 169-175

***

* Deskription Missings

mdesc id pb4_event ///
v158_inv v158 ///
v7 v8_m v192_abifh v391_3kat v398_dich v425_dich ///
pb2_event pb1_event

* Hilfsvariablen identifizieren

pwcorr v398_dich v391_3kat v163 v7 v425_dich pb2_event pb1_event pb4_event pb8_event v158_inv v192_abifh, obs

* Check I:

reg v158_inv v391_3kat v398_dich v7 v8_m v192_abifh v425_dich

***

* MI-Modelle

* MI set

mi set mlong

* Variablen deklarieren, die Missings aufweisen und die imputiert werden sollen (v391_3kat, v398_dich)

mi register imputed v398_dich v391_3kat 

* Imuptation durchfuehren (Cleves et al. 2010: 172f., (White/Royston 2009)

* Zusaetzlich den Zufallszahlengenerator anpassen (rseed) und die Anzahl der Imputationen (n=42, s. mdesc - Problem: max. 1000 Imputationen moeglich) aufnehmen!

mi impute mvn v398_dich v391_3kat, add(42) rseed (10392) force

* Deskription Missings

mdesc id pb4_event ///
v158_inv v158 ///
v7 v8_m v192_abifh v391_3kat v398_dich v425_dich ///
pb2_event pb1_event

* Check II

reg v158_inv v391_3kat v398_dich v7 v8_m v192_abifh v425_dich

mi estimate: reg v158_inv v391_3kat v398_dich v7 v8_m v192_abifh v425_dich

*************************************************
*************************************************

* Gesamtprozesszeit "gt" generieren

gen gt = .

replace gt = 296-eb_beginn1

move gt eb_beginn1

tab gt if gt==.

* Provisorische Ereignisvariable fuer Erwerbsende "ee"

gen ee = 0

move ee eb_beginn1

tab ee

* STEST

mi stset gt, failure(ee=1) id(id)

* STSPLIT

mi stsplit T0, every(1)

* Partnerschaftsdauer zeitveraenderlich widergeben

rename pb_dauer pb_dauer_konstant

gen pb_dauer=.

move pb_dauer eb_beginn1

replace pb_dauer=gt-12

tab pb_dauer

replace pb_dauer=. if pb_dauer <= 0

* Variable gt korrigieren, um biographische Prozesszeit abzubilden

replace gt = gt+eb_beginn1-1

* Zeitabhaengige Variable fuer Befristung "eb_befr" generieren

gen eb_befr=0
gen eb_unbefr=0
gen eb_al=0
gen eb_bild=0
gen eb_sonst=0

move eb_befr eb_beginn1
move eb_unbefr eb_beginn1
move eb_al eb_beginn1
move eb_bild eb_beginn1
move eb_sonst eb_beginn1


*Aenderung Ingmar 28.04.2015: Folgendes als Schleife

forval i = 1/12 { 		// forval = forvalues / 1 bis 12 fuer die bis zu 12 erfragten Episoden

	replace eb_befr=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==1	
	replace eb_befr=. if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==9
	
	replace eb_unbefr=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==2
	replace eb_unbefr=. if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==9

	replace eb_al=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==3
	replace eb_al=. if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==9

	replace eb_bild=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & (eb_typ`i'==4 | eb_typ`i'==5 | eb_typ`i'==6 | eb_typ`i'==7)
	replace eb_bild=. if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==9

	replace eb_sonst=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==8
	replace eb_sonst=. if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==9

}


tab eb_befr
tab eb_unbefr
tab eb_al
tab eb_bild
tab eb_sonst

***********************************************************
***********************************************************

* Beginn Einschub Ingmar 28.04.2015: Befristungsstatus bei Partnerschaftsbeginn

sort id gt

*Befristet im ersten Partnerschaftsmonat (Dummy-Variable)
by id: gen eb_befr_pbeginn = eb_befr[13]
move eb_befr_pbeginn eb_befr

*Unbefristet im ersten Partnerschaftsmonat (Dummy-Variable)
by id: gen eb_unbefr_pbeginn = eb_unbefr[13]
move eb_unbefr_pbeginn eb_unbefr

*in Schule/Ausbildung im ersten Partnerschaftsmonat (Dummy-Variable)
by id: gen eb_bild_pbeginn = eb_bild[13]
move eb_bild_pbeginn eb_bild

*In Schule(=1), befristet (=2) oder unbefristet (=3) im ersten Partnerschaftsmonat
gen eb_bstat_pbeginn=.
move eb_bstat_pbeginn eb_befr_pbeginn

replace eb_bstat_pbeginn=1 if eb_bild_pbeginn==1
replace eb_bstat_pbeginn=2 if eb_befr_pbeginn==1
replace eb_bstat_pbeginn=3 if eb_unbefr_pbeginn==1


tab eb_befr_pbeginn
tab eb_unbefr_pbeginn
tab eb_bild_pbeginn
tab eb_bstat_pbeginn

* Ende Einschub Ingmar 28.04.2015: Befristungsstatus bei Partnerschaftsbeginn


***********************************************************

* Aufbereitung pb_dauer fuer Piecewise-Constant-Modell

* Generierung Dummy-Variablen fuer pb_dauer

* Gruppe 1: Partnerschaftsdauer 1 bis 12 Monate vs. alle anderen

gen pb_jahr1=.

move pb_jahr1 eb_beginn1

replace pb_jahr1=1 if pb_dauer >= 1 & pb_dauer <= 12
replace pb_jahr1=0 if pb_dauer > 12 & pb_dauer < 1000

* Gruppe 2: Partnerschaftsdauer 13 bis 24 Monate vs. alle anderen

gen pb_jahr2=.

move pb_jahr2 eb_beginn1

replace pb_jahr2=1 if pb_dauer >= 13 & pb_dauer <= 24
replace pb_jahr2=0 if pb_dauer < 13 | (pb_dauer > 24 & pb_dauer < 1000)

* Gruppe 3: Partnerschaftsdauer 25 bis 36 Monate vs. alle anderen

gen pb_jahr3=.

move pb_jahr3 eb_beginn1

replace pb_jahr3=1 if pb_dauer >= 25 & pb_dauer <= 36
replace pb_jahr3=0 if pb_dauer < 25 | (pb_dauer > 36 & pb_dauer < 1000)

* Gruppe 4: Partnerschaftsdauer 37 bis 48 Monate vs. alle anderen

gen pb_jahr4=.

move pb_jahr4 eb_beginn1

replace pb_jahr4=1 if pb_dauer >= 37 & pb_dauer <= 48
replace pb_jahr4=0 if pb_dauer < 37 | (pb_dauer > 48 & pb_dauer < 1000)

* Gruppe 5: Partnerschaftsdauer 49 bis 60 Monate vs. alle anderen

gen pb_jahr5=.

move pb_jahr5 eb_beginn1

replace pb_jahr5=1 if pb_dauer >= 49 & pb_dauer <= 60
replace pb_jahr5=0 if pb_dauer < 49 | (pb_dauer > 60 & pb_dauer < 1000)

* Gruppe 6: Partnerschaftsdauer 61 bis 72 Monate vs. alle anderen

gen pb_jahr6=.

move pb_jahr6 eb_beginn1

replace pb_jahr6=1 if pb_dauer >= 61 & pb_dauer <= 72
replace pb_jahr6=0 if pb_dauer < 61 | (pb_dauer > 72 & pb_dauer < 1000)

* Gruppe 7: Partnerschaftsdauer 73 bis 84 Monate vs. alle anderen

gen pb_jahr7=.

move pb_jahr7 eb_beginn1

replace pb_jahr7=1 if pb_dauer >= 73 & pb_dauer <= 84
replace pb_jahr7=0 if pb_dauer < 73 | (pb_dauer > 84 & pb_dauer < 1000)

* Gruppe 8: Partnerschaftsdauer 85 bis 96 Monate vs. alle anderen

gen pb_jahr8=.

move pb_jahr8 eb_beginn1

replace pb_jahr8=1 if pb_dauer >= 85 & pb_dauer <= 96
replace pb_jahr8=0 if pb_dauer < 85 | (pb_dauer > 96 & pb_dauer < 1000)

* Gruppe 9: Partnerschaftsdauer 97 bis 108 Monate vs. alle anderen

gen pb_jahr9=.

move pb_jahr9 eb_beginn1

replace pb_jahr9=1 if pb_dauer >= 97 & pb_dauer <= 108
replace pb_jahr9=0 if pb_dauer < 97 | (pb_dauer > 108 & pb_dauer < 1000)

* Gruppe 10: Partnerschaftsdauer 109 Monate oder mehr vs. alle anderen

gen pb_jahr10=.

move pb_jahr10 eb_beginn1

replace pb_jahr10=1 if pb_dauer >= 109 & pb_dauer <= 296
replace pb_jahr10=0 if pb_dauer < 109


***********************************************************

*Zusammengefasste Beziehungsdauergruppen - Gruppe 1

gen pb_2jahr1=0

move pb_2jahr1 pb_jahr1

replace pb_2jahr1=1 if pb_jahr1==1 | pb_jahr2==1

tab pb_jahr1 pb_jahr2

*Zusammengefasste Beziehungsdauergruppen - 2

gen pb_2jahr2=0

move pb_2jahr2 pb_jahr1

replace pb_2jahr2=1 if pb_jahr3==1 | pb_jahr4==1

tab pb_jahr3 pb_jahr4

*Zusammengefasste Beziehungsdauergruppen - 3

gen pb_2jahr3=0

move pb_2jahr3 pb_jahr1

replace pb_2jahr3=1 if pb_jahr5==1 | pb_jahr6==1

tab pb_jahr5 pb_jahr6

*Zusammengefasste Beziehungsdauergruppen - 4

gen pb_2jahr4=0

move pb_2jahr4 pb_jahr1

replace pb_2jahr4=1 if pb_jahr7==1 | pb_jahr8==1

tab pb_jahr7 pb_jahr8

*Zusammengefasste Beziehungsdauergruppen - 5

gen pb_2jahr5=.

move pb_2jahr5 pb_jahr1

replace pb_2jahr5=1 if pb_dauer >= 97 & pb_dauer <= 120
replace pb_2jahr5=0 if pb_dauer < 97 | (pb_dauer > 120 & pb_dauer < 1000)

*Zusammengefasste Beziehungsdauergruppen - Grupe 6: Rest

gen pb_2jahr6=.

move pb_2jahr6 pb_jahr1

replace pb_2jahr6=1 if pb_dauer >= 121 & pb_dauer <= 296
replace pb_2jahr6=0 if pb_dauer < 121

*Ueberpruefung

gen pb_2jahr_prÃ¼f=pb_2jahr1+pb_2jahr2+pb_2jahr3+pb_2jahr4+pb_2jahr5+pb_2jahr6

tab pb_2jahr_prÃ¼f
***********************************************************

* Episodenzeilen der 12 Monate vor Partnerschaftsbeginn löschen

drop if pb_dauer==.

***********************************************************

* Ueberfuehrung Variable Alter (v7) in zeitveraenderliche Variable

* Variablen sortieren

sort id gt

* Alter von jahresgenauer in monatsgenaue Messung ueberfueuhren

gen v7_monate=.
replace v7_monate=v7*12
move v7_monate v8

* Hilfsvariable maximale Partnerschaftsdauer berechnen

by id: gen pb_dauer_max = _N

list id gt pb_dauer_max pb_dauer pb_dauer_max

* Alter in Monaten fuer jede Episode berechnen

set more off

replace v7_monate=v7_monate-pb_dauer_max+pb_dauer

* Umrechnen zeitveraenderliche Altersvariable in Jahre

gen v7_jahre=v7_monate/12
move v7_jahre v7_monate

* Quadrierte zeitveraenderliche Altersvariable (in Jahren)

gen v7_jahre_q=v7_jahre*v7_jahre
move v7_jahre_q v7_monate

* Alter bei beginn der Partnerschaft

gen v7_pb_beginn=.

move v7_pb_beginn v8

replace v7_pb_beginn=(v7*12)-pb_dauer_max+1

***********************************************************
***********************************************************

* Missingwerte deklarieren für v398_dich und v192 und v216

replace v398_dich=. if v398_dich==7 | v398_dich==8 | v398_dich==9

replace v192=. if v192==8 | v192==9

replace v192_abifh=. if v192==8 | v192==9

replace v192_dich=. if v192==8 | v192==9

replace v192_dich=. if v192_dich==8 | v192_dich==9

replace v216=. if 192==8 | v192==9


***********************************************************
***********************************************************
***********************************************************

replace v216=. if 192==8 | v192==9

***********************************************************
***********************************************************

* Episodensplitting abgeschlossen

save "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Daten\Daten_AGIPEB_30-STATA_split.dta", replace