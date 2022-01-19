clear

use "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Stata Daten\Daten_AGIPEB_30-STATA.dta"

* version 16

set more off

* log using 180305-output.log, replace

sort id

*****************************
*
* Variablen im Datensatz:
*
* id

* AV:

* skala_spw3
* Items: v31 v32 v33 bzw. invertiert: v31_inv v32_inv v33_inv

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

* Weitere Missings

replace v22=. if v22>5

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

replace v163=. if v163==999999
replace v163=. if v163==999998

replace v192=. if v192==-999

replace v192_dich=. if v192_dich>1


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

* Befristungsbewertung (Items) invertieren

* Recode-Loop (vgl. Scott 2011: 98f.)

local recodevars "v31 v32 v33 v34 v35"

foreach varname of varlist `recodevars' {
generate `varname'_inv = .
replace `varname'_inv = 1 if `varname' == 5
replace `varname'_inv = 2 if `varname' == 4
replace `varname'_inv = 3 if `varname' == 3
replace `varname'_inv = 4 if `varname' == 2
replace `varname'_inv = 5 if `varname' == 1
}

* Variablenlabels

lab var v31_inv "Befristung macht viele Entscheidungen im Privaten unmoeglich (invertiert)"

lab var v32_inv "Befristung erfordert besondere Vorsicht in finanz. Hinsicht (invertiert)"

lab var v33_inv "Befristung vermindert Lebenszufriedenheit und Lebensqualitaet (invertiert)"

lab var v34_inv "Bei Befristung keine Kinder leisten koennen (invertiert)"

lab var v35_inv "Bei Befristung Zukunftsplanung in Beziehung kaum moeglich (invertiert)"

* Wertelabels

lab define v31_inv_lab 1 "1 = Trifft voll und ganz zu" 2 "2 = Trifft zu" 3 "Teils, teils" 4 "4 = Trifft nicht zu" 5 "5 = Trifft ueberhaupt nicht zu"

lab val v31_inv v32_inv v33_inv v34_inv v35_inv v31_inv_lab

* Kontrolle

tab v31 v31_inv
tab v32 v32_inv
tab v33 v33_inv
tab v34 v34_inv
tab v35 v35_inv


*******************************************************************************************************

* Abschnitt 6.1: Validitaets- und Reliabilitaetsanalysen

*******************************************************************************************************

******************************

* Kap. 6.1.4
* TABELLE 17 --> neu erstellen (neue Missing beruecksichtigen)

******************************

* Deskriptive Statistiken / Stichprobenbeschreibung

sum v31_inv v32_inv v33_inv v34_inv v53 v56 v57 v62 v63_inv v64_inv 

* Haeufigkeiten

tab v31_inv

tab v32_inv

tab v33_inv

tab v34_inv

tab v53

tab v56

tab v57

tab v62

tab v63_inv

tab v64_inv

* UNBEFRISTETE: Deskriptive Statistiken / Stichprobenbeschreibung

sum v31_inv v32_inv v33_inv v34_inv v53 v56 v57 v62 v63_inv v64_inv if v17==0

* BEFRISTETE: Deskriptive Statistiken / Stichprobenbeschreibung

sum v31_inv v32_inv v33_inv v34_inv v53 v56 v57 v62 v63_inv v64_inv if v17==1

* FRAUEN: Deskriptive Statistiken / Stichprobenbeschreibung

sum v31_inv v32_inv v33_inv v34_inv v53 v56 v57 v62 v63_inv v64_inv if v8_m==0

* MAENNER: Deskriptive Statistiken / Stichprobenbeschreibung

sum v31_inv v32_inv v33_inv v34_inv v53 v56 v57 v62 v63_inv v64_inv if v8_m==1

*******************************************************************************************************

* t-test: UNBEFRISTETE vs. BEFRISTETE

robvar v31_inv , by(v17)

ttest v31_inv, by(v17)

robvar v32_inv, by(v17)

ttest v32_inv, by(v17)

robvar v33_inv, by(v17)

ttest v33_inv, by(v17) unequal

robvar v34_inv, by(v17)

ttest v34_inv, by(v17) unequal

robvar v53 , by(v17)

ttest v53, by(v17)

robvar v56, by(v17)

ttest v56, by(v17)

robvar v57, by(v17)

ttest v57, by(v17)

robvar v62, by(v17)

ttest v62, by(v17)

robvar v63_inv, by(v17)

ttest v63_inv, by(v17) unequal

