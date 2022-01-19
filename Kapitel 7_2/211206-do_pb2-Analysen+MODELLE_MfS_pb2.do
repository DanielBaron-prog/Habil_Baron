* Analysen AGIPEB pb2 - Piecewise Constant Modelle

* Daten: AGIPEB Vers. 30 

* Program used: mimrgns

****************************

clear

use "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Daten\Daten_AGIPEB_30-STATA_split.dta"

* version 13

set more off

***********************************************************
***********************************************************

* Spezielle Datenaufbereitung fuer Beispiel "Entscheidung zur Elternschaft (= pb2)"

* Variable "pb2_fail" generieren, die den Eintritt des Ereignises widergibt

gen pb2_fail = 0

move pb2_fail eb_beginn1

replace pb2_fail = 1 if pb_dauer==pb2_risktime & pb2_event==1

drop if pb2_event==1 & pb_dauer>pb2_risktime

tab pb2_fail if pb2_fail==1

***********************************************************

* Grundlegende Datenaufbereitung bzw. Reshape abgeschlossen

***********************************************************
* Vorbereiten erneutes STSET

* Neue Variablen fuer Episodenstart- und -endzeitpunkte generieren / umbenennen

gen pb_end=pb_dauer
move pb_end pb_dauer

gen pb_start=pb_end-1
move pb_start pb_end

* Alte STSET-Variablen loeschen

* drop _st
* drop _d
* drop _t
* drop _t0
* drop T0

* Variable "pb_zeit" fuer Prozesszeit bilden

gen pb_zeit=pb_end-pb_start
move pb_zeit pb_dauer

tab pb_zeit

***********************************************************

sort id gt

* Persoenliche Prozesszeit pt generieren (_t bereinigt um 12 Monate)

gen pt=_t-12

move pt gt

* Hilfsvariable pb_dauer_max neu berechnen

drop pb_dauer_max

* Hilfsvariable maximale Partnerschaftsdauer berechnen

by id: gen pb_dauer_max = _N

* list id gt pb_dauer_max pb_dauer pb_dauer_max

***********************************************************

* Variable erstellen fuer kumulierte Sonstigessmonate und relative Sonstigesanteile

sort id eb_sonst gt 

* Dann Variable bilden, die Missings in Zaehlvariable eb_befr_count abbildet

by id eb_sonst, sort: gen eb_sonst_count=_n if eb_sonst==1 & _n!=.

* list id eb_sonst eb_befr eb_unbefr gt eb_sonst_count


* Wert fuer eb_sonst_count aus Vorepisode uebernehmen fuer jeden Spell, der nicht Sonstiges ist, jedoch nach Sonstigesepisode auftritt

by id: replace eb_sonst_count=eb_sonst_count[_n-1] if eb_sonst==0 & eb_sonst_count[_n-1]>=1

replace eb_sonst_count=0 if eb_sonst_count==.

* list id eb_sonst eb_befr eb_unbefr gt eb_sonst_count


* Monate personenspezifisch kumulieren

by id, sort: gen eb_sonst_monate_pers_kum=eb_sonst_count[_N] if eb_sonst==1

sort id eb_sonst_count

* list id eb_befr eb_al eb_bild eb_al eb_sonst gt eb_sonst_count eb_sonst_monate_pers_kum

* Und die eb_sonst_count uebernehmen fuer jeden Spell, der nicht unbefristet ist, jedoch nach Unbefristungsepisode auftritt

sort id gt 

by id: replace eb_sonst_count=eb_sonst_count[_n-1] if eb_sonst==0 & eb_sonst_count[_n-1]>=1

* Missingwerte fuer eb_sonst_count =0 setzen

replace eb_sonst_count=0 if eb_sonst_count==.

* Kontrollieren:

* list id eb_unbefr eb_unbefr eb_bild eb_al eb_sonst eb_sonst_count



* Variable fuer Dauer bis Episodenwechsel

gen eb_sonst_wechs_dauer= eb_sonst_monate_pers_kum-eb_sonst_count

* list id eb_befr eb_al eb_bild eb_al eb_sonst gt eb_sonst_count eb_sonst_monate_pers_kum eb_sonst_wechs_dauer


* Korrigieren der Variable fuer Dauer bis Episodenwechsel um letzten Monat vor Wechsel

replace eb_sonst_wechs_dauer=eb_sonst_wechs_dauer+1

* list id eb_befr eb_al eb_bild eb_al eb_sonst gt eb_sonst eb_sonst_monate_pers_kum eb_sonst_wechs_dauer


* Jetzt noch eb_sonst_wechs_dauer=0, wenn UNBEFRISTET-Episode vorliegt

replace eb_sonst_wechs_dauer=0 if eb_unbefr==1

* list id eb_unbefr eb_sonst eb_sonst_count eb_sonst_monate_pers_kum eb_sonst_wechs_dauer gt

* Relative Sonstigesanteile berechnen

sort id pb_dauer

gen eb_sonst_rel=eb_sonst_count/pt

replace eb_sonst_rel=0 if eb_sonst_rel==.

* Relative Sonstigesanteile in Prozent

gen eb_sonst_rel_proz=eb_sonst_rel*100

* list id eb_sonst eb_befr eb_unbefr eb_sonst_count eb_sonst_rel_proz gt 

***********************************************************

* Variable erstellen fuer kumulierte Arbeitslosigkeitsmonate und relative Arbeitslosanteile

sort id eb_al gt 

* Dann Variable bilden, die Missings in Zaehlvariable eb_befr_count abbildet

by id eb_al, sort: gen eb_al_count=_n if eb_al==1 & _n!=.

* list id eb_al gt eb_al_count


* Wert fuer eb_al_count aus Vorepisode uebernehmen fuer jeden Spell, der nicht Arbeitslosigkeit ist, jedoch nach Arbeitslosigkeitsepisode auftritt

by id: replace eb_al_count=eb_al_count[_n-1] if eb_al==0 & eb_al_count[_n-1]>=1

replace eb_al_count=0 if eb_al_count==.


* Und die eb_al_count uebernehmen fuer jeden Spell, der nicht unbefristet ist, jedoch nach Unbefristungsepisode auftritt

sort id gt 

by id: replace eb_al_count=eb_al_count[_n-1] if eb_al==0 & eb_al_count[_n-1]>=1

* Missingwerte fuer eb_unbefr_count =0 setzen

replace eb_al_count=0 if eb_al_count==.

* Kontrollieren:

* list id eb_unbefr eb_unbefr eb_bild eb_al eb_sonst eb_al_count

* Monate personenspezifisch kumulieren

by id, sort: gen eb_al_monate_pers_kum=eb_al_count[_N] if eb_al==1

sort id eb_al_count

* list id eb_befr eb_al eb_bild eb_al eb_sonst gt eb_al_count eb_al_monate_pers_kum

* Variable fuer Dauer bis Episodenwechsel

gen eb_al_wechs_dauer= eb_al_monate_pers_kum-eb_al_count

* list id eb_befr eb_al eb_bild eb_al eb_sonst gt eb_al_count eb_al_monate_pers_kum eb_al_wechs_dauer

* Korrigieren der Variable fuer Dauer bis Episodenwechsel um letzten Monat vor Wechsel

replace eb_al_wechs_dauer=eb_al_wechs_dauer+1

* list id eb_befr eb_al eb_bild eb_al eb_sonst gt eb_al_count eb_al_monate_pers_kum eb_al_wechs_dauer

* Jetzt noch eb_al_wechs_dauer=0, wenn UNBEFRISTET-Episode vorliegt

replace eb_al_wechs_dauer=0 if eb_unbefr==1

* list id eb_unbefr eb_al eb_al_count eb_al_monate_pers_kum eb_al_wechs_dauer gt

