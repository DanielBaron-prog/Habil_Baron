clear

use "E:\Habilschrift\Analysen Kap6_3 - Elternschaftsabsichten\Stata Daten\Daten_AGIPEB_30-STATA.dta"

set more off

* log using 180305-output.log, replace

*****************************
*
* Variablen im Datensatz:
*
* id

* KV:

* v7
* v8
* v17

* UV:
 
* v49_recode_2
* v49_dich
* v164_4kat

* KV:

* v192
* v192_dich

* UV:

* v413proz
* v414proz
* v415proz
* v430proz
* skala_bs
* skala_ssa
* v77 = Soziale Schichtselbsteinschätzung

* UV - Partnerdaten:

* v245 = PartnerIn aktuell befristet?
* v166_4kat = PartnerIn Einkommen
* v216_dich = PartnerIn höchster Schulbildungsabschluss
* pb2_1 = Kind geboren?
* pb1_1 = Verheiratet?

* AV:

* skala_spw3
* skala_spw
* v31
* v32
* v33
* v34

* renames

*****************************

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

*****************************

* Korrigieren: Anzahl gemeinsamer Kinder

replace v124=0 if v124==.

* Faelle ausschliessen, die bereits ein Kind haben in aktueller Beziehung

drop if v124>=1

******************************

* Faelle ausschließen, die Kinder aus frueheren Beziehungen haben

drop if v137==0	

******************************

* Aufbereitung Missings

replace v7=. if v7==-999

replace v8=. if v8==-999

replace v8=. if v8==-999

replace v17=. if v17==-999

replace v192_dich=. if v192_dich>2

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

*************************

* v53 invertieren

gen v35_inv=.

replace v35_inv=1 if v35==5
replace v35_inv=2 if v35==4
replace v35_inv=3 if v35==3
replace v35_inv=4 if v35==2
replace v35_inv=5 if v35==1

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

replace v49_recode_2=. if v49_recode_2==-999

replace v49_dich=. if v49_dich==-999
replace v49_dich=. if v49_dich==88

replace v129=. if v129==999

replace v164_4kat=. if v164_4kat==-999
replace v164_4kat=. if v164_4kat==98
replace v164_4kat=. if v164_4kat==99

replace v163=. if v163==999999
replace v163=. if v163==999998

replace v190=. if v190==8
replace v190=. if v190==9

replace v192=. if v192==-999

replace v192_dich=. if v192_dich==-999


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

******************************

* Einkommen in Tausend Euro:

gen v163_in_t=v163/1000

* Einkommen Partner in Tausend Euro:

gen v165_in_t=v165/1000

* Quadrierte Befristungserfahrungen

gen v413proz_q = v413proz*v413proz

******************************

* Erstellen Variable "Jemals befristet gewesen?" (v500)

*gen v500 = .

*replace v500 = 0 if v413==0
*replace v500 = 1 if v413>0
*replace v500 = -999 if v500==.

*label variable v500 "Jemals befristet gewesen?"

*label define lblname 0 "Nein" 1 "Ja"

*label values v500 lblname

*******************************************************************************************************

******************************

* Kap. 6.3.5
* TABELLE 27

******************************

* Deskriptive Statistiken / Stichprobenbeschreibung

* Frauen

estpost sum v129 v154 v70 v63_inv v17 v35_inv v163_in_t v190 v53 pb1_event v391_dummy v398_dich v192_dich v7 v124 if v8_m==0

esttab using "E:\Habilschrift\Analysen Kap6_3 - Elternschaftsabsichten\Stata Tabellen\Kap6_3_Descriptives_frauen.rtf", replace ///
title({Tabelle 1:} {Deskriptive Statistiken}) ///
nonumbers mtitles("MW Frauen") ///
varwidth(37) modelwidth(15) label alignment(c) b(3) onecell nostar ///
cell(mean(fmt(%9,2f)) sd(par)) ///
nonotes addnote("Anmerkungen: Standardabweichungen in Klammern." "Quelle: AGIPEB-Survey 2012/13.") legend ///
fonttbl(\f0\fnil arial; ) compress

eststo clear

* Maenner

estpost sum v129 v154 v70 v63_inv v17 v35_inv v163_in_t v190 v53 pb1_event v391_dummy v398_dich v192_dich v7 v124 if v8_m==1