robvar v64_inv, by(v17)

ttest v64_inv, by(v17) unequal

* t-test: FRAUEN vs. MAENNER

robvar v31_inv , by(v8_m)

ttest v31_inv, by(v8_m)

robvar v32_inv, by(v8_m)

ttest v32_inv, by(v8_m) unequal

robvar v33_inv, by(v8_m)

ttest v33_inv, by(v8_m) unequal

robvar v34_inv, by(v8_m)

ttest v34_inv, by(v8_m)

robvar v53 , by(v8_m)

ttest v53, by(v8_m)

robvar v56, by(v8_m)

ttest v56, by(v8_m)

robvar v57, by(v8_m)

ttest v57, by(v8_m) unequal

robvar v62, by(v8_m)

ttest v62, by(v8_m) unequal

robvar v63_inv, by(v8_m)

ttest v63_inv, by(v8_m) unequal

robvar v64_inv, by(v8_m)

ttest v64_inv, by(v8_m) unequal

*******************************************************************************************************

******************************

* Kap. 6.1.4
* TABELLE 18 --> neu erstellen

******************************

* Hauptkomponentenanalysen
* Anzahl der Faktoren ueberpruefen fuer den Gruppenvergleich (Ender 2013)

* Alle:

pca v31_inv v32_inv v33_inv v34_inv v53 v56 v57 v62 v63_inv v64_inv

* Gruppiert:

* Befristete:

pca v31_inv v32_inv v33_inv v34_inv v53 v56 v57 v62 v63_inv v64_inv if v17==1

* Unbefristete:

pca v31_inv v32_inv v33_inv v34_inv v53 v56 v57 v62 v63_inv v64_inv if v17==0

******************************

* Kap. 6.1.4
* TABELLE 19 --> neu erstellen

******************************

* EFA - Subjektive Prekaritätsbelastung + Subjektive Sicherheit der Arbeitsstelle

factor (v31_inv v32_inv v33_inv v34_inv) (v53 v56 v57) (v62 v63_inv v64_inv), ///
ml factor(3)

rotate, varimax horst

* Cronbach's Alpha - Skala_SPW3

alpha (v31_inv v32_inv v33_inv v34_inv)

* Cronbach's Alpha - Skala_SSA

alpha (v53 v56 v57)

* Cronbach's Alpha - Skala_bs

alpha (v62 v63_inv v64_inv)


*******************************************************************************************************

* Einschub 30.3.21

* Konfirmatatorische Faktorenanalsen und Tests auf Messinvarianzen (2 Gruppen: Befristet, Unbefristet)

* Verwenden der bhhh-Maximisierungstechnik (Berndt–Hall–Hall–Hausman Algorithm)
* Quellen: Berndt et al. 1974; Eliason 1993: 42-45; Stata SEM-Manual: S. 574; Braudt o. J.: 1

******************************

* Kap. 6.1.4
* TABELLE 20 --> neu erstellen

******************************

* Ausgangsmodell:

* (0a) Nicht gruppiertes Modell (v17)

*******

sem (SBB -> v31_inv v32_inv v33_inv v34_inv) (SSA -> v53 v56 v57) (BS -> v62 v63_inv v64_inv), ///
method(mlmv) technique(nr 5 bhhh 5)

estat gof, stats(all)

matrix b=e(b)

*******

* (0b) Gruppiertes Modell (v17) - inlk. FIML

*******

sem (SBB -> v31_inv v32_inv v33_inv v34_inv) (SSA -> v53 v56 v57) (BS -> v62 v63_inv v64_inv), ///
group(v17) method(mlmv)

estat gof, stats(all)

estat mindices

*******
*******

******************************

* Kap. 6.1.4
* TABELLE 21 --> neu erstellen

* --> orientieren an Van de Schoot et al. 2012

******************************

* Tests auf Messinvarianzen

* Doku:

* How Can I Check Measurement Invariance Using the SEM Command? UCLA: Statistical Consulting Group. 
* from https://stats.idre.ucla.edu/stata/faq/how-can-i-check-measurement-invariance-using-the-sem-command-stata-12/ (accessed March 30, 2021)

* Quellen: Reinecke 2014: 143ff.; Van De Schoot et al. 2012

* Verwenden der bhhh-Maximisierungstechnik (Berndt–Hall–Hall–Hausman Algorithm)
* Quellen: Berndt et al. 1974; Eliason 1993: 42-45; Stata SEM-Manual: S. 574; Braudt o. J.: 1

