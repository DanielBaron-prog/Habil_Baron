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

*replace v430proz=. if v430proz==-999

replace skala_bs=. if skala_bs==-999

replace skala_ssa=. if skala_ssa==-999

replace v77=. if v77==-999

replace v77=. if v77==99

replace v129=. if v129>1

replace v216=. if v216>5

replace v240=. if v240>8

replace v236=. if v236>2

gen v236_inv=.
replace v236_inv=1 if v236==1
replace v236_inv=0 if v236==2

replace v242=. if v242>80

replace v246=. if v246>2

replace v247=. if v247>2

gen v247_inv=.
replace v247_inv=1 if v247==1
replace v247_inv=0 if v247==2

gen v246_inv=.
replace v246_inv=1 if v246==1
replace v246_inv=0 if v246==2

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

* Angleichen Konfession an Allbus

gen v391_allbus=.

replace v391_allbus=1 if v391==2

replace v391_allbus=2 if v391==1

replace v391_allbus=3 if v391==5 | v391==6

replace v391_allbus=4 if v391==3 | v391==4 | v391==96

replace v391_allbus=5 if v391==97

gen v393_allbus=.	// Partnerdaten

replace v393_allbus=1 if v393==2

replace v393_allbus=2 if v393==1

replace v393_allbus=3 if v393==5 | v391==6

replace v393_allbus=4 if v393==3 | v391==4 | v391==96

replace v393_allbus=5 if v393==97

* Umkodieren Variablen Staatsangehoerigkeit

replace v425_dich=0 if v425_dich==1
replace v425_dich=1 if v425_dich==2

replace v426_dich=0 if v426_dich==1
replace v426_dich=1 if v426_dich==2
replace v426_dich=. if v426_dic>2

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

* Relative Anteile von Erwerbstypen korrigieren

replace v415=0 if v415==.
replace v415proz=0 if v415proz==.

replace v416=0 if v416==.
replace v416proz=0 if v416proz==.

replace v417=0 if v417==.
replace v417proz=0 if v417proz==.

replace v418=0 if v418==.
replace v418proz=0 if v418proz==.

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

*****************

* Erwerbsepisoden nach Personen:

*****************

* stset und Episodensplitting:

* Gesamtprozesszeit "gt" generieren

gen gt = .

replace gt = 296-eb_beginn1

move gt eb_beginn1

tab gt if gt==.

* Provisorische Ereignisvariable für Erwerbsende "ee"

gen ee = 0

move ee eb_beginn1

tab ee

* STSET

stset gt, failure(ee=1) id(id)

*****************

* Personenanzahl in Episoden: Befristet (eb´i'_5==1)

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==1 & eb`i'_5[_n+1]==.
}

* Personenhaeufigkeit: Befristet

disp (80+119+95+84+70+42+22+9+7+5)

* Relative Personenhaeufigkeit: Befristet

disp (80+119+95+84+70+42+22+9+7+5)/1083

***

* Kontrolle: Anzahl Personen, die befristet waren und vorher...

* ... unbefristet waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==1 & eb`i'_5[_n-1]==2 & eb`i'_1[_n+1]==.
}

* ... geringfuegig beschaeftigt waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==1 & eb`i'_12[_n-1]==1 & eb`i'_1[_n+1]==.
}

* ... in Leih- oder Zeitarbeit taetig waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==1 & eb`i'_3[_n-1]==1 & eb`i'_1[_n+1]==.
}

* ... in Kurzarbeit taetig waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==1 & eb`i'_4[_n-1]==1 & eb`i'_1[_n+1]==.
}

* ... arbeitslos waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==1 & eb`i'_1[_n-1]==2 & eb`i'_1[_n+1]==.
}

* ... in schulischer oder beruflicher Ausbildung waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==1 & eb`i'_1[_n-1]==3 & eb`i'_1[_n+1]==.
}

*****************

* Personenanzahl in Episoden: Unbefristet (eb´i'_5==2)

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==2 & eb`i'_5[_n+1]==.
}

* Personenhaeufigkeit: Unbefristet

disp (180+134+158+117+69+48+27+18+5+3)

* Relative Personenhaeufigkeit: Unbefristet

disp (180+134+158+117+69+48+27+18+5+3)/1083

***

* Kontrolle: Anzahl Personen, die unbefristet waren und vorher...

* ... befristet waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==2 & eb`i'_5[_n-1]==1 & eb`i'_1[_n+1]==.
}

