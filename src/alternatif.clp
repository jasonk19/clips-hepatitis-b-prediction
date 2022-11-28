(defrule system-banner ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Program Deteksi Penyakit Hepatitis B")
  (printout t crlf crlf))

(defrule HBsAG
=>
(printout t "HBsAG [positive/negative]? ")
(bind ?x (read))
(while (neq ?x positive or negative) 
  (printout t crlf "Accepted Value: positive/negative" crlf)
  (printout t "HBsAG [positive/negative]? ")
  (bind ?x (read)))
(assert (HBsAG ?x)))

(defrule anti-HDV
(HBsAG positive)
=>
(printout t "anti-HDV [positive/negative]? ")
(bind ?x (read))
(while (neq ?x positive or negative) 
  (printout t crlf "Accepted Value: positive/negative" crlf)
  (printout t "anti-HDV [positive/negative]? ")
  (bind ?x (read)))
(assert (anti-HDV ?x)))

(defrule HepatitisBD
(and (HBsAG positive)
(anti-HDV positive))
=>
(printout t crlf "Hasil Prediksi = Hepatitis B+D" crlf)
(assert (HepatitisBD)))

(defrule anti-HBc1
(and (HBsAG positive)
(anti-HDV negative))
=>
(printout t "anti-HBc [positive/negative]? ")
(bind ?x (read))
(while (neq ?x positive or negative) 
  (printout t crlf "Accepted Value: positive/negative" crlf)
  (printout t "anti-HBc [positive/negative]? ")
  (bind ?x (read)))
(assert (anti-HBc1 ?x)))

(defrule UncertainConfiguration1
(and (HBsAG positive)
(anti-HDV negative)
(anti-HBc1 negative))
=>
(printout t crlf "Hasil Prediksi = Uncertain Configuration" crlf)
(assert (UncertainConfiguration1)))

(defrule anti-HBs1
(and (HBsAG positive)
(anti-HDV negative)
(anti-HBc1 positive))
=>
(printout t "anti-HBs [positive/negative]? ")
(bind ?x (read))
(while (neq ?x positive or negative) 
  (printout t crlf "Accepted Value: positive/negative" crlf)
  (printout t "anti-HBs [positive/negative]? ")
  (bind ?x (read)))
(assert (anti-HBs1 ?x)))

(defrule UncertainConfiguration2
(and (HBsAG positive)
(anti-HDV negative)
(anti-HBc1 positive)
(anti-HBs1 positive))
=>
(printout t crlf "Hasil Prediksi = Uncertain Configuration" crlf)
(assert (UncertainConfiguration2)))

(defrule IgM_anti-HBc
(and (HBsAG positive)
(anti-HDV negative)
(anti-HBc1 positive)
(anti-HBs1 negative))
=>
(printout t "IgM anti-HBc [positive/negative]? ")
(bind ?x (read))
(while (neq ?x positive or negative) 
  (printout t crlf "Accepted Value: positive/negative" crlf)
  (printout t "IgM anti-HBc [positive/negative]? ")
  (bind ?x (read)))
(assert (IgM_anti-HBc ?x)))

(defrule AcuteInfection
(and (HBsAG positive)
(anti-HDV negative)
(anti-HBc1 positive)
(anti-HBs1 negative)
(IgM_anti-HBc positive))
=>
(printout t crlf "Hasil Prediksi = Acute Infection" crlf)
(assert (acute-Infection)))

(defrule ChronicInfection
(and (HBsAG positive)
(anti-HDV negative)
(anti-HBc1 positive)
(anti-HBs1 negative)
(IgM_anti-HBc negative))
=>
(printout t crlf "Hasil Prediksi = Chronic Infection" crlf)
(assert (chronic-Infection)))

(defrule anti-HBs2
(HBsAG negative)
=>
(printout t "anti-HBs [positive/negative]? ")
(bind ?x (read))
(while (neq ?x positive or negative) 
  (printout t crlf "Accepted Value: positive/negative" crlf)
  (printout t "anti-HBs [positive/negative]? ")
  (bind ?x (read)))
(assert (anti-HBs2 ?x)))

(defrule anti-HBc2
(and (HBsAG negative)
(anti-HBs2 positive))
=>
(printout t "anti-HBc [positive/negative]? ")
(bind ?x (read))
(while (neq ?x positive or negative) 
  (printout t crlf "Accepted Value: positive/negative" crlf)
  (printout t "anti-HBc [positive/negative]? ")
  (bind ?x (read)))
(assert (anti-HBc2 ?x)))

(defrule Cured
(and (HBsAG negative)
(anti-HBs2 positive)
(anti-HBc2 positive))
=>
(printout t crlf "Hasil Prediksi = Cured" crlf)
(assert (cured)))
 
(defrule Vaccinated
(and (HBsAG negative)
(anti-HBs2 positive)
(anti-HBc2 negative))
=>
(printout t crlf "Hasil Prediksi = Vaccinated" crlf)
(assert (vaccinated)))

(defrule anti-HBc3
(and (HBsAG negative)
(anti-HBs2 negative))
=>
(printout t "anti-HBc [positive/negative]? ")
(bind ?x (read))
(while (neq ?x positive or negative) 
  (printout t crlf "Accepted Value: positive/negative" crlf)
  (printout t "anti-HBc [positive/negative]? ")
  (bind ?x (read)))
(assert (anti-HBc3 ?x)))

(defrule Unclear
(and (HBsAG negative)
(anti-HBs2 negative)
(anti-HBc3 positive))
=>
(printout t crlf "Hasil Prediksi = Unclear (possible resolved)" crlf)
(assert (unclear)))

(defrule Healthy
(and (HBsAG negative)
(anti-HBs2 negative)
(anti-HBc3 negative))
=>
(printout t crlf "Hasil Prediksi = Healthy not vaccinated or suspicious" crlf)
(assert (healthy)))