* Achtung: Keine SD fuer (geschaetzte) MW (Nagele 2003)

*******

* (1) Gruppierte CFA - Alle Parameter freisetzen (BHHH-Alghorithmus)

*******

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v17) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(none) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

*******

* (2) Gruppierte CFA - Metrische Invarianz, Faktorladungen invariant (BHHH-Alghorithmus)

*******

sem (SBB -> v31_inv v32_inv v33_inv v34_inv) (SSA -> v53 v56 v57) (BS -> v62 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v17) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Chi-Quadrat-Differenztest:

* 1-[chi2((df Model2 - df Model1),(Chi2 Model2 - Chi2 Model1))]

disp 1-[chi2((71-64),(146.56-137.96))]

disp 146.56-137.96

*******

* (3) Gruppierte CFA - Skalare Invarianz, Faktorladungen und Itemintercepts invariant (BHHH-Alghorithmus)

*******

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v17) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef mcons) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Chi-Quadrat-Differenztest:

* 1-[chi2((df Model3 - df Model2),(Chi2 Model3 - Chi2 Model2))]

disp 1-[chi2((78-71),(187.58-146.56))]

disp 187.58-146.56

*******

* (4) Gruppierte CFA - Strikte faktorielle Invarianz, Faktorladungen, Itemintercepts und Residuen invariant (BHHH-Alghorithmus)

*******

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v17) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef mcons merrvar) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Chi-Quadrat-Differenztest:

* 1-[chi2((df Model4 - df Model3),(Chi2 Model4 - Chi2 Model3))]

disp 1-[chi2((88-78),(234.42-187.58))]

disp 234.42-187.58

*******

* (5) Gruppierte CFA - Strikte Messfehlerinvarianz inkl. gleichen Faktormittelwerten (BHHH-Alghorithmus)

*******

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v17) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef mcons merrvar meanex) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Chi-Quadrat-Differenztest:

* 1-[chi2((df Model5 - df Model4),(Chi2 Model5 - Chi2 Model4))]

disp 1-[chi2((91-88),(392.56-234.42))]

disp 392.56-234.42

*******

* (6) Gruppierte CFA - Strikte Messfehlerinvarianz inkl. gleichen Faktormittelwerten und -varianzen (BHHH-Alghorithmus)
* Kriterium gemaess UCLA-Doku (s. oben fuer Quelle)

*******

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v17) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef mcons merrvar meanex covex) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Chi-Quadrat-Differenztest:

* 1-[chi2((df Model6 - df Model5),(Chi2 Model6 - Chi2 Model5))]

disp 1-[chi2((97-91),(522.81-392.56))]

disp 522.81-392.56

**********************************************************

* Analysemodell, dass sich als messinvariant mit hoechstem Informationsgehalt erwies:

* Vgl. Reineke 2014: 143ff., 162-168

* (2) Gruppierte CFA - Metrische Invarianz, Faktorladungen invariant (BHHH-Alghorithmus)

* Achtung: Hier werden Varianzen der latenten Faktoren auf 1 restringiert, um Korrelationen zwischen latenten Faktoren zu erhalten

* Unstandardisierte Koeffizienten

*******

sem (SBB -> v31_inv v32_inv v33_inv v34_inv) (SSA -> v53 v56 v57) (BS -> v62 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v17) mean(SBB) mean(SSA) mean(BS) ///
var(SBB@1) var(SSA@1) var(BS@1) ///
method(mlmv) ginvariant(mcoef) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

**********************************************************

* Additive Indices bilden (fuer Vergleiche)

* Subjektive Befristungsbewertungen

gen skala_sbb=.

replace skala_sbb=(v31_inv+v32_inv+v33_inv+v34_inv)/4

* Subjektive Sicherheit der Arbeitsstelle (Kurzskala)

gen skala_ssa_kurz=.

replace skala_ssa_kurz=(v53+v56+v57)/3

* Berufliche Selbstwirksamkeitsueberzeugungen (Kurzskala)

gen skala_bs_kurz=.

replace skala_bs_kurz=(v62+v63_inv+v64_inv)/3

* Deskriptionen

sum skala_sbb skala_ssa_kurz skala_bs_kurz ///
if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

tab skala_sbb if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

tab skala_ssa_kurz if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

tab skala_bs_kurz if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

*******************************************************************************************************

* Multivariate Analysen / SEM

******************************