* Relative Arbeitslosigkeitsanteile berechnen

sort id pb_dauer

gen eb_al_rel=eb_al_count/pt

replace eb_al_rel=0 if eb_al_rel==.

* Relative Arbeitslosigkeitsanteile in Prozent

gen eb_al_rel_proz=eb_al_rel*100

* list id eb_al eb_befr eb_unbefr eb_al_count eb_al_rel_proz gt 

***********************************************************

* Variable erstellen fuer kumulierte unbefristete Monate und relative Unbefristetanteile

sort id eb_unbefr gt 

* Dann Variable bilden, die Missings in Zaehlvariable eb_befr_count abbildet

by id eb_unbefr, sort: gen eb_unbefr_count=_n if eb_unbefr==1 & _n!=.

* list id eb_unbefr gt eb_unbefr_count

replace eb_unbefr_count=0 if eb_unbefr_count==.

* Wert fuer eb_unbefr_count aus Vorepisode uebernehmen fuer jeden Spell, der nicht unbefristet ist, jedoch nach Unbefristetepisode auftritt

by id: replace eb_unbefr_count=eb_unbefr_count[_n-1] if eb_unbefr==0 & eb_unbefr_count[_n-1]>=1

* Und die eb_unbefr_count uebernehmen fuer jeden Spell, der nicht unbefristet ist, jedoch nach Unbefristungsepisode auftritt

sort id gt 

by id: replace eb_unbefr_count=eb_unbefr_count[_n-1] if eb_unbefr==0 & eb_unbefr_count[_n-1]>=1

* Missingwerte fuer ebb_unbefr_count =0 setzen

replace eb_unbefr_count=0 if eb_unbefr_count==.

* Kontrollieren:

* list id eb_unbefr eb_unbefr eb_bild eb_al eb_sonst eb_unbefr_count

* Monate personenspezifisch kumulieren

by id, sort: gen eb_unbefr_monate_pers_kum=eb_unbefr_count[_N] if eb_unbefr==1

sort id eb_unbefr_count

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_unbefr_count eb_unbefr_monate_pers_kum

* Variable fuer Dauer bis Episodenwechsel

gen eb_unbefr_wechs_dauer= eb_unbefr_monate_pers_kum-eb_unbefr_count

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_unbefr_count eb_unbefr_monate_pers_kum eb_unbefr_wechs_dauer


* Korrigieren der Variable fuer Dauer bis Episodenwechsel um letzten Monat vor Wechsel

replace eb_unbefr_wechs_dauer=eb_unbefr_wechs_dauer+1

set more off

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_unbefr_count eb_unbefr_monate_pers_kum eb_unbefr_wechs_dauer

* Jetzt noch eb_unbefr_wechs_dauer=0, wenn UNBEFRISTET-Episode vorliegt

* replace eb_unbefr_wechs_dauer=0 if eb_unbefr==1

* list id eb_befr eb_unbefr eb_unbefr_count eb_unbefr_monate_pers_kum eb_unbefr_wechs_dauer gt


* Relative Unbefristungsanteile berechnen

sort id gt

gen eb_unbefr_rel=eb_unbefr_count/pt

replace eb_unbefr_rel=0 if eb_unbefr_rel==.

* Relative Unbefristungsanteile in Prozent

gen eb_unbefr_rel_proz=eb_unbefr_rel*100

sort id gt

* list id eb_unbefr eb_befr eb_unbefr_wechs_dauer eb_unbefr_count eb_unbefr_rel_proz gt pt

***********************************************************

* Variable erstellen fuer kumulierte Bildungsmonate und relative Bildungsanteile


sort id eb_bild gt 

* Dann Variable bilden, die Missings in Zaehlvariable eb_befr_count abbildet

by id eb_bild, sort: gen eb_bild_count=_n if eb_bild==1 & _n!=.

* list id eb_bild gt eb_bild_count


* Wert fuer eb_bild_count aus Vorepisode uebernehmen fuer jeden Spell, der nicht Bildung ist, jedoch nach Bildungsepisode auftritt

by id: replace eb_bild_count=eb_bild_count[_n-1] if eb_bild==0 & eb_bild_count[_n-1]>=1

replace eb_bild_count=0 if eb_bild_count==.

* Und die eb_bild_count uebernehmen fuer jeden Spell, der nicht befristet ist, jedoch nach Befristungsepisode auftritt

sort id gt 

by id: replace eb_bild_count=eb_bild_count[_n-1] if eb_bild==0 & eb_bild_count[_n-1]>=1

* Missingwerte fuer eb_bild_count =0 setzen

replace eb_bild_count=0 if eb_bild_count==.

* Kontrollieren:

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_bild_count


* Monate personenspezifisch kumulieren

by id, sort: gen eb_bild_monate_pers_kum=eb_bild_count[_N] if eb_bild==1

sort id eb_bild_count

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_bild_count eb_bild_monate_pers_kum

* Variable fuer Dauer bis Episodenwechsel

gen eb_bild_wechs_dauer= eb_bild_monate_pers_kum-eb_bild_count

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_bild_count eb_bild_monate_pers_kum eb_bild_wechs_dauer


* Korrigieren der Variable fuer Dauer bis Episodenwechsel um letzten Monat vor Wechsel

replace eb_bild_wechs_dauer=eb_bild_wechs_dauer+1

set more off

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_bild_count eb_bild_monate_pers_kum eb_bild_wechs_dauer


* Jetzt noch eb_bild_wechs_dauer=0, wenn UNBEFRISTET-Episode vorliegt

replace eb_bild_wechs_dauer=0 if eb_unbefr==1

* list id eb_bild eb_unbefr eb_bild_count eb_bild_monate_pers_kum eb_bild_wechs_dauer gt


* Relative Bildungsungsanteile berechnen

sort id pb_dauer

gen eb_bild_rel=eb_bild_count/pt

replace eb_bild_rel=0 if eb_bild_rel==.

* Relative Bildungsanteile in Prozent

gen eb_bild_rel_proz=eb_bild_rel*100

* list id eb_bild eb_befr eb_unbefr eb_bild_count eb_bild_rel_proz gt 


***********************************************************

* Erstellung "Relative Befristungsanteile"

* Usefile: AGIPEB Version 26

* D:\...\STATA-Datensaetze\Daten_AGIPEB_26-STATA.dta

* Version: Stata 13 IC

* Usevariables:

* id = Personenidentifikationsnummer
* gt = Allgemeine Prozesszeit des gesamten Datensatzes
* eb_befr = Zeitveraenderliche Dummy-Variable "Befristung in Erwerbsspell ja/nein"
* pb_dauer_max = Zeitkonstante Variable "Maximale Dauer der abgefragten Partnerschafts- und Erwerbsbiographie"

set more off

*** ACHTUNG: Sortieren nach id und eb_befr, um Missings bei nicht-rechtszensierten Befristungsepisoden zu vermeiden!

sort id eb_befr gt 

* Dann Variable bilden, die Missings in Zaehlvariable eb_befr_count abbildet

by id eb_befr, sort: gen eb_befr_count=_n if eb_befr==1 & _n!=.

* list id eb_befr gt eb_befr_count

* Wert fuer eb_befr_count aus Vorepisode uebernehmen fuer jeden Spell, der nicht befristet ist, jedoch nach Befristungsepisode auftritt

by id: replace eb_befr_count=eb_befr_count[_n-1] if eb_befr==0 & eb_befr_count[_n-1]>=1

replace eb_befr_count=0 if eb_befr_count==.

* Und die eb_befr_count uebernehmen fuer jeden Spell, der nicht befristet ist, jedoch nach Befristungsepisode auftritt

