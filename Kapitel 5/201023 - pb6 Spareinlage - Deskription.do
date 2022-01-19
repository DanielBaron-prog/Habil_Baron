clear

use "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Daten\Daten_AGIPEB_30-STATA.dta"

set more off

* umbenennung der pb-Variablen in kleinschreibweise

rename pb1_1 pb1_event
rename pb2_1 pb2_event
rename pb3_urlaub_event pb3_event
rename pb4_haushalt_event pb4_event
rename pb5_kasse_event pb5_event
rename pb6_spareinlage_event pb6_event
rename pb7_auto_event pb7_event
rename pb8_immobilie_event pb8_event

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

*****************************

* Gleichgeschlechtliche Paare droppen

drop if v8==0 & v10==0
drop if v8==1 & v10==1

*****************************

* Faelle ausschliessen, die weniger als 20 Stunden pro Woche arbeiten

drop if v45<=19

******************************

* Einkommen in Tausend Euro:

gen v163_in_t=v163/1000

* Einkommen Partner in Tausend Euro:

gen v165_in_t=v165/1000

******************************

* Korrigieren: Anzahl gemeinsamer Kinder

replace v124=0 if v124==.

***********************************************************

* Gesamtprozesszeit "gt" generieren

gen gt = .

replace gt = 296-eb_beginn1

move gt eb_beginn1

tab gt if gt==.

* Provisorische Ereignisvariable für Erwerbsende "ee"

gen ee = 0

move ee eb_beginn1

tab ee

* STEST

stset gt, failure(ee=1) id(id)

* STSPLIT

stsplit T0, every(1)

* Partnerschaftsdauer zeitveränderlich widergeben

rename pb_dauer pb_dauer_konstant

gen pb_dauer=.

move pb_dauer eb_beginn1

replace pb_dauer=gt-12

tab pb_dauer

replace pb_dauer=. if pb_dauer <= 0

* Variable gt korrigieren, um biographische Prozesszeit abzubilden

replace gt = gt+eb_beginn1-1

* Zeitabhängige Variable für Befristung "eb_befr" generieren

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


*Änderung Ingmar 28.04.2015: Folgendes als Schleife