* Kap. 6.1.4
* TABELLE 23  --> neu erstellen (inkl. FIML, angepasste n)

******************************

* Deskriptive Statistiken / Stichprobenbeschreibung

sum skala_sbb v31_inv v32_inv v33_inv v34_inv v17 v78 v8_m

sum skala_sbb v31_inv v32_inv v33_inv v34_inv v17 v78 v8_m ///
if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

* Haeufigkeiten

tab v31_inv if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

tab v32_inv if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

tab v33_inv if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

tab v34_inv if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

tab v17 if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

tab v78 if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

tab v8_m if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

robvar v78, by(v17)

ttest v78, by(v17) unequal
	
*******************************************************************************************************

* Skalen/Indikatoren zentrieren

gen v31_zentr=v31-2.243786 ///
if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

gen v32_zentr=v32-2.077512 ///
if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

gen v33_zentr=v33-2.581016 ///
if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

gen v34_zentr=v33-3.434741 ///
if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

sum v31_zentr v32_zentr v33_zentr v34_zentr ///
if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m)

* Mittelwertzentrierung v78

gen v78_zentr=v78 - 4.653122

sum v78_zentr

*******************************************************************************************************

* Interaktion generieren

gen v17_x_v78=v17*v78_zentr

sum v17_x_v78

*******************************************************************************************************

* Korrelationen

pwcorr v31_inv v32_inv v33_inv v34_inv v17 v78_zentr v8 ///
if !missing(v31_inv, v32_inv, v33_inv, v34_inv, v17, v78, v8_m), sig

*******************************************************************************************************

* SEM

******************************
******************************

* Kap. 6.1.5
* ABBILDUNG 7 --> neu erstellen (inkl. FIML, abgepasste n)

******************************
******************************

* Multigruppen-SEM (Frauen, Maenner)

* Ausgangsmodell:

sem (SBB -> v31_inv v32_inv v33_inv v34_inv) ///
(v17 v78_zentr v17_x_v78 -> SBB), ///
group(v8_m) method(mlmv)

estat gof, stats(all)

***

* Test auf Messinvarianzen fuer Gruppenvergleich Frauen, Maenner:

* (1) Gruppierte CFA - Alle Parameter freisetzen (BHHH-Alghorithmus)

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v8_m) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(none) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* (2) Gruppierte CFA - Metrische Invarianz, Faktorladungen invariant (BHHH-Alghorithmus)

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v8_m) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* 1-[chi2((df Model2 - df Model1),(Chi2 Model2 - Chi2 Model1))]

disp 1-[chi2((71-64),(169.93-160.43))]

disp 169.93-160.43

* (3) Gruppierte CFA - Skalare Invarianz, Faktorladungen und Itemintercepts invariant (BHHH-Alghorithmus)

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v8_m) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef mcons) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Chi-Quadrat-Differenztest:

* 1-[chi2((df Model3 - df Model2),(Chi2 Model3 - Chi2 Model2))]

disp 1-[chi2((78-71),(209.54-169.93))]

disp 209.54-169.93

* (4) Gruppierte CFA - Strikte faktorielle Invarianz, Faktorladungen, Itemintercepts und Residuen invariant (BHHH-Alghorithmus)

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v8_m) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef mcons merrvar) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Chi-Quadrat-Differenztest:

* 1-[chi2((df Model4 - df Model3),(Chi2 Model4 - Chi2 Model3))]

disp 1-[chi2((88-78),(234.59-209.54))]

disp 234.59-209.54

* (5) Gruppierte CFA - Strikte Messfehlerinvarianz inkl. gleichen Faktormittelwerten (BHHH-Alghorithmus)

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v8_m) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef mcons merrvar meanex) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Chi-Quadrat-Differenztest:

* 1-[chi2((df Model5 - df Model4),(Chi2 Model5 - Chi2 Model4))]

disp 1-[chi2((91-88),(246.54-234.59))]

disp 246.54-234.59

* (6) Gruppierte CFA - Strikte Messfehlerinvarianz inkl. gleichen Faktormittelwerten und -varianzen (BHHH-Alghorithmus)
* Kriterium gemaess UCLA-Doku (s. oben fuer Quelle)

sem (SBB -> v31_inv@1 v32_inv v33_inv v34_inv) (SSA -> v53@1 v56 v57) (BS -> v62@1 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v8_m) mean(SBB) mean(SSA) mean(BS) ///
var(SBB) var(SSA) var(BS) ///
method(mlmv) ginvariant(mcoef mcons merrvar meanex covex) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Chi-Quadrat-Differenztest:

* 1-[chi2((df Model6 - df Model5),(Chi2 Model6 - Chi2 Model5))]

disp 1-[chi2((97-91),(262.93-246.54))]

disp 262.93-246.54

****************

* Analysemodell, dass sich als messinvariant mit hoechstem Informationsgehalt erwies:

* Vgl. Reineke 2014: 143ff., 162-168

* (2) Gruppierte CFA - Metrische Invarianz, Faktorladungen invariant (BHHH-Alghorithmus)

* Achtung: Hier werden Varianzen der latenten Faktoren auf 1 restringiert, um Korrelationen zwischen latenten Faktoren zu erhalten

* Unstandardisierte Koeffizienten

sem (SBB -> v31_inv v32_inv v33_inv v34_inv) (SSA -> v53 v56 v57) (BS -> v62 v63_inv v64_inv) ///
(v31_inv <- SBB _cons@0) (v53 <- SSA _cons@0) (v62 <- BS _cons@0), ///
group(v8_m) mean(SBB) mean(SSA) mean(BS) ///
var(SBB@1) var(SSA@1) var(BS@1) ///
method(mlmv) ginvariant(mcoef) ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

****************

* FINALE MODELLE fuer Hypothesentests - MIMIC (inkl. formative Indikatoren)

* Deskriptionen

sum v17 v78 v8_m

tab v17

tab v78

tab v8_m

* Frauen

sum v17 v78 if v8_m==0

tab v17 if v8_m==0

tab v78 if v8_m==0

* Maenner

sum v17 v78 if v8_m==1

tab v17 if v8_m==1

tab v78 if v8_m==1

***

robvar v78, by(v17)

ttest v78, by(v17) unequal

robvar v78, by(v8_m)

ttest v78, by(v8_m) unequal

* Hypothesentests

* Verwenden: Modell 2

* (2) Gruppierte CFA - Metrische Invarianz (BHHH-Alghorithmus)

sem (SBB -> v31_inv v32_inv v33_inv v34_inv) ///
(SBB <- v17 v78_zentr v17_x_v78), ///
group(v8_m) ///
method(mlmv) ginvariant(mcoef) stand ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Erweitert: Inkl. direkte Effekte zwischen exogenen (formativen) Indikatoren und manifesten Items

sem (SBB -> v31_inv v32_inv v33_inv v34_inv) ///
(SBB <- v17 v78_zentr v17_x_v78) ///
(v32_inv <- v17 v78_zentr) ///
(v33_inv <- v17 v78_zentr) ///
(v34_inv <- v17 v78_zentr), ///
group(v8_m) ///
method(mlmv) ginvariant(mcoef) stand ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

* Erweitert: Inkl. Messfehlerkovarianzen

sem (SBB -> v31_inv v32_inv v33_inv v34_inv) ///
(SBB <- v17 v78_zentr v17_x_v78), ///
cov(e.v32_inv*e.v33_inv e.v32_inv*e.v34_inv e.v33_inv*e.v34_inv) ///
group(v8_m) ///
method(mlmv) ginvariant(mcoef) stand ///
technique(nr 5 bhhh 5)

estat gof, stats(all)

****************

* Vergleichsanalysen (rekursives Pfadmodell mit additiven Indices)

sem (v17 v78_zentr v17_x_v78 -> skala_sbb), method(mlmv)

estat gof, stats(all)

* Gruppiert (Frauen, Maenner)

sem (v17 v78_zentr v17_x_v78 -> skala_sbb), method(mlmv) group(v8_m)

estat gof, stats(all)

* Als Regression mit VIF

reg skala_sbb v17 v78_zentr v17_x_v78, beta

estat vif

* Externe Validitaets-

pwcorr v17 skala_sbb, sig

pwcorr v78_zentr skala_sbb, sig

*******************************************************************************************************

* Exkurs: Anerkennungsempfindungen bei befristet Beschaeftigten

*******************************************************************************************************

* AV: v22 ("Manchmal habe ich das Gefühl durch mein befristetes Arbeitsverhältnis gesellschaftich nicht angekommen zu sein.")

* Kodierung: 1 = Trifft ueberhaupt nicht zu bis 5 = Trifft voll und ganz zudem

* Missings deklarieren:

replace v22=. if v22 > 6

******************************