sort id gt 

by id: replace eb_befr_count=eb_befr_count[_n-1] if eb_befr==0 & eb_befr_count[_n-1]>=1

* Missingwerte fuer ebb_befr_count =0 setzen

replace eb_befr_count=0 if eb_befr_count==.

* Kontrollieren:

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_befr_count


* Befristungsmonate personenspezifisch kumulieren

sort id eb_befr gt 

by id, sort: gen eb_befr_monate_pers_kum=eb_befr_count[_N] if eb_befr==1

sort id eb_befr_count

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_befr_count eb_befr_monate_pers_kum

* Variable fuer Dauer bis Episodenwechsel

sort id eb_befr_count

gen eb_befr_wechs_dauer= eb_befr_monate_pers_kum-eb_befr_count

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_befr_count eb_befr_monate_pers_kum eb_befr_wechs_dauer


* Korrigieren der Variable fuer Dauer bis Episodenwechsel um letzten Monat vor Wechsel

replace eb_befr_wechs_dauer=eb_befr_wechs_dauer+1

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst gt eb_befr_count eb_befr_monate_pers_kum eb_befr_wechs_dauer

* Jetzt noch eb_befr_wechs_dauer=0, wenn UNBEFRISTET-Episode vorliegt

replace eb_befr_wechs_dauer=0 if eb_unbefr==1

sort id gt

* list id eb_befr eb_unbefr eb_befr_count eb_befr_monate_pers_kum eb_befr_wechs_dauer gt

* Und die eb_befr_wechs_dauer uebernehmen fuer jeden Spell, der nicht befristet ist, jedoch nach Befristungsepisode auftritt

sort id gt

by id: replace eb_befr_wechs_dauer=eb_befr_wechs_dauer[_n-1] if eb_befr==0 & eb_unbefr==0 & eb_befr_wechs_dauer[_n-1]>=1

* Kontrollieren:

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_befr_count eb_befr_wechs_dauer

* Jetzt jene eb_befr_wechsel_dauer korrigieren, bei denen der Wechsel aus BEFRISTET nicht in UNBEFRISTET erfolgt

* sort id gt

* by id: replace eb_befr_wechs_dauer=eb_befr_wechs_dauer[_n-1] if eb_befr==0

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_befr_monate_pers_kum eb_befr_wechs_dauer



* Jetzt jene eb_befr_wechsel_dauer auf 0 korrigieren, die tatsaechlich in UNBEFRISTET muenden

* sort id gt

* replace eb_befr_wechs_dauer=0 if eb_befr==1 & eb_befr_wechs_dauer==1 & eb_befr_monate_pers_kum==.

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_befr_monate_pers_kum eb_befr_wechs_dauer

* Jetzt jene eb_befr_wechsel_dauer auf . korrigieren, die mit UNBEFRISTET einhergehen

* sort id gt

* replace eb_befr_wechs_dauer=. if eb_unbefr==1 & eb_befr_wechs_dauer==0

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_befr_monate_pers_kum eb_befr_wechs_dauer

***********************************************************
***********************************************************
***********************************************************
***********************************************************
***********************************************************
***********************************************************

* ACHUNG: Es muessen noch die korrekten ("hoeheren") Werte fuer "eb_befr_monate_pers_kum_korr" generiert werden, so dass alle
* NICHT_UNBEFRISTET-Episoden vor dem Wechsel in UNBEFRISTET mit ihrer Zeit bis Wechsel beruecksichtigt werden. Anschliessend muss
* "eb_befr_monate_pers_kum_korr" in eine chronologisch absteigende Reihe gebracht werden!

***********************************************************
***********************************************************

* Korrigierte Variable fuer kumulierte Befristungsmonate:

* sort id eb_befr_wechs_dauer eb_befr gt 

* Finale korrigierte Variable erstellen

* bysort id (gt): gen eb_befr_monate_pers_kum_korr=_n if eb_unbefr!=1

* list id eb_befr eb_unbefr eb_bild eb_al eb_befr_wechs_dauer eb_befr_monate_pers_kum_korr gt

* sort id gt

* list id eb_befr eb_unbefr eb_bild eb_al eb_befr_wechs_dauer eb_befr_monate_pers_kum_korr pt gt

* Korrigieren der Variable auf 0, wenn Unbefristet

* sort id gt

* replace eb_befr_monate_pers_kum_korr=0 if eb_unbefr==1

* list id eb_befr eb_unbefr eb_bild eb_al eb_befr_wechs_dauer eb_befr_monate_pers_kum_korr gt


***********************************************************
***********************************************************
***********************************************************
***********************************************************
***********************************************************
***********************************************************
***********************************************************
***********************************************************

* Relative Befristungsanteile berechnen

sort id gt

set more off

gen eb_befr_rel=eb_befr_count/pt

replace eb_befr_rel=0 if eb_befr_rel==.


* Relative Befristungsanteile in Prozent

gen eb_befr_rel_proz=eb_befr_rel*100

sort id gt

* list id eb_befr eb_unbefr eb_befr_wechs_dauer eb_befr_count pt eb_befr_rel_proz gt

***********************************************************

* Missings Dauer bis Episodenwechsel ersetzen durch 0

replace eb_befr_wechs_dauer=0 if eb_befr_wechs_dauer==. & eb_unbefr==1

replace eb_bild_wechs_dauer=0 if eb_bild_wechs_dauer==. & eb_unbefr==1
replace eb_al_wechs_dauer=0 if eb_al_wechs_dauer==. & eb_unbefr==1
replace eb_sonst_wechs_dauer=0 if eb_sonst_wechs_dauer==. & eb_unbefr==1

* Kontrolle

* list id eb_befr_wechs_dauer eb_unbefr_wechs_dauer eb_bild_wechs_dauer eb_al_wechs_dauer eb_sonst_wechs_dauer pt


* ALLE Befristungsanteile final korrigieren

* list id eb_befr_rel_proz eb_unbefr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz gt


* Kontrollberechnung fuer eb_count-Variablen:

sort id gt

gen eb_count_kontroll=eb_befr_rel_proz+eb_unbefr_rel_proz+eb_bild_rel_proz+eb_al_rel_proz+eb_sonst_rel_proz

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_count_kontroll gt

* Fehlerhafte anzeigen:

sort id gt

* list id eb_befr_rel_proz eb_unbefr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz eb_count_kontroll pt if eb_count_kontroll<99

* list id eb_befr_count eb_unbefr_count eb_bild_count eb_al_count eb_sonst_count eb_count_kontroll pt if eb_count_kontroll!=100

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_count_kontroll pt if eb_count_kontroll!=100

* list id eb_befr eb_unbefr eb_befr_wechs_dauer eb_befr_count pt eb_befr_rel_proz eb_count_kontroll gt if eb_befr_rel_proz>100

* list id eb_befr eb_unbefr eb_befr_wechs_dauer eb_befr_count pt eb_befr_rel_proz eb_count_kontroll gt

***********************************************************

* 12.8.19: Variable fuer Dauer bis Wechsel in unbefristete Beschaeftigung ueber alle eb-Typen

* Hilfsvariable erstellen: unbefr oder andere eb-Typen?

sort id pt

gen eb_hilf=.

replace eb_hilf=1 if eb_befr==1 | eb_bild==1 | eb_al==1 | eb_sonst==1

* Jetzt die Dnicht unbefristeten Episoden zahlen

by id: gen eb_count_nicht_unbefr = sum(!missing(eb_hilf))

replace eb_count_nicht_unbefr=0 if eb_unbefr==1

* Wie urspruenglich sortieren und kontrollieren

sort id gt

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_hilf eb_count_nicht_unbefr pt