forval i = 1/12 { 		// forval = forvalues / 1 bis 12 für die bis zu 12 erfragten Episoden

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


* ErgÃ¤nzung 13. September Daniel

* Erstellung Gruppenvariable "Weniger als 6 Monate bis Entfristung vs. 6 oder mehr Monate bis Entfristung"

* Hilfsvariable, die Befristungsmonate kumuliert und zeitverÃ¤nderlich fÃ¼r jede Person gesondert zÃ¤hlt, die in Befristung ist

set more off

* Dann Variable bilden, die Missings in eb_befr_count abbildet (fÃ¼r spÃ¤tere Filterung)


*** ACHTUNG: Sortieren nach id und vor allem nach eb_befr, um Missings bei nicht-rechtszensierten Befristungsepisoden zu vermeiden!

sort id eb_befr gt 

by id eb_befr, sort: gen eb_befr_count=_n if eb_befr==1 & _n!=.

* list id eb_befr gt eb_befr_count


* Monate personenspezifisch kumulieren

by id, sort: gen eb_befr_monate_pers_kum=eb_befr_count[_N] if eb_befr==1

sort id eb_befr_count

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_befr_count eb_befr_monate_pers_kum


* Variable fÃ¼r Dauer bis Episodenwechsel

gen eb_ep_wechs_dauer= eb_befr_monate_pers_kum-eb_befr_count

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_befr_count eb_befr_monate_pers_kum eb_ep_wechs_dauer

* Korrigieren der Variable fÃ¼r Dauer bis Episodenwechsel um letzten Monat vor Wechsel

replace eb_ep_wechs_dauer=eb_ep_wechs_dauer+1

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_befr_count eb_befr_monate_pers_kum eb_ep_wechs_dauer


* Variable Befristungsdauergruppe erstellen

gen eb_befr_monate=.

replace eb_befr_monate=0 if eb_ep_wechs_dauer<6

replace eb_befr_monate=1 if eb_ep_wechs_dauer>=6

replace eb_befr_monate=. if eb_ep_wechs_dauer==.

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_befr_count eb_befr_monate_pers_kum eb_ep_wechs_dauer eb_befr_monate

* Grundlegende Datenaufbereitung bzw. Reshape abgeschlossen

***********************************************************
***********************************************************

* Überführung Variable Alter (v7) in zeitveränderliche Variable

* Variablen sortieren

sort id gt

* Alter von jahresgenauer in monatsgenaue Messung überführen

gen v7_monate=.
replace v7_monate=v7*12
move v7_monate v8

* Hilfsvariable maximale Partnerschaftsdauer berechnen

gen pb_dauer_max=.

move pb_dauer_max v8

by id, sort: replace pb_dauer_max = pb_dauer[_N]

* Alter in Monaten für jede Episode berechnen

replace v7_monate=v7_monate-pb_dauer_max+pb_dauer

* Umrechnen zeitveränderliche Altersvariable in Jahre

gen v7_jahre=v7_monate/12
move v7_jahre v7_monate

* Quadrierte zeitveränderliche Altersvariable (in Jahren)

gen v7_jahre_q=v7_jahre*v7_jahre
move v7_jahre_q v7_monate

* Alter bei beginn der Partnerschaft

gen v7_pb_beginn=.

move v7_pb_beginn v8

replace v7_pb_beginn=(v7*12)-pb_dauer_max+1

***********************************************************
***********************************************************

* Zeitveränderliche Variablen erstellen zur Widergabe kumulierter relativer Häufigkeiten der jeweiligen eb-typen in Biographien

* Zeitveränderliche Variable "Befristungsanteile" in eb generieren ("eb_befr_rel")#

gen eb_befr_rel=0

move eb_befr_rel eb_unbefr

* Hilfsvariable zur Aufsummierung der Befristungsepisoden für jede Person ("eb_befr_cum)

gen eb_befr_cum=0
move eb_befr_cum eb_unbefr

by id, sort: replace eb_befr_cum=sum(eb_befr)

* Hilfsvariable generieren, die die gesamte abgefragte Beiographiezeit (pb_dauer+12 Monate) widergibt ("beob_dauer")

gen beob_dauer=0

move beob_dauer eb_befr

by id, sort: replace beob_dauer=_n

* Jetzt zeitveränderliche Befristungsanteile für eb_befr_rel berechnen

replace eb_befr_rel=eb_befr_cum/beob_dauer

*tab eb_befr_rel

* in Prozent:

gen eb_befr_proz=eb_befr_rel*100

*Relative Befristungsanteile (Prozent) quadrieren:

gen eb_befr_proz_q=eb_befr_proz*eb_befr_proz

* 2016ergänzt: Jetzt zeitveränderliche Variable "jemals befristet" bilden;
gen eb_befr_je=0

move eb_befr_je eb_befr_rel

replace eb_befr_je = 1 if eb_befr_rel > 0

tab eb_befr_je

***************

* Zeitveränderliche Variable "Unbefristungsanteile" in eb generieren ("eb_unbefr_rel")

gen eb_unbefr_rel=0

move eb_unbefr_rel eb_al

* Hilfsvariable zur Aufsummierung der Unbefristungsepisoden für jede Person ("eb_unbefr_cum)

gen eb_unbefr_cum=0
move eb_unbefr_cum eb_al

by id, sort: replace eb_unbefr_cum=sum(eb_unbefr)

* Jetzt zeitveränderliche Unbefristungsanteile für eb_unbefr_rel berechnen

replace eb_unbefr_rel=eb_unbefr_cum/beob_dauer

*tab eb_unbefr_rel

***************

* Zeitveränderliche Variable "Arbeitslosgikeitsanteile" in eb generieren ("eb_al_rel")

gen eb_al_rel=0

move eb_al_rel eb_bild

* Hilfsvariable zur Aufsummierung der Arbeitslosgikeitsepisoden für jede Person ("eb_al_cum)

gen eb_al_cum=0
move eb_al_cum eb_bild

by id, sort: replace eb_al_cum=sum(eb_al)

* Jetzt zeitveränderliche Arbeitslosgikeitsanteile für eb_al_rel berechnen

replace eb_al_rel=eb_al_cum/beob_dauer

*tab eb_al_rel


* 2016ergänzt: Jetzt zeitveränderliche Variable "jemals arbeitslos" bilden;
gen eb_al_je=0

move eb_al_je eb_al_rel

replace eb_al_je = 1 if eb_al_rel > 0

tab eb_al_je

***************

* Zeitveränderliche Variable "Bildungsanteile" in eb generieren ("eb_bild_rel")

gen eb_bild_rel=0

move eb_bild_rel eb_sonst

* Hilfsvariable zur Aufsummierung der Bildungsepisoden für jede Person ("eb_bild_cum)

gen eb_bild_cum=0
move eb_bild_cum eb_sonst

by id, sort: replace eb_bild_cum=sum(eb_bild)

* Jetzt zeitveränderliche Bildungsanteile für eb_bild_rel berechnen

replace eb_bild_rel=eb_bild_cum/beob_dauer

*tab eb_bild_rel

***************

* Zeitveränderliche Variable "Sonstigesanteile" in eb generieren ("eb_sonst_rel")

gen eb_sonst_rel=0

* Hilfsvariable zur Aufsummierung der Sonstigesepisoden für jede Person ("eb_sonst_cum)

gen eb_sonst_cum=0

by id, sort: replace eb_sonst_cum=sum(eb_sonst)

* Jetzt zeitveränderliche Sonstigesanteile für eb_sonst_rel berechnen

replace eb_sonst_rel=eb_sonst_cum/beob_dauer

*tab eb_sonst_rel

***********************************************************
***********************************************************
* Spezielle Datenaufbereitung für Beispiel "Entscheidung Spareinlage (= pb6)"

* Variable "pb6_fail" generieren, die den Eintritt des Ereignises widergibt

gen pb6_fail = 0

move pb6_fail eb_beginn1

replace pb6_fail = 1 if pb_dauer==pb6_risktime & pb6_event==1

drop if pb6_event==1 & pb_dauer>pb6_risktime

tab pb6_fail if pb6_fail==1

***********************************************************
* Vorbereiten erneutes STSET

* Neue Variablen für Episodenstart- und -endzeitpunkte generieren / umbenennen

gen pb_end=pb_dauer
move pb_end pb_dauer

gen pb_start=pb_end-1
move pb_start pb_end

* Alte STSET-Variablen löschen

drop _st
drop _d
drop _t
drop _t0
drop T0

* Hilfsvariablen entfernen

drop gt
drop ee

* Variable "pb_zeit" für Prozesszeit bilden

gen pb_zeit=pb_end-pb_start
move pb_zeit pb_dauer

tab pb_zeit

* Episodenzeilen der 12 Monate vor Partnerschaftsbeginn löschen (für Personen, die kein Ereignis berichten)

drop if pb_dauer==.

***********************************************************

* Erneutes STSET

stset pb_end, id(id) time0(pb_start) origin(time pb_start) failure(pb6_fail==1)

sort id pb_dauer

***********************************************************
***********************************************************

* Episoden fÃ¼r Arbeitslosigkeit und Sonstiges auf Missing setzen

* replace eb_befr=. if eb_al==1
* replace eb_unbefr=. if eb_al==1
* replace eb_bild=. if eb_al==1

* replace eb_befr=. if eb_sonst==1
* replace eb_unbefr=. if eb_sonst==1
* replace eb_bild=. if eb_sonst==1

***********************************************************

* Erweiterte Modell fÃ¼r Ãœberarbeitung ZFF

* Erstellen PLZ-gestÃ¼tzte Ost-West-Variable

destring plz, generate(plz_num)

gen v398plz=.

replace v398plz=1 if plz_num>00001 & plz_num<20000
replace v398plz=0 if plz_num>19999

tab v398plz
tab plz

* Invertieren Variable StaatsangehÃ¶rigkeit

gen v425_dich_inv=.

replace v425_dich_inv=1 if v425_dich==1
replace v425_dich_inv=0 if v425_dich==2

tab v425_dich_inv v425_dich

***********************************************************

* Mediandauer bis Realisierung Gemeinsame Spareinlage

sum pb_dauer if pb6_event==1, detail

***********************************************************

* Deskriptive Statistiken

stsum if pb6_event==1
stdes if pb6_event==1

* Anteil realisierter Ereignisse:

disp 1083-291

disp 291/1083

disp 792/1083

* KM-Schaetzer

sts list

* Customize for publication

set scheme s1mono /// alternate colour scheme (another option: s1color)

sts graph if pb_dauer <= 180 & pb6_event==1, 						/// restricting X-range to 0 till 180
fail 																/// graph starts at the bottom of the >-axis instead of the top
title("(d) Gemeinsame Spareinlage (291)") 							/// title
xtitle("Partnerschaftsdauer (Monate)") 								/// X-title
ytitle("Kumulierte Anteile realisierter Ereignisse") 				/// Y-title
xlabel(0 12 24 36 48 60 72 84 96 108 120 132 144 156 168 180) 		/// X-labels
ylabel(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%", angle(0)) 		// Y-labels

* Export graph

graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pb6 - spareinlage - km_plot.png", replace width(2000)	// format: PNG (for manuscript)
graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pb6 - spareinlage - km_plot.tif", replace width(2000)	// format: TIFF (for upload)

***********************************************************

* Log-rank-test (emphasis on later failure times)

sts test v17, logrank														// Lit.: Cleves et al. 2010: 122ff.

* Wilcoxon test (emphasis on earlier failure times)

sts test v17, wilcoxon

* Plot:

set scheme s1mono /// alternate colour scheme (another option: s1color)

sts graph if pb_dauer <= 180, 												/// restricting X-range to 0 till 180
by(v17)																		/// comparing "befristet" to "unbefristet"
fail 																		/// graph starts at the bottom of the >-axis instead of the top
title("(d) Gemeinsame Spareinlage  (291)") 									/// title
xtitle("Partnerschaftsdauer (Monate)") 										/// X-title
ytitle("Kumulierte Anteile realisierter Ereignisse") 						/// Y-title
xlabel(0 12 24 36 48 60 72 84 96 108 120 132 144 156 168 180) 				/// X-labels
ylabel(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%", angle(0)) 				/// Y-labels
plot1(lpattern(solid)lcolor(black))											///
plot2(lpattern(dash)lcolor(black))											///
legend(label(1 Unbefristet (253)) label(2 Befristet (38); Log-rank: 2,13))	// Label legend

* Export graph

graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pb6 - spareinlage - km_plot + logrank.png", replace width(2000)	// format: PNG (for manuscript)
graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pb6 - spareinlage - km_plot + logrank.tif", replace width(2000)	// format: TIFF (for upload)