esttab using "E:\Habilschrift\Analysen Kap6_3 - Elternschaftsabsichten\Stata Tabellen\Kap6_3_Descriptives_maenner.rtf", replace ///
title({Tabelle 1:} {Deskriptive Statistiken}) ///
nonumbers mtitles("MW Männer") ///
varwidth(37) modelwidth(15) label alignment(c) b(3) onecell nostar ///
cell(mean(fmt(%9,2f)) sd(par)) ///
nonotes addnote("Anmerkungen: Standardabweichungen in Klammern." "Quelle: AGIPEB-Survey 2012/13.") legend ///
fonttbl(\f0\fnil arial; ) compress

*******************************************************************************************************

* t-test

* robvar v63_inv ///
*	if !missing(v129, v17, v53, v163, v190, v154, v70, v63_inv, pb1_event, v398_dich, v192_dich v391_dummy, v35_inv, v7, v8) & v45>19, by(v17)


* ttest v63_inv ///
*	if !missing(v129, v17, v53, v163, v190, v154, v70, v63_inv, pb1_event, v398_dich, v192_dich v391_dummy, v35_inv, v7, v8) & v45>19, by(v17)

* n.n.
	
*******************************************************************************************************

* Skalen/Indikatoren zentrieren, quadrierte Terme berechnen 

* Mittelwertzentrierung v35_inv

gen v35_inv_zentr=v35_inv - 4.132057

sum v35_inv_zentr

* Mittelwertzentrierung v163

gen v163_zentr=v163_in_t - 1.767523

sum v163_zentr

* Mittelwertzentrierung v53

gen v53_zentr=v53 - 4.08413

sum v53_zentr

* Mittelwertzentrierung v190

gen v190_zentr=v190 - 3.74067

sum v190_zentr

* Mittelwertzentrierung v70

gen v70_zentr=v70 - 4.658071

sum v70_zentr

* Mittelwertzentrierung v63_inv

gen v63_inv_zentr=v63_inv - 4.514804

sum v63_inv_zentr

* Mittelwertzentrierung v7

gen v7_zentr=v7 - 30.83477

sum v7_zentr

* Mittelwertzentrierung v154

gen v154_zentr=v154 - 88.5717

sum v154_zentr

* Quadriertes Alter

gen v7_q=v7_zentr*v7_zentr

* Interaktion Bildung und Alter

gen v7_v192=.

replace v7_v192=v7*v192_dich

* Interaktion Wert Kinder und Familie*Befristungsbewertung

gen v70_zentr_v35_inv=.

replace v70_zentr_v35_inv=v70_zentr*v35_inv

*******************************************************************************************************

* Korrelationen

* pwcorr v35_inv v163_zentr v53_zentr v190_zentr v7 v154_zentr v398_dich, sig

* n.n.

*******************************************************************************************************

******************************

* Kap. 6.3.5
* ABBILDUNG 9

******************************

* Pfadmodell:

* Interpretationshilfen: https://stats.idre.ucla.edu/stata/faq/how-can-i-do-mediation-analysis-with-the-sem-command/

******************************

* Kap. 6.3.5
* ABBILDUNG 10
* TABELLE 28

******************************

* Gruppiert - Frauen und Maenner: 

eststo A: sem ///
(v154_zentr <- v17 v35_inv_zentr v163_zentr v190_zentr v53_zentr pb1_event v391_dummy v398_dich v192_dich v7) ///
(v129 <- v154_zentr v70_zentr v63_inv_zentr v17@0 v35_inv_zentr@0 v163_zentr@0 v190_zentr@0 v53_zentr@0 pb1_event v391_dummy v398_dich v192_dich v7), ///
method(mlmv) group(v8_m) stand

estat teffects, nototal compact stand

estadd beta

estat gof, stats(all)

estat ggof

* Freiheitsgrade des Modells:

disp e(df_s)-e(df_m)

disp e(df_ms)