* Maximale Anzahl der nicht unbefristeten Spells kumulieren

by id eb_hilf, sort: gen eb_kum_nicht_unbefr=_N if eb_hilf!=.

* Maximale Anzahl der nicht unbefristeten Spells korrigieren:

by id: replace eb_kum_nicht_unbefr=eb_kum_nicht_unbefr+1 if eb_kum_nicht_unbefr>0

* Kontrollieren

sort id pt

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_hilf eb_count_nicht_unbefr eb_kum_nicht_unbefr pt

* Finale Variable mit Dauer bis Wechsel in unbefristet bauen

sort id

by id: gen eb_wechsel_in_unbefr=eb_kum_nicht_unbefr-eb_count_nicht_unbefr

by id: replace eb_wechsel_in_unbefr=0 if eb_wechsel_in_unbefr==.

* Kontrollieren:

sort id pt

* list id eb_befr eb_unbefr eb_bild eb_al eb_sonst eb_hilf eb_count_nicht_unbefr eb_kum_nicht_unbefr eb_wechsel_in_unbefr pt


* v158 0-4 kodieren statt 1-5

replace v158=0 if v158==1
replace v158=1 if v158==2
replace v158=2 if v158==3
replace v158=3 if v158==4
replace v158=4 if v158==5

***********************************************************

* 2016 ergaenzt: Jetzt zeitveraenderliche Variable "jemals befristet" bilden;

gen eb_befr_je=0

move eb_befr_je eb_befr_rel

replace eb_befr_je = 1 if eb_befr_rel > 0

tab eb_befr_je

***********************************************************

* Erneutes STSET

* Alte STSET-Variablen loeschen

drop _st
drop _d
drop _t
drop _t0
drop T0

mi stset pb_end, id(id) time0(pb_start) origin(time pb_start) failure(pb2_fail==1)

sort id pb_dauer

***********************************************************
***********************************************************
***********************************************************
***********************************************************

* Episoden fuer Arbeitslosigkeit und Sonstiges auf Missing setzen

* replace eb_befr=. if eb_al==1
* replace eb_unbefr=. if eb_al==1
* replace eb_bild=. if eb_al==1

* replace eb_befr=. if eb_sonst==1
* replace eb_unbefr=. if eb_sonst==1
* replace eb_bild=. if eb_sonst==1


***********************************************************

* Erweiterte Modell fuer Ueberarbeitung ZFF

* Erstellen PLZ-gestuetzte Ost-West-Variable

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
	
***********************************************************
***********************************************************

* Zeitveraenderliche Variable erstellen fuer Messung konkurrierendes Ereignis Heirat

gen pb1_event_zeitv=.

replace pb1_event_zeitv=1 if pb_dauer >= pb1_hochzeit_risktime & pb1_hochzeit_beginn!=.

replace pb1_event_zeitv=0 if pb1_event_zeitv==.

replace pb1_event_zeitv=. if pb1_hochzeit_risktime==999

* list id pb1_event pb1_hochzeit_beginn pb1_hochzeit_risktime pb_dauer gt pb1_event_zeitv

* Faelle loeschen, in denen zeitveraenderliche Messung Heirat nicht moeglich

drop if pb1_hochzeit_risktime==999

***********************************************************
***********************************************************

* Zeitveraenderliche Variable erstellen fuer Messung konkurrierendes Ereignis Kohabitation

* gen pb4_event_zeitv=.

* replace pb4_event_zeitv=1 if pb_dauer >= pb4_haushalt_risktime & pb4_haushalt_beginn!=.

* replace pb4_event_zeitv=0 if pb4_event_zeitv==.

* replace pb4_event_zeitv=. if pb4_haushalt_risktime==999

* list id pb4_event pb4_haushalt_beginn pb4_haushalt_risktime pb_dauer pb4_event_zeitv

* Faelle loeschen, in denen zeitveraenderliche Messung Heirat nicht moeglich

set more off

* drop if pb4_haushalt_risktime==999

***********************************************************
***********************************************************

* Zeitveraenderliche Variable erstellen fuer Messung konkurrierendes Ereignis Immobilienerwerbs

* gen pb8_event_zeitv=.

* replace pb8_event_zeitv=1 if pb_dauer >= pb8_immobilie_risktime & pb8_immobilie_beginn!=.

* replace pb8_event_zeitv=0 if pb8_event_zeitv==.

* replace pb8_event_zeitv=. if pb8_immobilie_risktime==999

* set more off

* list id pb8_event pb8_immobilie_beginn pb8_immobilie_risktime pb_dauer pb8_event_zeitv

* Faelle loeschen, in denen zeitveraenderliche Messung Heirat nicht moeglich

* drop if pb8_immobilie_risktime==999

* Zeitveraenderliche Variablen invertieren

gen pb1_event_zeitv_inv=.
replace pb1_event_zeitv_inv=1 if pb1_event_zeitv==0
replace pb1_event_zeitv_inv=0 if pb1_event_zeitv==1

* gen pb4_event_zeitv_inv=.
* replace pb4_event_zeitv_inv=1 if pb4_event_zeitv==0
* replace pb4_event_zeitv_inv=0 if pb4_event_zeitv==1

* gen pb8_event_zeitv_inv=.
* replace pb8_event_zeitv_inv=1 if pb8_event_zeitv==0
* replace pb8_event_zeitv_inv=0 if pb8_event_zeitv==1

***********************************************************
***********************************************************

* Zeitveraenderliche Variable erstellen fuer Berufscodes

* 0 = Nicht akademisch und in Ausbildung
* 1 = Akademisch

***********************************************************

* Variable fuer Episodentypen erstellen

gen eb_typ=.

replace eb_typ=5 if eb_befr==1

replace eb_typ=4 if eb_al==1

replace eb_typ=3 if eb_bild==1

replace eb_typ=2 if eb_sonst==1

replace eb_typ=1 if eb_unbefr==1

***********************************************************

* Konkurrierende Ereignisse invertieren

gen pb4_event_inv=1 if pb4_event==0
replace pb4_event_inv=0 if pb4_event==1

gen pb1_event_inv=1 if pb1_event==0
replace pb1_event_inv=0 if pb1_event==1

gen pb8_event_inv=1 if pb8_event==0
replace pb8_event_inv=0 if pb8_event==1

***********************************************************

* Interaktionseffekt aus Episodentyp und Alter

gen eb_befr_rel_proz_X_v7=eb_befr_rel_proz*v7
gen eb_bild_rel_proz_X_v7=eb_bild_rel_proz*v7
gen eb_al_rel_proz_X_v7=eb_al_rel_proz*v7
gen eb_sonst_rel_proz_X_v7=eb_sonst_rel_proz*v7

* Interaktionseffekt aus Episodentyp und quadriertem Alter

gen eb_befr_rel_proz_X_v7_jahre_q=eb_befr_rel_proz*v7_jahre_q
gen eb_bild_rel_proz_X_v7_jahre_q=eb_bild_rel_proz*v7_jahre_q
gen eb_al_rel_proz_X_v7_jahre_q=eb_al_rel_proz*v7_jahre_q
gen eb_sonst_rel_proz_X_v7_jahre_q=eb_sonst_rel_proz*v7_jahre_q


***********************************************************
***********************************************************
*****
*****

set more off
	
	
***********************************************************

* Analysen durchfuehren mit Episoden ab Alter 18

* Episoden loeschen, wenn Alter <18

drop if v7_jahre<18

*****

* log using D:\Habilschrift\Analysen_Kap5_neu\STATA-logfiles\190327-log, replace

set more off

sort id gt

*****

* Alle Faelle mit fehlenden Angaben zu eb_count und daraus resultierenden fehlenden Werte bei relativen eb-Anteilen loeschen