* Kap. 6.1 - Exkurs
* TABELLE 25  --> neu erstellen (inkl. FIML, abgepasste n)

******************************

* Recode v22

gen v22_inv=.

replace v22_inv=1 if v22==5
replace v22_inv=2 if v22==4
replace v22_inv=3 if v22==3
replace v22_inv=4 if v22==2
replace v22_inv=5 if v22==1

gen v413proz_q=v413proz*v413proz

* Deskriptive Statistiken

sum v22_inv v413proz v163_in_t v77 v7 if !missing(v22_inv)

tab v22_inv if !missing(v22_inv)

tab v192_dich if !missing(v22_inv)

tab v49_dich if !missing(v22_inv)

tab v77 if !missing(v22_inv)

tab v8_m if !missing(v22_inv)

******************************

* Kap. 6.1 - Exkurs
* TABELLE 26  --> neu erstellen (inkl. FIML, abgepasste n)

******************************

* OLS-Regression:

* Model 1

reg v22_inv v413proz if !missing(v22_inv, v413proz, v192_dich, v163, v49_dich, v77, v8_m, v7), beta

* Model 2

reg v22_inv v413proz c.v413proz#c.v413proz if !missing(v22_inv, v413proz, v192_dich, v163, v49_dich, v77, v8_m, v7), beta

* Model 3

reg v22_inv v413proz c.v413proz#c.v413proz v192_dich v163 v49_dich v77 v7 v8_m ///
if !missing(v22_inv, v413proz, v192_dich, v163, v49_dich, v77, v8_m, v7), beta

estat vif

* Inkl. FIML

* Model 1

eststo A: sem (v22_inv <- v413proz) if !missing(v22_inv), method(mlmv)

estat eqgof

estadd beta

* Calculate Adjusted R^2

* Adjusted R^2 = 1 – [(1-R^2)*(n-1)/(n-k-1)]

disp 1-[(1-0.0199622)*(182-1)/(182-1-1)]

* Model 2

eststo B: sem (v22_inv <- v413proz v413proz_q) if !missing(v22_inv), method(mlmv)

estat eqgof

estadd beta

* Calculate Adjusted R^2

* Adjusted R^2 = 1 – [(1-R^2)*(n-1)/(n-k-1)]

disp 1-[(1-0.0666685)*(182-1)/(182-2-1)]

* Model 3

eststo C: sem (v22_inv <- v413proz v413proz_q v192_dich v163_in_t v49_dich v77 v7 v8_m) if !missing(v22_inv), method(mlmv)

estat eqgof

estadd beta

* Calculate Adjusted R^2

* Adjusted R^2 = 1 – [(1-R^2)*(n-1)/(n-k-1)]

disp 1-[(1-0.1071963)*(182-1)/(182-8-1)]

esttab A B C using "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Stata Tabellen\211106 - Anerkennungswahrnehmung und Befristung.rtf", replace ///
title({Tabelle xy:} {Anerkennungswahrnehmungen im Zusammenhang mit Befristung}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3") ///
cells("beta (star fmt(3) label(Koef.)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") eform starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) ///
stats(F p N, fmt(2 3 0) labels("F-Test" "Emp. Signif. F-Test" "n (Personenmonate)")) constant ///
nonotes addnote("Quelle: AGIPEB-Studie 2012/13. Rekursive Pfadmodelle mit Full Information Maximum Likelihood Methode." ///
"Koef. = standardisierte Koeffizienten, SE = Standardfehler, p = empirische Signifikanz." ///
"+ p < 0,10, * p < 0,05, ** p < 0,01, *** p < 0,001.") drop(_cons) ///
fonttbl(\f0\fnil arial; ) compress nogaps

******************************

* Kap. 6.1 - Exkurs
* ABBILDUNG 8  --> neu erstellen (inkl. FIML, angepasste n)

******************************

* Conditional-Effects-Plot zur Darstellung des Einflusses der quadrierten Befristungsanteile

* Undifferenzierter Vergleich

margins, at( v413proz=(0(5)100) )

marginsplot, byopt(rows(1)) ///
title("") ///
ytitle("Subjektive gesellschaftliche Anerkennung")									/// Y-title
xtitle("Relative Befristungsanteile an abgefragten Biographien (Prozent)") 			/// X-title
scheme(s1mono)

* Export graph

graph export "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Plots\margins anerkennung.png", ///
replace width(2000)	// format: PNG (for manuscript)

