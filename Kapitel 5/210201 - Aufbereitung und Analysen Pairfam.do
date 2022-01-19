* Vergleiche mit Pairfam Wave 5 (2012/13)

* Hier: Partnerschaft, Kohabitation, Heirat (Fuer Kind verwende Datesatz "biochild")

clear

use "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Daten\biopart.dta"

* version 15

set more off

**********************************************************************

* Mergen mit Ankerdaten Wave 5, um Vergleichsstichprobe zu generieren

* Datensatz mit Daten zu Erwerbsstatus und Beziehungsstatus

merge m:1 id using "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Daten\anchor5.dta", keepusing(lfs relstat sat3 pa19i8 val1i3 pa11 frt7 job3)

drop if _merge==2
drop _merge

**********************************************************************

* Faelle auswahlen / Analysesample erstellen

* Ziel: Nur jene Personen in Sample, die...
* (a) bis 2012 befragt wurden
* (b) 18 bis 35 Jahre alt waren (2013)
* (c) abhaengig beschaeftigt waren
* (d) in einer festen Partnerschaft (verheiratet oder unverheiratet)

* zu (a)

foreach var of varlist wave6 wave7 wave8 wave9 wave10 wave11 {
	drop if `var'>5
}

* zu (b)
* --> orientieren an Kohorteneinteilung von Pairfam\Version11\Data\Stata\anchor5
* --> hier verwenden: Kohort (1) 1991-1993 und (2) 1981-1983

drop if cohort==3

* zu (c)
* nur Voll- oder Teilzeitbeschaeftige

drop if lfs<9 | lfs>10

* zu (d)
* --> Nur unverheiratete in Partnerschaften oder Verheiratete

drop if relstat<2 | relstat>5

**********************************************************************

* Mergen mit Datensatz mit Daten zu Geburt eines Kindes

merge m:m id using "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Daten\biochild.dta", keepusing(index dobk)

drop if _merge==2
drop _merge

**********************************************************************

* Aufbereiten: Befristung

gen job3_rek=.

replace job3_rek=1 if job3==1

replace job3_rek=0 if job3==2

* Aufbereiten: Partnerschaftsereignisse

* --> Lit: Bruederl et al. 2020: 58

* gen partner_month=month(dofm(relbeg-720))

* gen cohab_month=month(dofm(cohbeg-720))

* gen marriage_month=month(dofm(marbeg-720))

* Aufbereiten Dauer bis Ereignisrealisierung seit Partnerschaftsbeginn

gen cohab_dauer=cohbeg-relbeg

gen marriage_dauer=marbeg-relbeg

gen child_dauer=dobk-relbeg if index==1

tab cohab_dauer
tab marriage_dauer
tab child_dauer

replace cohab_dauer=. if cohab_dauer<1 | cohab_dauer==1298

replace marriage_dauer=. if marriage_dauer<1

replace child_dauer=. if child_dauer<1 | child_dauer>200

tab cohab_dauer
tab marriage_dauer
tab child_dauer

* Aufbereiten - Ereignis eingetreten

gen cohab_event=.

replace cohab_event=1 if cohab_dauer>0
replace cohab_event=0 if cohab_dauer==.

gen marriage_event=.

replace marriage_event=1 if marriage_dauer>0
replace marriage_event=0 if marriage_dauer==.

gen child_event=.

replace child_event=1 if child_dauer>0
replace child_event=0 if child_dauer==.

tab cohab_event
tab marriage_event
tab child_event

**********************************************************************

* Missings definieren

mvdecode _all, mv(-1 -2 -3 -4 -5 -6 -7 -8 -9 -11 -22 -33 -44 -55 -66 -77 -88 -99)

* Individuelle Zeit generieren

bysort id: gen id_time=_n

**********************************************************************

******************************

* Kap. 5.1.3
* TABELLE 8

******************************

* Deskriptive Analysen:

tab cohab_dauer
sum cohab_dauer, detail

tab marriage_dauer
sum marriage_dauer, detail

tab child_dauer
sum child_dauer, detail

tab cohab_event
sum cohab_event

tab marriage_event
sum marriage_event

tab child_event
sum child_event

* Kohortenvergleiche

tab cohab_event cohort, row col

tab marriage_event cohort, row col

tab child_event cohort, row col

**********************************************************************

******************************

* Kap. 5.1.3
* TABELLE 11

******************************

* Deskriptive Statistiken - Subjektive Partnerschaftseinstellungen

* Partnerschaftszufriedenheit

tab sat3
sum sat3

* z-Transformation fuer Vergleich mit AGIPEB 2012_13

egen sat3_z = std(sat3)

sum sat3_z, detail

* t-test (mit Befristung): Subjektive Partnerschaftszufriedenheit

robvar sat3, by(job3_rek) // Levene-Statistik --> W0

ttest sat3, by(job3_rek) // t-Test

* Subjektive Partnerschaftsstabilitaet

tab pa19i8
sum pa19i8

* z-Transformation fuer Vergleich mit AGIPEB 2012_13

egen pa19i8_z = std(pa19i8)

sum pa19i8_z, detail

* t-test (mit Befristung): Subjektive Partnerschaftsstabilitaet

robvar pa19i8, by(job3_rek) // Levene-Statistik --> W0

ttest pa19i8, by(job3_rek) // t-Test

* Geschlechterrollenbilder

* Invertieren

gen val1i3_inv=.

replace val1i3_inv=1 if val1i3==5
replace val1i3_inv=2 if val1i3==4
replace val1i3_inv=3 if val1i3==3
replace val1i3_inv=4 if val1i3==2
replace val1i3_inv=5 if val1i3==1

tab val1i3_inv
sum val1i3_inv

* z-Transformation fuer Vergleich mit AGIPEB 2012_13

egen val1i3_z = std(val1i3_inv)

sum val1i3_z, detail

* t-test (mit Befristung): Geschlechterrollenbilder

robvar val1i3_inv, by(job3_rek) // Levene-Statistik --> W0

ttest val1i3_inv, by(job3_rek) unequal // t-Test

* Heiratswunsch

* Invertieren:

gen pa11_inv=.

replace pa11_inv=1 if pa11==4
replace pa11_inv=2 if pa11==3
replace pa11_inv=3 if pa11==2
replace pa11_inv=4 if pa11==1

tab pa11_inv
sum pa11_inv

* z-Transformation fuer Vergleich mit AGIPEB 2012_13

egen pa11_z = std(pa11_inv)

sum pa11_z, detail

* t-test (mit Befristung): Heiratswunsch

robvar pa11_inv, by(job3_rek) // Levene-Statistik --> W0

ttest pa11_inv, by(job3_rek) unequal // t-Test

* Kinderwunsch

* Invertieren

gen frt7_inv=.

replace frt7_inv=1 if frt7==4
replace frt7_inv=2 if frt7==3
replace frt7_inv=3 if frt7==2
replace frt7_inv=4 if frt7==1

tab frt7_inv
sum frt7_inv

* z-Transformation fuer Vergleich mit AGIPEB 2012_13

egen frt7_z = std(frt7_inv)

sum frt7_z, detail

* t-test (mit Befristung): Kinderwunsch

robvar frt7_inv, by(job3_rek) // Levene-Statistik --> W0

ttest frt7_inv, by(job3_rek) unequal // t-Test

**********************************************************************

******************************

* Kap. 5.1.3
* TABELLE 8

******************************

* Stset + Deskription: Kohabitation

stset cohab_dauer, failure(cohab_event)

stdes if cohab_event==1
stsum if cohab_event==1

sts list

sts graph if cohab_dauer <= 100, /// restricting X-range to 0 till 100
fail /// graph starts at the bottom of the >-axis instead of the top
title("(a) Zusammenzug (n=245)") /// title
xtitle("Partnerschaftsdauer (Monate)") /// X-title
ytitle("Kumulierte Anteile realisierter Ereignisse") /// Y-title
xlabel(0 12 24 36 48 60 72 84 96) /// X-labels
ylabel(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%", angle(0)) // Y-labels

* Export graph

graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pairfam - zusammenzug - km_plot.png", replace width(2000)	// format: PNG (for manuscript)
graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pairfam - zusammenzug - km_plot.tif", replace width(2000)	// format: TIFF (for upload)

**********************************************************************

******************************

* Kap. 5.1.3
* TABELLE 8

******************************

* Stset + Deskription: Heirat

stset marriage_dauer, failure(marriage_event)

stdes if marriage_event==1
stsum if marriage_event==1

sts list

sts graph if marriage_dauer <= 100, /// restricting X-range to 0 till 100
fail /// graph starts at the bottom of the >-axis instead of the top
title("(b) Heirat (n=182)") /// title
xtitle("Partnerschaftsdauer (Monate)") /// X-title
ytitle("Kumulierte Anteile realisierter Ereignisse") /// Y-title
xlabel(0 12 24 36 48 60 72 84 96) /// X-labels
ylabel(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%", angle(0)) // Y-labels

* Export graph

graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pairfam - heirat - km_plot.png", replace width(2000)	// format: PNG (for manuscript)
graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pairfam - heirat - km_plot.tif", replace width(2000)	// format: TIFF (for upload)


**********************************************************************

******************************

* Kap. 5.1.3
* TABELLE 8

******************************

* Stset + Deskription: Geburt erstes Kind

stset child_dauer, failure(child_event)

stdes if child_event==1
stsum if child_event==1

sts list

sts graph if child_dauer <= 100, /// restricting X-range to 0 till 100
fail /// graph starts at the bottom of the >-axis instead of the top
title("(c) Erstes gemeinsames Kind (n=145)") /// title
xtitle("Partnerschaftsdauer (Monate)") /// X-title
ytitle("Kumulierte Anteile realisierter Ereignisse") /// Y-title
xlabel(0 12 24 36 48 60 72 84 96) /// X-labels
ylabel(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%", angle(0)) // Y-labels

* Export graph

graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pairfam - kind - km_plot.png", replace width(2000)	// format: PNG (for manuscript)
graph export "E:\Habilschrift\Analysen Kap5 - Methoden und Deskription\Stata Plots\pairfam - kind - km_plot.tif", replace width(2000)	// format: TIFF (for upload)

**********************************************************************