drop if eb_count_kontroll<99

***********************************************************
****************************
****************************
****************************
***********************************************************

* Aufbereitung abgeschlossen, Datensatz speichern

save "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Daten\Daten_AGIPEB_30-STATA_pb2_work.dta", replace

***********************************************************

use "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Daten\Daten_AGIPEB_30-STATA_pb2_work.dta"

set more off

* Runden der Anteilswerte fuer spaeter mi-marginsplot

replace eb_unbefr_rel_proz=round(eb_unbefr_rel_proz)
replace eb_befr_rel_proz=round(eb_befr_rel_proz)
replace eb_bild_rel_proz=round(eb_bild_rel_proz)
replace eb_al_rel_proz=round(eb_al_rel_proz)
replace eb_sonst_rel_proz=round(eb_sonst_rel_proz)

replace v7_jahre=round(v7_jahre)
replace v7_jahre_q=round(v7_jahre_q)

***********************************************************

* MI set

* Alte MI-Variablen loeschen

* mi set mlong
	
***********************************************************

* Deskriptive Analysen:

* Fallzahlen:

stdes

* Maenner:

stdes if v8_m==1

* Frauen:

stdes if v8_m==0

* Befristungs- und Unbefristungsstatistiken

stdes if eb_befr_rel_proz==100
stdes if v8_m==1
stdes if eb_befr_rel_proz==100 & v8_m==1
stdes if v158_zentr_m>0 & eb_befr_rel_proz==100 & v8_m==1

stsum if eb_befr_rel_proz==100 & v8_m==1

stdes if eb_unbefr_rel_proz==100

* Mittelwerte

* Männer:

	estpost tabstat ///
	eb_unbefr_rel_proz eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	v158 v7_jahre pb1_event v192_abifh v391_dummy v398_dich pb_2jahr1 pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1, statistics(mean sd) columns(statistics)
	
	eststo descr_m1
	
	esttab descr_m1 using "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Tabellen\210824 DESKRIPTION - MAENNER.rtf", replace ///
	title(Tab. xy: Deskriptive Statistiken) ///
	cells("mean(label(MW) fmt(2)) sd(label(SD) fmt(2))") varwidth(30) unstack nonumber ///
	nonotes addnote("Quelle: AGIPEB-Studie 2012/13. MW = Mittelwert, SD = Standardabweichung.") ///
	fonttbl(\f0\fnil arial; ) compress nogaps
	
***

stsum if v8_m==1, by(v158)
	
stsum if v8_m==1, by(pb1_event)

stsum if v8_m==1, by(v192_abifh)

stsum if v8_m==1, by(v391_dummy)

stsum if v8_m==1, by(v398_dich)

* Frauen:

	estpost tabstat ///
	eb_unbefr_rel_proz eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	v158 v7_jahre pb1_event v192_abifh v391_dummy v398_dich pb_2jahr1 pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0, statistics(mean sd) columns(statistics)
	
	eststo descr_f1
	
	esttab descr_f1 using "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Tabellen\210824 DESKRIPTION - FRAUEN.rtf", replace ///
	title({Tab. xy: Deskriptive Statistiken}) ///
	cells("mean(label(MW) fmt(2)) sd(label(SD) fmt(2))") varwidth(30) unstack nonumber ///
	nonotes addnote("Quelle: AGIPEB-Studie 2012/13. MW = Mittelwert, SD = Standardabweichung.") ///
	fonttbl(\f0\fnil arial; ) compress nogaps
	
***

stsum if v8_m==0, by(v158)
	
stsum if v8_m==0, by(pb1_event)

stsum if v8_m==0, by(v192_abifh)

stsum if v8_m==0, by(v391_dummy)

stsum if v8_m==0, by(v398_dich)

***

* Zentrierung v158 vornehmen

* v158 zentrieren fuer Maenner

sum v158 if v8_m==1

gen v158_zentr_m=.

replace v158_zentr_m=v158-r(mean) if v8_m==1

sum v158_zentr_m

* v158 zentrieren fuer Frauen

sum v158 if v8_m==0

gen v158_zentr_f=.

replace v158_zentr_f=v158-r(mean) if v8_m==0

sum v158_zentr_f
	
*************************************************

* KM-Schaetzer

* Vergleiche Maenner vs. Frauen

sts list, by(v8_m) compare

sts test v8_m, wilcoxon