graph export "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Plots\margins anerkennung.tif", ///
replace width(2000)	// format: TIFF (for upload)

*******************************

* Ergaenzung: 

* Model 3 - getrennt nach Frauen und Maennern

* Frauen

sem (v22_inv <- v413proz v192_dich v163_in_t v49_dich v77 v7 v413proz_q) if v8_m==0 & !missing(v22_inv), method(mlmv)

estat eqgof

estadd beta

* Maenner

sem (v22_inv <- v413proz v192_dich v163_in_t v49_dich v77 v7 v413proz_q) if v8_m==1 & !missing(v22_inv), method(mlmv)

estat eqgof

estadd beta

* Frauen

sem (v22_inv <- v413proz v192_dich v163_in_t v49_dich v77 v7 v413proz_q pb1_event) if v8_m==0 & !missing(v22_inv), method(mlmv)

estat eqgof

estadd beta

* Maenner

sem (v22_inv <- v413proz v192_dich v163_in_t v49_dich v77 v7 v413proz_q pb1_event) if v8_m==1 & !missing(v22_inv), method(mlmv)

estat eqgof

estadd beta

***********************************************************

* Exkurs: Gewoehnungseffekte befristeter Episoden auf Befristungsbewertungen

reg v35_inv v413proz ///
if !missing(v35, v413proz, v163_in_t, v49_dich, v77, v8_m, v7) & v45>19, beta

reg v35_inv v413proz c.v413proz#c.v413proz ///
if !missing(v35, v413proz, v163_in_t, v49_dich, v77, v8_m, v7) & v45>19, beta

reg v35_inv v413proz c.v413proz#c.v413proz v192_dich v163_in_t v49_dich v77 v7 v8_m ///
if !missing(v35, v413proz, v163_in_t, v49_dich, v77, v8_m, v7) & v45>19, beta

predict r, resid

pnorm r

qnorm r

swilk r

* Conditional-Effects-Plot zur Darstellung des Einflusses der quadrierten Befristungsanteile

* Undifferenzierter Vergleich

margins, at( v413proz=(0(5)100) )

marginsplot, byopt(rows(1)) ///
title("") ///
ytitle("Subjektive Befristungsbewertung (Zukunftsplanbarkeit)")						/// Y-title
xtitle("Relative Befristungsanteile an abgefragten Biographien (Prozent)") 			/// X-title
scheme(s1mono)

* Export graph

graph export "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Plots\margins zujunftsplanbarkeit alle.png", ///
replace width(2000)	// format: PNG (for manuscript)

graph export "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Plots\margins zujunftsplanbarkeit alle.tif", ///
replace width(2000)	// format: TIFF (for upload)

* FIML

eststo X: sem (v35_inv <- v17 v192_dich v163_in_t v49_dich v77 v7 v8_m), method(mlmv)

estadd beta

estat eqgof

* Calculate Adjusted R^2

* Adjusted R^2 = 1 – [(1-R^2)*(n-1)/(n-k-1)]

disp 1-[(1-r(CD))*(1047-1)/(1047-7-1)]

eststo Z: sem (v35_inv <- v413proz v413proz_q v192_dich v163_in_t v49_dich v77 v7 v8_m), method(mlmv)

estadd beta

estat eqgof

* Calculate Adjusted R^2

* Adjusted R^2 = 1 – [(1-R^2)*(n-1)/(n-k-1)]

disp 1-[(1-r(CD))*(1047-1)/(1047-8-1)]

esttab X Z using "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Stata Tabellen\211109 - Zukunftsplanbarkeit + Befristungserfahrungen.rtf", replace ///
title({Tabelle xy:} {Subjektive Befristungsbewertung (Zukunftsplanbarkeit)}) ///
nonumbers mtitles("Modell 1" "Modell 2") ///
cells("beta (star fmt(3) label(Koef.)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") eform starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) ///
stats(F p N, fmt(2 3 0) labels("F-Test" "Emp. Signif. F-Test" "n (Personenmonate)")) constant ///
nonotes addnote("Quelle: AGIPEB-Studie 2012/13. Rekursive Pfadmodelle mit Full Information Maximum Likelihood Methode." ///
"Koef. = standardisierte Koeffizienten, SE = Standardfehler, p = empirische Signifikanz." ///
"*** p < 0,001, ** p < 0,01, * p < 0,05, + p < 0,10.") drop(_cons) ///
fonttbl(\f0\fnil arial; ) compress nogaps

* Kontrollen:

* Nur BEFRISTETE (v17 = 1)

sem (v35_inv <- v413proz v413proz_q v192_dich v163_in_t v49_dich v77 v7 v8_m) if v17==1, method(mlmv)

reg v35_inv v413proz c.v413proz#c.v413proz v192_dich v163_in_t v49_dich v77 v7 v8_m ///
if !missing(v35, v413proz, v163_in_t, v49_dich, v77, v8_m, v7) & v45>19 & v17==1, beta

* Undifferenzierter Vergleich

margins, at( v413proz=(0(5)100) )

marginsplot, byopt(rows(1)) ///
title("") ///
ytitle("Subjektive Befristungsbewertung (Zukunftsplanbarkeit)")										/// Y-title
xtitle("Relative Befristungsanteile an abgefragten Biographien (Prozent)" "Befristete") 			/// X-title
scheme(s1mono)

* Export graph

graph export "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Plots\margins zujunftsplanbarkeit BEFRISTETE.png", ///
replace width(2000)	// format: PNG (for manuscript)

graph export "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Plots\margins zujunftsplanbarkeit BEFRISTETE.tif", ///
replace width(2000)	// format: TIFF (for upload)

* Nur UNBEFRISTETE (v17 = 0)

sem (v35_inv <- v413proz v413proz_q v192_dich v163_in_t v49_dich v77 v7 v8_m) if v17==0, method(mlmv)

reg v35_inv v413proz c.v413proz#c.v413proz v192_dich v163_in_t v49_dich v77 v7 v8_m ///
if !missing(v35, v413proz, v163_in_t, v49_dich, v77, v8_m, v7) & v45>19 & v17==0, beta

* Undifferenzierter Vergleich

margins, at( v413proz=(0(5)100) )

marginsplot, byopt(rows(1)) ///
title("") ///
ytitle("Subjektive Befristungsbewertung (Zukunftsplanbarkeit)")										/// Y-title
xtitle("Relative Befristungsanteile an abgefragten Biographien (Prozent)" "Unbefristete") 			/// X-title
scheme(s1mono)

* Export graph

graph export "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Plots\margins zujunftsplanbarkeit UNBEFRISTETE.png", ///
replace width(2000)	// format: PNG (for manuscript)

graph export "E:\Habilschrift\Analysen Kap6_1 - Skalenkonstruktion\Plots\margins zujunftsplanbarkeit UNBEFRISTETE.tif", ///
replace width(2000)	// format: TIFF (for upload)

* Nur UNBEFRISTETE (v17 = 0) und noch nie mit Befristung in Kontakt gekommen (v500 = 0)

sem (v35_inv <- v413proz v413proz_q v192_dich v163_in_t v49_dich v77 v7 v8_m) if v17==0 & v500==0, method(mlmv)

reg v35_inv v413proz c.v413proz#c.v413proz v192_dich v163_in_t v49_dich v77 v7 v8_m ///
if !missing(v35, v413proz, v163_in_t, v49_dich, v77, v8_m, v7) & v45>19 & v17==0 & v500==0, beta

* Undifferenzierter Vergleich

margins, at( v413proz=(0(5)100) )

marginsplot, byopt(rows(1)) ///
title("") ///
ytitle("Subjektive Befristungsbewertung (Zukunftsplanbarkeit)")										/// Y-title
xtitle("Relative Befristungsanteile an abgefragten Biographien (Prozent)" "Unbefristete") 			/// X-title
scheme(s1mono)

* Nur UNBEFRISTETE (v17 = 0) und noch nie mit Befristung in Kontakt gekommen (v500 = 0)

sem (v35_inv <- v413proz v413proz_q v192_dich v163_in_t v49_dich v77 v7 v8_m) if v17==0 & v500==0, method(mlmv)

reg v35_inv v413proz c.v413proz#c.v413proz v192_dich v163_in_t v49_dich v77 v7 v8_m ///
if !missing(v35, v413proz, v163_in_t, v49_dich, v77, v8_m, v7) & v45>19 & v17==0 & v500==0, beta

* Undifferenzierter Vergleich

margins, at( v413proz=(0(5)100) )

marginsplot, byopt(rows(1)) ///
title("") ///
ytitle("Subjektive Befristungsbewertung (Zukunftsplanbarkeit)")										/// Y-title
xtitle("Relative Befristungsanteile an abgefragten Biographien (Prozent)" "Unbefristete") 			/// X-title
scheme(s1mono)

***********************************************************