esttab A using "E:\Habilschrift\Analysen Kap6_3 - Elternschaftsabsichten\Stata Tabellen\211012 - Elternschaftsabsichten.rtf", replace beta ///
title({Tabelle xy:} {Subjektive Befristungsbewertungen}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3" "Modell 4") ///
cells("beta (star fmt(%9.3f %9.0g) label(Koef.)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") eform starlevels(+ 0.10 * 0.05 ** 0.01) ///
stats(F p N, fmt(2 3 0) labels("F-Test" "Emp. Signif. F-Test" "n (Personenmonate)")) constant ///
nonotes addnote("Quelle: AGIPEB-Studie 2012/13. Gruppierte rekursive Pfadmodelle mit Full Information Maximum Likelihood Methode." ///
"Koef. = standardisierte Koeffizienten, SE = Standardfehler, p = empirische Signifikanz." ///
"** p < 0,01, * p < 0,05, + p < 0,10.") ///
fonttbl(\f0\fnil arial; ) compress nogaps

* Analysen fuer Fußnote / Chi-Quadrat-Differenztest zwischen restringiertem (berichtet, s.o) und weniger restriktiven Modell:

sem ///
(v154_zentr <- v17 v35_inv_zentr v163_zentr v190_zentr v53_zentr pb1_event v391_dummy v398_dich v192_dich v7) ///
(v129 <- v154_zentr v70_zentr v63_inv_zentr v17 v35_inv_zentr v163_zentr v190_zentr v53_zentr pb1_event v391_dummy v398_dich v192_dich v7), ///
method(mlmv) stand group(v8_m)

estat teffects, nodirect nototal compact standardized

estat gof, stats(all)

estat ggof

* Differenztests:

* Ch2-Diff. Frauen:

disp 12.137-2.247

* Ch2-Diff. Maenner:

disp 7.440-5.515

******

* Zusaetzliche Analysen

* Robuste CFI:

sem ///
(v154_zentr <- v17 v35_inv_zentr v163_zentr v190_zentr v53_zentr pb1_event v391_dummy v398_dich v192_dich v7) ///
(v129 <- v154_zentr v70_zentr v63_inv_zentr v17@0 v35_inv_zentr@0 v163_zentr@0 v190_zentr@0 v53_zentr@0 pb1_event v391_dummy v398_dich v192_dich v7), ///
stand vce(sbentler) group(v8_m)

estadd beta

estat teffects, nodirect nototal compact standardized

estat gof, stats(all)

* Modell ohne Kontrolle des Ehestatus

sem ///
(v154_zentr <- v17 v35_inv_zentr v163_zentr v190_zentr v53_zentr v391_dummy v398_dich v192_dich v7) ///
(v129 <- v154_zentr v70_zentr v63_inv_zentr v17@0 v35_inv_zentr@0 v163_zentr@0 v190_zentr@0 v53_zentr@0 v391_dummy v398_dich v192_dich v7), ///
method(mlmv) group(v8_m) stand

estat teffects, nototal compact stand

estadd beta

estat gof, stats(all)

estat ggof

*******************************************************************************************************

* Zusaetzliche Analysen:

reg v129 v154_zentr v70_zentr v63_inv_zentr, beta

reg v129 v154_zentr v70_zentr v63_inv_zentr v70_zentr_v35_inv pb1_event v391_dummy v398_dich v192_dich v8 v7 v7_q, beta

* Befristungserfahrungen als UV statt Befristungsstatus

eststo A: sem ///
(v154_zentr <- v413proz v35_inv_zentr v163_zentr v190_zentr v53_zentr pb1_event v391_dummy v398_dich v192_dich v7) ///
(v129 <- v154_zentr v70_zentr v63_inv_zentr v17@0 v35_inv_zentr@0 v163_zentr@0 v190_zentr@0 v53_zentr@0 pb1_event v391_dummy v398_dich v192_dich v7), ///
method(mlmv) group(v8_m) stand

estat teffects, nototal compact stand

estadd beta

estat gof, stats(all)

* Befristungserfahrungen quadriert als UV statt Befristungsstatus

eststo A: sem ///
(v154_zentr <- v413proz v413proz_q v35_inv_zentr v163_zentr v190_zentr v53_zentr pb1_event v391_dummy v398_dich v192_dich v7) ///
(v129 <- v154_zentr v70_zentr v63_inv_zentr v17@0 v35_inv_zentr@0 v163_zentr@0 v190_zentr@0 v53_zentr@0 pb1_event v391_dummy v398_dich v192_dich v7), ///
method(mlmv) group(v8_m) stand

estat teffects, nototal compact stand

estadd beta

estat gof, stats(all)