* ... geringfuegig beschaeftigt waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==2 & eb`i'_12[_n-1]==1 & eb`i'_1[_n+1]==.
}

* ... in Leih- oder Zeitarbeit taetig waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==2 & eb`i'_3[_n-1]==1 & eb`i'_1[_n+1]==.
}

* ... in Kurzarbeit taetig waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==2 & eb`i'_4[_n-1]==1 & eb`i'_1[_n+1]==.
}

* ... arbeitslos waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==2 & eb`i'_1[_n-1]==2 & eb`i'_1[_n+1]==.
}

* ... in schulischer oder beruflicher Ausbildung waren:

forval i = 1/10 {
	tab eb`i'_5 if eb`i'_5==2 & eb`i'_1[_n-1]==3 & eb`i'_1[_n+1]==.
}

*****************

* Personenanzahl in Episoden: Geringfuegige Beschaeftigung (eb´i'_12==1)

forval i = 1/10 {
	tab eb`i'_12 if eb`i'_12==1 & eb`i'_12[_n+1]==.
}

* Personenhaeufigkeit: Geringefuegige Beschaeftigung

disp (2+3+6+13+3+2+2+1+1+1)

* Relative Personenhaeufigkeit: Geringefuegige Beschaeftigung

disp (2+3+6+13+3+2+2+1+1+1)/1083

*****************

* Personenanzahl in Episoden: Leih- oder Zeitarbeit (eb´i'_3==1)

forval i = 1/10 {
	tab eb`i'_3 if eb`i'_3==1  & eb`i'_3[_n+1]==.
}

* Personenhaeufigkeit: Leih- oder Zeitarbeit

disp (11+11+16+9+8+2+1+2)

* Relative Personenhaeufigkeit: Leih- oder Zeitarbeit

disp (11+11+16+9+8+2+1+2)/1083

*****************

* Personenanzahl in Episoden: Kurzarbeit (eb´i'_4==1)

forval i = 1/10 {
	tab eb`i'_4 if eb`i'_4==1  & eb`i'_4[_n+1]==.
}

* Personenhaeufigkeit: Kurzarbeit

disp (4+7+1+2+6+1+1)

* Relative Personenhaeufigkeit: Kurzarbeit

disp (4+7+1+2+6+1+1)/1083

*****************

* Personenanzahl in Episoden: Arbeitslosigkeit (eb´i'_1==2)

forval i = 1/10 {
	tab eb`i'_1 if eb`i'_1==2 & eb`i'_1[_n+1]==.
}

* Personenhaeufigkeit: Arbeitslosigkeit

disp (15+24+32+20+15+10+5+5+1)

* Relative Personenhaeufigkeit: Arbeitslosigkeit

disp (15+24+32+20+15+10+5+5+1)/1083

*****************

* Personenanzahl in Episoden: Schulische oder berufliche Ausbildung (eb´i'_1==3)

forval i = 1/10 {
	tab eb`i'_1 if eb`i'_1==3 & eb`i'_1[_n+1]==.
}

* Personenhaeufigkeit: Schulische oder berufliche Ausbildung

disp (48+38+24+15+13+3+4+1+2)

* Relative Personenhaeufigkeit: Schulische oder berufliche Ausbildung

disp (48+38+24+15+13+3+4+1+2)/1083

*****************

* Personenanzahl in Episoden: Sonstiges (eb´i'_1==3)

forval i = 1/10 {
	tab eb`i'_22 if eb`i'_22<7 & eb`i'_22[_n+1]==.
}

* Personenhaeufigkeit: Sonstiges

disp (32+70+45+31+21+7+5+5+3+1)

* Relative Personenhaeufigkeit: Sonstiges

disp (32+70+45+31+21+7+5+5+3+1)/1083

* Personenhaeufigkeit: Sonstiges - Kategorie Erziehungsurlaub

forval i = 1/10 {
	tab eb`i'_22 if eb`i'_22==2 & eb`i'_22[_n+1]==.
}

* Absolute und relative Haeufigkeit: Sonstiges - Kategorie Erziehungsurlaub

disp (9+30+27+21+14+6+3+5+2+1)

disp (9+30+27+21+14+6+3+5+2+1)/220

* Personenhaeufigkeit: Sonstiges - Kategorie Erziehungsurlaub, nach Geschlechtergruppen

forval i = 1/10 {
	tab v8  eb`i'_22 if eb`i'_22==2 & eb`i'_22[_n+1]==.
}

* Personenhaeufigkeit: Sonstiges - Kategorie Wehr- bzw. Zivildienst

forval i = 1/10 {
	tab eb`i'_22 if eb`i'_22==4 & eb`i'_22[_n+1]==.
}

* Absolute und relative Haeufigkeit: Sonstiges - Kategorie Wehr- bzw. Zivildienst

disp (21+21+4+3+1)

disp (21+21+4+3+1)/220

*****************

* Relative Erwerbsepisodenhaeufigkeiten (hierzu Episodensplitting erforderlich, s.u.)

* STSPLIT

stsplit T0, every(1)

*****************

*Änderung Ingmar 28.04.2015: Folgendes als Schleife

* Variable gt korrigieren, um biographische Prozesszeit abzubilden

replace gt = gt+eb_beginn1-1

gen eb_befr=0
gen eb_unbefr=0
gen eb_gering=0
gen eb_leih=0
gen eb_kurz=0
gen eb_al=0
gen eb_bild=0
gen eb_sonst=0

forval i = 1/12 { 		// forval = forvalues / 1 bis 12 für die bis zu 12 abgefragten Episoden

	replace eb_befr=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==1
	
	replace eb_unbefr=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==2

	replace eb_al=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==3

	replace eb_bild=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & (eb_typ`i'==4 | eb_typ`i'==5 | eb_typ`i'==6 | eb_typ`i'==7)

	replace eb_sonst=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb_typ`i'==8
}

forval i = 1/10 { 		// forval = forvalues / 1 bis 10 für die bis zu 12 abgefragten Episoden
	
	replace eb_gering=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb`i'_12==1
	
	replace eb_leih=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb`i'_3==1

	replace eb_kurz=1 if gt >= eb_beginn`i' & gt <= eb_ende`i' & eb`i'_4==1
}

* Relative Erwerbsepisodenhaeufigkeiten

tab eb_befr
tab eb_unbefr
tab eb_gering
tab eb_leih
tab eb_kurz
tab eb_al
tab eb_bild
tab eb_sonst

******************************

* Kap. 5.1.2
* TABELLE 1

******************************

* Finale Personenhaeufigkeit

* Gesamt:

stset gt, failure(ee=1) id(id)

stsum

* Befristung:

stset gt, failure(eb_befr=1) id(id)

stsum

disp 1083-531

disp 531/1083

disp 552/1083

* Unbefristet:

stset gt, failure(eb_unbefr=1) id(id)

stsum

disp 1083-755

disp 755/1083

disp 328/1083

* Geringfuegige Beschaeftigung:

stset gt, failure(eb_gering=1) id(id)

stsum

disp 1083-34

disp 34/1083

disp 1049/1083

* Leih- und Zeitarbeit:

stset gt, failure(eb_leih=1) id(id)

stsum

disp 1083-74

disp 74/1083

disp 1009/1083

* Kurzarbeit:

stset gt, failure(eb_kurz=1) id(id)

stsum

disp 1083-22

disp 22/1083

disp 1061/1083

* Arbeitsalosigkeit:

stset gt, failure(eb_al=1) id(id)

stsum

disp 1083-202

disp 202/1083

disp 881/1083

* Bildung:

stset gt, failure(eb_bild=1) id(id)

stsum

disp 1083-635

disp 635/1083

disp 448/1083

* Sonstige Episoden:

stset gt, failure(eb_sonst=1) id(id)

stsum

disp 1083-246

disp 246/1083

disp 837/1083

*****************

******************************

* Kap. 5.1.1
* Nicht dargestellt in Tabelle

******************************

* Objektive Erwerbs- und Sozialstrukturmerkmale

sum v163		// Einkommen (metrisch)

tab v164_ges	// Einkommen (kategorisiert)

tab v45_ges		// Wöchentliche Arbeitszeit
sum v45_ges

******************************

* Kap. 5.1.2
* TABELLE 2

******************************

tab v39_alle	// Berufliche Stellung

****

tab v192_dich v39_alle, col

******************************

* Kap. 5.1.2
* TABELLE 3

******************************

tab v49_code_1	// Berufsklassifikationen (ISCO 2008, Hauptgruppen)
tab v49_dich	// Berufsklassifikationen (dichotomisiert - Wissenschaft und Leitende vs. Andere)

******************************

* Kap. 5.1.2
* TABELLE 4
* TABELLE 5

******************************

* Subjektive Erwerbs- und soziooekonomische Situation (Einstellungen):

tab v77		// Subjektive Schichteinschätzung
sum v77, detail

* z-Transformation fuer Vergleich mit Allbus 2012

egen v77_z = std(v77)	// Standardisiert

sum v77_z, detail

*****

tab v191	// Zufriedenheit mit der finanzellen Lage des Haushalts
sum v191, detail

* z-Transformation fuer Vergleich mit Allbus 2012

egen v191_z = std(v191)	// Standardisiert

sum v191_z, detail

* z-Test, Vergleich mit Mittelwert aus Allbus 2012

ztest v191 == 3.474002, level(95)

*****

tab v16		// generelle Arbeitszufriedenheit
sum v16, detail

* z-Transformation fuer Vergleich mit Allbus 2012

egen v16_z = std(v16)	// Standardisiert

sum v16_z, detail

*****

tab v53		// Indikator fuer subjektive Sicherheit der Arbeitsstelle
sum v53, detail

egen v53_z = std(v53)

sum v53_z, detail

*****

tab v58		// Indikator berufliche Selbstwirksamkeit
sum v58, detail

egen v58_z = std(v58)

sum v58_z, detail

*****

tab v31	// Indikator für Befristungsbewertung
sum v31, detail

egen v31_z = std(v31)

sum v31_z, detail

*****

tab v78		// Politische Selbsteinschaetzung (Links-Rechts-Einschaetzung)
sum v78, detail

* z-Transformation fuer Vergleich mit Allbus 2012

egen v78_z = std(v78)	// Standardisiert

sum v78_z, detail

* z-Test, Vergleich mit Mittelwert aus Allbus 2012

ztest v78 == 5.037037, level(95)

*****

******************************

* Kap. 5.1.2
* TABELLE 6

******************************

* Konfessionszugehoerigkeit

tab v391_allbus

* Staatsangehoerigkeit

tab v425_dich

******************************

* Kap. 5.1.2
* TABELLE 7

******************************

* Partnerdaten

* Alter:

sum v9

* Geschlecht:

tab v10

* Hoechster Schulabschluss

tab v216

* Erwerbstaetigkeit:

tab v236_inv

* Berufliche Stellung:

tab v240

* Wochenarbeitszeit:

tab v242

sum v242

* Monatliches Nettoeinkommen:

sum v165

tab v166_ges

* Befristung:

tab v245

* Zeitarbeit:

tab v246_inv

* Kurzarbeit:

tab v247_inv

* Konfessionszugehoerigkeit:

tab v393_allbus

* Staatsangehoerigkeit:

tab v426_dich

* Sonstige Taetigkeiten

tab v249

* ANMERKUNG: Fuer detaillierte erwerbsbiographische Deskriptionen siehe entsprechenden Do File

*******************************************************************************************************

* Bivariate Deskriptionen (Abschnitt 5.2)

* Chi-Quadrat

******************************

* Kap. 5.2.1
* TABELLE 12

******************************

* Befristung und Geschlecht

tab v17 v8, row
tab v17 v8, col

phi v17 v8, row

phi v17 v8, col

******************************

* Kap. 5.2.1
* TABELLE 13

******************************

* Befristung und Bildung

tab v17 v192_dich, row
tab v17 v192_dich, col

phi v17 v192_dich, row

phi v17 v192_dich, col


* t-test

******************************

* Kap. ???
* TABELLE ???

******************************

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


	
*******************************************************************************************************