sts graph if pb_dauer<=180, ///
by(v8_m)																			/// unterscheiden zwischen Maennern und Frauen
fail 																				/// graph starts at the bottom of the >-axis instead of the top
title("Erstes gemeinsames Kind (n=384)")	 										/// title
xtitle("Analysezeit (Monate)") 														/// X-title
ytitle("Kumulierte Anteile realisierter Ereignisse") 								/// Y-title
xlabel(0 12 24 36 48 60 72 84 96 108 120 132 144 156 168 180) 						/// X-labels
ylabel(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%", angle(0)) 						/// Y-labels
plot1(lpattern(solid)lcolor(black))													///
plot2(lpattern(dash)lcolor(black))													///
legend(label(1 Männer (n=135)) label(2 Frauen (n=249)))								/// Label legend
scheme(s1mono)																		// Color scheme

* Export graph

graph export "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Plots\pb2 - kind - Maenner vs Frauen.png", replace width(2000)	// format: PNG (for manuscript)
graph export "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Plots\pb2 - kind - Maenner vs Frauen.tif", replace width(2000)	// format: TIFF (for upload)

* Subgruppenanalysen zu Befristungsanalyse

* Maenner - befristet vs. unbefristet

sts list if v8_m==1, by(v500) compare

sts test v500 if v8_m==1, wilcoxon
	
sts graph if v8_m==1 & pb_dauer<=180, by(v500)										///
fail 																				/// graph starts at the bottom of the >-axis instead of the top
title("Erstes gemeinsames Kind (Männer, n=135)")	 								/// title
xtitle("Analysezeit (Monate)") 														/// X-title
ytitle("Kumulierte Anteile realisierter Ereignisse") 								/// Y-title
xlabel(0 12 24 36 48 60 72 84 96 108 120 132 144 156 168 180) 						/// X-labels
ylabel(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%", angle(0)) 						/// Y-labels
plot1(lpattern(solid)lcolor(black))													///
plot2(lpattern(dash)lcolor(black))													///
legend(label(1 Nie befristet, n=77) label(2 Mind. einmal befristet, n=55))			/// Label legend
scheme(s1mono)																		// Color scheme

* Export graph

graph export "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Plots\pb2 - kind - Maenner Befr vs nie befr.png", ///
replace width(2000)	// format: PNG (for manuscript)

graph export "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Plots\pb2 - kind - Maenner Befr vs nie befr.tif", ///
replace width(2000)	// format: TIFF (for upload)

* Frauen - befristet vs. unbefristet

sts list if v8_m==0, by(v500) compare
	
sts test v500 if v8_m==0, wilcoxon

sts graph if v8_m==0 & pb_dauer<=180, by(v500)										///
fail 																				/// graph starts at the bottom of the >-axis instead of the top
title("Erstes gemeinsames Kind (Frauen, n=249)")	 								/// title
xtitle("Analysezeit (Monate)") 														/// X-title
ytitle("Kumulierte Anteile realisierter Ereignisse") 								/// Y-title
xlabel(0 12 24 36 48 60 72 84 96 108 120 132 144 156 168 180) 						/// X-labels
ylabel(0 "0%" .25 "25%" .5 "50%" .75 "75%" 1 "100%", angle(0)) 						/// Y-labels
plot1(lpattern(solid)lcolor(black))													///
plot2(lpattern(dash)lcolor(black))													///
legend(label(1 Nie befristet, n=123) label(2 Mind. einmal befristet, n=126))		/// Label legend
scheme(s1mono)			

* Export graph

graph export "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Plots\pb2 - kind - Frauen Befr vs nie befr.png", ///
replace width(2000)	// format: PNG (for manuscript)

graph export "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Plots\pb2 - kind - Frauen Befr vs nie befr.tif", ///
replace width(2000)	// format: TIFF (for upload)

***********************************************************

* Interaktionen 

* Bei einem Monat, den es dauert bis ein Wechsel auf eine unbefristete Stelle erfolgt, veraendert sich die Uebergangsrate in Kohabitation um ... Prozent:

* display ((exp(-.1946189))-1)*100

* Bei zehn Monaten, die es dauert bis ein Wechsel auf eine unbefristete Stelle erfolgt, veraendert sich die Uebergangsrate in Kohabitation um ... Prozent:

* display ((exp(-.1946189*10))-1)*100
	
*************************************************

* log using "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Logs\210801-pb2_MfS_Analysen_ALLE", replace

* Neue Modelle pb2 - 1.8.21 - FRAUEN UND MAENNER

***************************************************************

* HAUPTANALYSEN: Dauer bis Entfristung + Geschlechterrollenbilder I ('Berufstaetige Mutter gleiches Verhaeltnis wie nicht berufstaetige', v158)

* inkl. work around fuer esttab, s.: https://www.statalist.org/forums/forum/general-stata-discussion/general/1013-esttab-and-mi-no-stored-results

* (1) MAENNER

* Modell 1: Anreizbasierte Hypothesen (1-3)

	eststo A: mi estimate, post: logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	c.eb_befr_rel_proz#c.eb_befr_rel_proz c.eb_bild_rel_proz#c.eb_bild_rel_proz c.eb_al_rel_proz#c.eb_al_rel_proz c.eb_sonst_rel_proz#c.eb_sonst_rel_proz ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1
	
	mi estimate, hr
	
	estadd hr

* Modell 1 - Vergleich: Ohne multiple Imputation

	logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	c.eb_befr_rel_proz#c.eb_befr_rel_proz c.eb_bild_rel_proz#c.eb_bild_rel_proz c.eb_al_rel_proz#c.eb_al_rel_proz c.eb_sonst_rel_proz#c.eb_sonst_rel_proz ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1
	
* Kontrolle: Modell ohne Selbst-Interaktionen der Episodenvariablen
	
	mi estimate: logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1
	
	mi estimate, hr
	
* Kontrolle: Modell ohne Selbst-Interaktionen der Episodenvariablen und ohne Kontrollvariablen
	
	mi estimate: logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1
	
	mi estimate, hr
	
***

* Modell 2: Normenbasierte Hypothesen (4 und 5)

	eststo B: mi estimate, post: logit _d v158_zentr_m ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1
	
	mi estimate, hr
	
* Modell 2 - Vergleich: Ohne multiple Imputation

	logit _d v158_zentr_m ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1
	
* Kontrolle: Ohne Kontrollvariablen

	mi estimate: logit _d v158_zentr_m ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1
	
	mi estimate, hr
	
***

* Modell 3: Hypothesen ueber Wechselwirkung (6a und 6b)

	eststo C: mi estimate, post: logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz v158_zentr_m ///
	c.eb_befr_rel_proz#c.v158_zentr_m c.eb_bild_rel_proz#c.v158_zentr_m c.eb_al_rel_proz#c.v158_zentr_m c.eb_sonst_rel_proz#c.v158_zentr_m ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1

***

* Punktschaetzer ermitteln fuer verschiedene Linearkombinationen auf Basis Modell (3) (nur Maenner)

* Befristungsanteil: 				10 Prozent
* Einstellung erwerbst. Mutter:		+1 oberhalb MW (eher LIBERAL)

lincom eb_befr_rel_proz + 10*c.eb_befr_rel_proz#c.v158_zentr_m*1, or

* Befristungsanteil: 				50 Prozent
* Einstellung erwerbst. Mutter:		+1 oberhalb MW (eher LIBERAL)

lincom eb_befr_rel_proz + 50*c.eb_befr_rel_proz#c.v158_zentr_m*1, or

* Befristungsanteil: 				100 Prozent
* Einstellung erwerbst. Mutter:		+1 oberhalb MW (eher LIBERAL)

lincom eb_befr_rel_proz + 100*c.eb_befr_rel_proz#c.v158_zentr_m*1, or

**

* Befristungsanteil: 				10 Prozent
* Einstellung erwerbst. Mutter:		-1 oberhalb MW (eher TRADITIONELL)

lincom eb_befr_rel_proz + 10*c.eb_befr_rel_proz#c.v158_zentr_m*-1, or

* Befristungsanteil: 				50 Prozent
* Einstellung erwerbst. Mutter:		-1 oberhalb MW (eher TRADITIONELL)

lincom eb_befr_rel_proz + 50*c.eb_befr_rel_proz#c.v158_zentr_m*-1, or

* Befristungsanteil: 				100 Prozent
* Einstellung erwerbst. Mutter:		-1 oberhalb MW (eher TRADITIONELL)

lincom eb_befr_rel_proz + 100*c.eb_befr_rel_proz#c.v158_zentr_m*-1, or

**

* Weitere Linearkombinationen:

* Befristungsanteil: 			0 Prozent
* Einstellung erwerbst. Mutter:		-2 oberhalb MW (sehr TRADITIONELL)

lincom eb_befr_rel_proz + 0*c.eb_befr_rel_proz#c.v158_zentr_m*-2, or

* Befristungsanteil: 			0 Prozent
* Einstellung erwerbst. Mutter:		-1 oberhalb MW (eher TRADITIONELL)

lincom eb_befr_rel_proz + 0*c.eb_befr_rel_proz#c.v158_zentr_m*-1, or

* Befristungsanteil: 			0 Prozent
* Einstellung erwerbst. Mutter:		 oberhalb MW (teils teils)

lincom eb_befr_rel_proz + 0*c.eb_befr_rel_proz#c.v158_zentr_m*0, or

* Befristungsanteil: 			0 Prozent
* Einstellung erwerbst. Mutter:		+1 oberhalb MW (eher LIBERAL)

lincom eb_befr_rel_proz + 0*c.eb_befr_rel_proz#c.v158_zentr_m*1, or

* Befristungsanteil: 			0 Prozent
* Einstellung erwerbst. Mutter:		+2 oberhalb MW (sehr LIBERAL)

lincom eb_befr_rel_proz + 0*c.eb_befr_rel_proz#c.v158_zentr_m*2, or


**

* Weitere Linearkombinationen:

* Befristungsanteil: 			100 Prozent
* Einstellung erwerbst. Mutter:		-2 oberhalb MW (sehr TRADITIONELL)

lincom eb_befr_rel_proz + 100*c.eb_befr_rel_proz#c.v158_zentr_m*-2, or

* Befristungsanteil: 			100 Prozent
* Einstellung erwerbst. Mutter:		-1 oberhalb MW (eher TRADITIONELL)

lincom eb_befr_rel_proz + 100*c.eb_befr_rel_proz#c.v158_zentr_m*-1, or

* Befristungsanteil: 			100 Prozent
* Einstellung erwerbst. Mutter:		 oberhalb MW (teils teils)

lincom eb_befr_rel_proz + 100*c.eb_befr_rel_proz#c.v158_zentr_m*0, or

* Befristungsanteil: 			100 Prozent
* Einstellung erwerbst. Mutter:		+1 oberhalb MW (eher LIBERAL)

lincom eb_befr_rel_proz + 100*c.eb_befr_rel_proz#c.v158_zentr_m*1, or

* Befristungsanteil: 			100 Prozent
* Einstellung erwerbst. Mutter:		+2 oberhalb MW (sehr LIBERAL)

lincom eb_befr_rel_proz + 100*c.eb_befr_rel_proz#c.v158_zentr_m*2, or

	mi estimate, or
	
***

* Modell 3 - Vergleich: Ohne Imputation

	logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz v158_zentr_m ///
	c.eb_befr_rel_proz#c.v158_zentr_m c.eb_bild_rel_proz#c.v158_zentr_m c.eb_al_rel_proz#c.v158_zentr_m c.eb_sonst_rel_proz#c.v158_zentr_m ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1
	
*** Fuer Word-Tabelle:

esttab A B C using "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Tabellen\210914 EDA - MAENNER.rtf", replace ///
title({Tabelle xy:} {Übergänge in Elternschaft: Männer}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3") ///
cells("b (star fmt(3) label(HR)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") eform starlevels(+ 0.10 * 0.05 ** 0.01  *** 0.001) ///
stats(F p N, fmt(2 3 0) labels("F-Test" "Emp. Signif. F-Test" "n (Personenmonate)")) constant ///
nonotes addnote("Quelle: AGIPEB-Studie 2012/13. Zeitdiskrete Ereignisdatenanalysen mit stückweise konstanten Übergangsraten und multipler Imputation (insgesamt 42 imputierte Fälle)." ///
"HR = Hazard Ratio, SE = Standardfehler, p = empirische Signifikanz." ///
"*** p < 0,001, ** p < 0,01, * p < 0,05, + p < 0,10.") ///
fonttbl(\f0\fnil arial; ) compress nogaps

*************************************************

* (2) FRAUEN

* Modell 1: Anreizbasierte Hypothesen (1-3)

	eststo D: mi estimate, post: logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	c.eb_befr_rel_proz#c.eb_befr_rel_proz c.eb_bild_rel_proz#c.eb_bild_rel_proz c.eb_al_rel_proz#c.eb_al_rel_proz c.eb_sonst_rel_proz#c.eb_sonst_rel_proz ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0
	
	mi estimate, hr

* Modell 1 - Vergleich: Ohne multiple Imputation

	logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	c.eb_befr_rel_proz#c.eb_befr_rel_proz c.eb_bild_rel_proz#c.eb_bild_rel_proz c.eb_al_rel_proz#c.eb_al_rel_proz c.eb_sonst_rel_proz#c.eb_sonst_rel_proz ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0
	
* Kontrolle: Modell ohne Selbst-Interaktionen der Episodenvariablen
	
	mi estimate: logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0
	
	mi estimate, hr
	
* Kontrolle: Modell ohne Selbst-Interaktionen der Episodenvariablen und ohne Kontrollvariablen
	
	mi estimate: logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0
	
	mi estimate, hr
	
***

* Modell 2: Normenbasierte Hypothesen (4 und 5)

	eststo E: mi estimate, post: logit _d v158_zentr_f ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0
	
	mi estimate, hr
	
* Modell 2 - Vergleich: Ohne multiple Imputation

	logit _d v158_zentr_f ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0
	
* Kontrolle: Ohne Kontrollvariablen

	mi estimate: logit _d v158_zentr_f ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0
	
	mi estimate, hr
	
***

* Modell 3: Hypothesen ueber Wechselwirkung (6a und 6b)

	eststo F: mi estimate, post: logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz v158_zentr_f ///
	c.eb_befr_rel_proz#c.v158_zentr_f c.eb_bild_rel_proz#c.v158_zentr_f c.eb_al_rel_proz#c.v158_zentr_f c.eb_sonst_rel_proz#c.v158_zentr_f ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0
	
	mi estimate, or

* Modell 3 - Vergleich: Ohne Imputation

	logit _d eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz v158_zentr_f ///
	c.eb_befr_rel_proz#c.v158_zentr_f c.eb_bild_rel_proz#c.v158_zentr_f c.eb_al_rel_proz#c.v158_zentr_f c.eb_sonst_rel_proz#c.v158_zentr_f ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0

*** Fuer Word-Tabelle:

esttab D E F using "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Tabellen\210914 EDA - FRAUEN.rtf", replace ///
title({Tabelle xy:} {Übergänge in Elternschaft: Frauen}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3" "Modell 4") ///
cells("b (star fmt(3) label(HR)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") eform starlevels(+ 0.10 * 0.05 ** 0.01 *** 0.001) ///
stats(F p N, fmt(2 3 0) labels("F-Test" "Emp. Signif. F-Test" "n (Personenmonate)")) constant ///
nonotes addnote("Quelle: AGIPEB-Studie 2012/13. Zeitdiskrete Ereignisdatenanalysen mit stückweise konstanten Übergangsraten und multipler Imputation (insgesamt 42 imputierte Fälle)." ///
"HR = Hazard Ratio, SE = Standardfehler, p = empirische Signifikanz." ///
"*** p < 0,001, ** p < 0,01, * p < 0,05, + p < 0,10.") ///
fonttbl(\f0\fnil arial; ) compress nogaps
	
*************************************************

* Robustheitsanalysen mit eb_count-Variablen - NUR MAENNER
		
	mi estimate: logit _d eb_befr_count eb_bild_count eb_al_count eb_sonst_count v158_zentr_m ///
	c.eb_befr_count#c.v158_zentr_m c.eb_bild_count#c.v158_zentr_m c.eb_al_count#c.v158_zentr_m c.eb_sonst_count#c.v158_zentr_m ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1, dist(exp)
	
* Ohne multiple Imputation - NUR MAENNER

	logit _d eb_befr_count eb_bild_count eb_al_count eb_sonst_count v158_zentr_m ///
	c.eb_befr_count#c.v158_zentr_m c.eb_bild_count#c.v158_zentr_m c.eb_al_count#c.v158_zentr_m c.eb_sonst_count#c.v158_zentr_m ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1, dist(exp)
	
***

* Robustheitsanalysen mit eb_count-Variablen - NUR FRAUEN
		
	mi estimate: logit _d eb_befr_count eb_bild_count eb_al_count eb_sonst_count v158_zentr_f ///
	c.eb_befr_count#c.v158_zentr_f c.eb_bild_count#c.v158_zentr_f c.eb_al_count#c.v158_zentr_f c.eb_sonst_count#c.v158_zentr_f ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0, dist(exp)
	
* Ohne multiple Imputation - NUR FRAUEN

	logit _d eb_befr_count eb_bild_count eb_al_count eb_sonst_count v158_zentr_f ///
	c.eb_befr_count#c.v158_zentr_f c.eb_bild_count#c.v158_zentr_f c.eb_al_count#c.v158_zentr_f c.eb_sonst_count#c.v158_zentr_f ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0, dist(exp)

*************************************************
*************************************************

* Verteilungs- und Fitvergleiche der Ausgangsmodelle

* Jeweils fuer alle Personen, ohne MI (n=878)

* Vgl. Blossfeld et al. 2007: 218-222, Brüderl/Diekmann 1995

* Piecewise Exponential Model:

sort id pb_dauer

drop _st
drop _d
drop _t
drop _t0
* drop T0

mi stset pb_end, id(id) time0(pb_start) origin(time pb_start) failure(pb2_fail==1)

	eststo X: mi estimate, post: streg eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz v158_zentr ///
	c.eb_befr_rel_proz#c.v158_zentr c.eb_bild_rel_proz#c.v158_zentr c.eb_al_rel_proz#c.v158_zentr c.eb_sonst_rel_proz#c.v158_zentr ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	, dist(exp) hr
	
	predict residual, csnell
	mi stset residual, failure(pb2_fail)
	sts gen km = s 
	generate cumhaz = -ln(km)
	line cumhaz residual residual, sort name("exponential, replace") ///
	legend(off) t1(Exponential) xtitle("")
	drop cumhaz residual km
	
* Log-logistic

sort id pb_dauer

drop _st
drop _d
drop _t
drop _t0
* drop T0

mi stset pb_end, id(id) time0(pb_start) origin(time pb_start) failure(pb2_fail==1)

	eststo Y: mi estimate, post: streg eb_befr_rel_proz eb_bild_rel_proz eb_al_rel_proz eb_sonst_rel_proz v158_zentr ///
	c.eb_befr_rel_proz#c.v158_zentr c.eb_bild_rel_proz#c.v158_zentr c.eb_al_rel_proz#c.v158_zentr c.eb_sonst_rel_proz#c.v158_zentr ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	, dist(loglogistic) hr
	
	predict residual, csnell
	mi stset residual, failure(pb2_fail)
	sts gen km = s 
	generate cumhaz = -ln(km)
	line cumhaz residual residual, sort name("llogigistic, replace") ///
	legend(off) t1(Log-logistic) xtitle("")
	drop cumhaz residual km
	
esttab Y Z using "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Tabellen\210824 EDA - Fitvergleiche.rtf", replace ///
title({Tabelle xy:} {Übergänge in Elternschaft: Fitvergleiche Piecewise Constant vs. Loglogistic Modell}) ///
nonumbers mtitles("Modell: PWC" "Modell: LL") ///
cells("b (star fmt(3) label(HR)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") eform starlevels(+ 0.10 * 0.05 ** 0.01) ///
stats(ll chi2 N_sub N_fail risk, fmt(2 2 0 0 0) labels("Log-likelihood" "LR-test (Chi^2)" "n (Personen)" "n (Ereignisse) n (Personenmonate)")) constant ///
nonotes addnote("Quelle: AGIPEB-Studie 2012/13. Modelle ohne multiple Imputation. Männer und Frauen." ///
"HR = Hazard Ratio, SE = Standardfehler, p = empirische Signifikanz." ///
"** p < 0,01, * p < 0,05, + p < 0,10.") ///
fonttbl(\f0\fnil arial; ) compress nogaps
	
*************************************************
*************************************************

* Exportiere Logfiles in PDF

* translate "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Logs\pb2_MfS_Analysen_ALLE.smcl" ///
* "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Logs\210801-pb2_MfS_Analysen_ALLE.pdf", replace

* translate "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Logs\pb2_MfS_Analysen_FRAUEN.smcl" ///
* "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Logs\210801-pb2_MfS_Analysen_FRAUEN.pdf", replace

* translate "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Logs\pb2_MfS_Analysen_MAENNER.smcl" ///
* "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Logs\210801-pb2_MfS_Analysen_MAENNER.pdf", replace

*************************************************
*************************************************

* Ergaenzung: Modelle mit Befristungsepisoden statt -anteilen

***

* MAENNER

* Modell 1: Befristungsepisoden --> Dauer bis Elternschaft

	eststo I: mi estimate, post: streg eb_befr eb_bild eb_al eb_sonst ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1, dist(exp)
	
***

* Modell 2: Befristungsepisoden + Interaktion mit v158 --> Dauer bis Elternschaft

	eststo J: mi estimate, post: streg eb_befr eb_bild eb_al eb_sonst v158_zentr_m ///
	c.eb_befr#c.v158_zentr_m c.eb_bild#c.v158_zentr_m c.eb_al#c.v158_zentr_m c.eb_sonst#c.v158_zentr_m /// ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1, dist(exp)
	
***

* Modell 3: Befristungsepisoden + Interaktion mit v158 + Kontrollvariablen --> Dauer bis Elternschaft

	eststo K: mi estimate, post: streg eb_befr eb_bild eb_al eb_sonst v158_zentr_m ///
	c.eb_befr#c.v158_zentr_m c.eb_bild#c.v158_zentr_m c.eb_al#c.v158_zentr_m c.eb_sonst#c.v158_zentr_m /// ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==1, dist(exp)
	
*** Fuer Word-Tabelle:

esttab I J K using "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Tabellen\210824 EDA - MAENNER - Episodenanalysen.rtf", replace ///
title({Tabelle xy:} {Übergänge in Elternschaft: Männer (Piecewise Constant Modelle mit multipler Imputation)}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3" "Modell 4") ///
cells("b (star fmt(3) label(HR)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") eform starlevels(+ 0.10 * 0.05 ** 0.01) ///
stats(F p N, fmt(2 3 0) labels("F-Test" "Emp. Signif. F-Test" "n (Personenmonate)")) constant ///
nonotes addnote("Quelle: AGIPEB-Studie 2012/13. Piecewise Constant Modell mit multipler Imputation (insgesamt 42 imputierte Fälle)." ///
"HR = Hazard Ratio, SE = Standardfehler, p = empirische Signifikanz." ///
"** p < 0,01, * p < 0,05, + p < 0,10.") ///
fonttbl(\f0\fnil arial; ) compress nogaps

***

* FRAUEN

* Modell 1: Befristungsepisoden --> Dauer bis Elternschaft

	eststo M: mi estimate, post: streg eb_befr eb_bild eb_al eb_sonst ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0, dist(exp)
	
***

* Modell 2: Befristungsepisoden + Interaktion mit v158 --> Dauer bis Elternschaft

	eststo N: mi estimate, post: streg eb_befr eb_bild eb_al eb_sonst v158_zentr_f ///
	c.eb_befr#c.v158_zentr_f c.eb_bild#c.v158_zentr_f c.eb_al#c.v158_zentr_f c.eb_sonst#c.v158_zentr_f ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0, dist(exp)
	
***

* Modell 3: Befristungsepisoden + Interaktion mit v158 + Kontrollvariablen --> Dauer bis Elternschaft

	eststo O: mi estimate, post: streg eb_befr eb_bild eb_al eb_sonst v158_zentr_f ///
	c.eb_befr#c.v158_zentr_f c.eb_bild#c.v158_zentr_f c.eb_al#c.v158_zentr_f c.eb_sonst#c.v158_zentr_f ///
	v7_jahre v7_jahre_q i.pb1_event i.v192_abifh i.v391_dummy i.v398_dich ///
	pb_2jahr2 pb_2jahr3 pb_2jahr4 pb_2jahr5 pb_2jahr6 ///
	if v8_m==0, dist(exp)
	
*** Fuer Word-Tabelle:

esttab M N O using "E:\Habilschrift\Analysen Kap6_4 - Institutionalisierung Befristung MfS\Stata Tabellen\210824 EDA - FRAUEN - Episodenanalysen.rtf", replace ///
title({Tabelle xy:} {Übergänge in Elternschaft: Frauen (Piecewise Constant Modelle mit multipler Imputation)}) ///
nonumbers mtitles("Modell 1" "Modell 2" "Modell 3" "Modell 4") ///
cells("b (star fmt(3) label(HR)) se(par fmt(2) label(SE)) p(fmt(3) label(p))") eform starlevels(+ 0.10 * 0.05 ** 0.01) ///
stats(F p N, fmt(2 3 0) labels("F-Test" "Emp. Signif. F-Test" "n (Personenmonate)")) constant ///
nonotes addnote("Quelle: AGIPEB-Studie 2012/13. Piecewise Constant Modell mit multipler Imputation (insgesamt 42 imputierte Fälle)." ///
"HR = Hazard Ratio, SE = Standardfehler, p = empirische Signifikanz." ///
"** p < 0,01, * p < 0,05, + p < 0,10.") ///
fonttbl(\f0\fnil arial; ) compress nogaps

****