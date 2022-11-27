(deftemplate Person
    (slot NAME (type SYMBOL) (default ?NONE))
    (multislot Features)
)
(deftemplate Classification
    (slot NAME (type SYMBOL) (default ?NONE))
    (slot Disease (type SYMBOL) (default ?NONE))
    (slot Flag (type INTEGER) (default 0))
)

(defrule Init
    =>
    (printout t "Your name? > ")
    (bind ?x (read))
    (assert (Person (NAME ?x) (Features "")))
)

(defrule ToRoot
    (Person (NAME ?x))
    =>
    (assert (Classification (NAME ?x)
            (Disease HepatitisDisease)))
)

(defrule IsHBsAG (declare (salience 10))
    (Classification (NAME ?x) (Disease HepatitisDisease))  
    ?d <- (Person (NAME ?x) (Features $?y))
    (not (Person (NAME ?x) (Features $?l HBsAG $?r)))
    =>
    (printout t ?x ": HBsAG (positive/negative)? > ")
    (bind ?HBsAG (read))
    (while (neq ?HBsAG positive or negative) 
        (println "Accepted Value: positive/negative")
        (printout t ?x ": HBsAG (positive/negative)? > ")
        (bind ?HBsAG (read)))
    (if (eq ?HBsAG positive) then (modify ?d (Features $?y HBsAG positive)))
    (if (eq ?HBsAG negative) then (modify ?d (Features $?y HBsAG negative)))
)

(defrule ToAntiHDV
    (Classification (NAME ?x) (Disease HepatitisDisease))
    (Person (NAME ?x) (Features $?s HBsAG positive $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease AntiHDV)))
)

(defrule IsAntiHDV (declare (salience 8))
    (Classification (NAME ?x) (Disease AntiHDV))  
    ?d <- (Person (NAME ?x) (Features $?y))
    (not (Person (NAME ?x) (Features $?l AntiHDV $?r)))
    =>
    (printout t ?x ": anti-HDV (positive/negative)? > ")
    (bind ?AntiHDV (read))
    (while (neq ?AntiHDV positive or negative) 
        (println "Accepted Value: positive/negative")
        (printout t ?x ": AntiHDV (positive/negative)? > ")
        (bind ?AntiHDV (read)))
    (if (eq ?AntiHDV positive) then (modify ?d (Features $?y AntiHDV positive)))
    (if (eq ?AntiHDV negative) then (modify ?d (Features $?y AntiHDV negative)))
)

(defrule ToHepatitisBD
    (Classification (NAME ?x) (Disease AntiHDV))
    (Person (NAME ?x)(Features $?s AntiHDV positive $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease HepatitisBD) (Flag 1)))
)

(defrule ToAntiHBc
    (Classification (NAME ?x) (Disease AntiHDV))
    (Person (NAME ?x) (Features $?s AntiHDV negative $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease AntiHBc)))
)

(defrule IsAntiHBc (declare (salience 7))
    (Classification (NAME ?x) (Disease AntiHBc))
    ?d <- (Person (NAME ?x) (Features $?y))
    (not (Person (NAME ?x) (Features $?l AntiHBc $?r)))
    =>
    (printout t ?x ": anti-HBc (positive/negative)? > ")
    (bind ?AntiHBc (read))
    (while (neq ?AntiHBc positive or negative) 
        (println "Accepted Value: positive/negative")
        (printout t ?x ": AntiHBc (positive/negative)? > ")
        (bind ?AntiHBc (read)))
    (if (eq ?AntiHBc positive) then (modify ?d (Features $?y AntiHBc positive)))
    (if (eq ?AntiHBc negative) then (modify ?d (Features $?y AntiHBc negative)))
)


(defrule ToUncertainConfiguration
    (Classification (NAME ?x) (Disease AntiHBc))
    (Person (NAME ?x) (Features $?s AntiHBc negative $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease UncertainConfiguration) (Flag 1)))
)

(defrule ToAntiHBs
    (Classification (NAME ?x) (Disease AntiHBc))
    (Person (NAME ?x) (Features $?s AntiHBc positive $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease AntiHBs)))
)

(defrule IsAntiHBs (declare (salience 6))
    (Classification (NAME ?x) (Disease AntiHBs))
    ?d <- (Person (NAME ?x) (Features $?y))
    (not (Person (NAME ?x) (Features $?l AntiHBs $?r)))
    =>
    (printout t ?x ": anti-HBs (positive/negative)? > ")
    (bind ?AntiHBs (read))
    (while (neq ?AntiHBs positive or negative) 
        (println "Accepted Value: positive/negative")
        (printout t ?x ": AntiHBs (positive/negative)? > ")
        (bind ?AntiHBs (read)))
    (if (eq ?AntiHBs positive) then (modify ?d (Features $?y AntiHBs positive)))
    (if (eq ?AntiHBs negative) then (modify ?d (Features $?y AntiHBs negative)))
)

(defrule ToUncertainConfiguration2
    (Classification (NAME ?x) (Disease AntiHBs))
    (Person (NAME ?x) (Features $?s AntiHBs positive $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease UncertainConfiguration) (Flag 1)))
)

(defrule ToIgMAntiHBc
    (Classification (NAME ?x) (Disease AntiHBs))
    (Person (NAME ?x) (Features $?s AntiHBs negative $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease IgMAntiHBc)))
)

(defrule IsIgMAntiHBc (declare (salience 5))
    (Classification (NAME ?x) (Disease IgMAntiHBc))
    ?d <- (Person (NAME ?x) (Features $?y))
    (not (Person (NAME ?x) (Features $?l IgMAntiHBc $?r)))
    =>
    (printout t ?x ": anti-HBs (positive/negative)? > ")
    (bind ?IgMAntiHBc (read))
    (while (neq ?IgMAntiHBc positive or negative) 
        (println "Accepted Value: positive/negative")
        (printout t ?x ": IgMAntiHBc (positive/negative)? > ")
        (bind ?IgMAntiHBc (read)))
    (if (eq ?IgMAntiHBc positive) then (assert (Classification (NAME ?x) (Disease AcuteInfection) (Flag 1))))
    (if (eq ?IgMAntiHBc negative) then (assert (Classification (NAME ?x) (Disease ChronicInfection) (Flag 1))))
)

(defrule ToAntiHBs2
    (Classification (NAME ?x) (Disease HepatitisDisease))
    (Person (NAME ?x) (Features $?s HBsAG negative $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease AntiHBs2)))
)

(defrule IsAntiHBs2 (declare (salience 4))
    (Classification (NAME ?x) (Disease AntiHBs2))
    ?d <- (Person (NAME ?x) (Features $?y))
    (not (Person (NAME ?x) (Features $?l AntiHBs2 $?r)))
    =>
    (printout t ?x ": anti-HBs (positive/negative)? > ")
    (bind ?AntiHBs2 (read))
    (while (neq ?AntiHBs2 positive or negative) 
        (println "Accepted Value: positive/negative")
        (printout t ?x ": AntiHBs2 (positive/negative)? > ")
        (bind ?AntiHBs2 (read)))
    (if (eq ?AntiHBs2 positive) then (modify ?d (Features $?y AntiHBs2 positive)))
    (if (eq ?AntiHBs2 negative) then (modify ?d (Features $?y AntiHBs2 negative)))
)

(defrule ToAntiHBc2
    (Classification (NAME ?x) (Disease AntiHBs2))
    (Person (NAME ?x) (Features $?s AntiHBs2 positive $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease AntiHBc2)))
)

(defrule ToAntiHBc3
    (Classification (NAME ?x) (Disease AntiHBs2))
    (Person (NAME ?x) (Features $?s AntiHBs2 negative $?f))
    =>
    (assert (Classification (NAME ?x)
            (Disease AntiHBc3)))
)

(defrule IsAntiHBc2 (declare (salience 3))
    (Classification (NAME ?x) (Disease AntiHBc2))
    ?d <- (Person (NAME ?x) (Features $?y))
    (not (Person (NAME ?x) (Features $?l AntiHBc2 $?r)))
    =>
    (printout t ?x ": anti-HBc (positive/negative)? > ")
    (bind ?AntiHBc2 (read))
    (while (neq ?AntiHBc2 positive or negative) 
        (println "Accepted Value: positive/negative")
        (printout t ?x ": AntiHBc2 (positive/negative)? > ")
        (bind ?AntiHBc2 (read)))
    (if (eq ?AntiHBc2 positive) then (assert (Classification (NAME ?x) (Disease Cured) (Flag 1))))
    (if (eq ?AntiHBc2 negative) then (assert (Classification (NAME ?x) (Disease Vaccinated) (Flag 1))))
)

(defrule IsAntiHBc3 (declare (salience 3))
    (Classification (NAME ?x) (Disease AntiHBc3))
    ?d <- (Person (NAME ?x) (Features $?y))
    (not (Person (NAME ?x) (Features $?l AntiHBc3 $?r)))
    =>
    (printout t ?x ": anti-HBc (positive/negative)? > ")
    (bind ?AntiHBc3 (read))
    (while (neq ?AntiHBc3 positive or negative) 
        (println "Accepted Value: positive/negative")
        (printout t ?x ": AntiHBc3 (positive/negative)? > ")
        (bind ?AntiHBc3 (read)))
    (if (eq ?AntiHBc3 positive) then (assert (Classification (NAME ?x) (Disease Unclear_Possible_Resolved) (Flag 1))))
    (if (eq ?AntiHBc3 negative) then (assert (Classification (NAME ?x) (Disease Healthy_Not_Vaccinated_or_Suspicious) (Flag 1))))
)


(defrule Print (declare (salience -1))
    (Classification (NAME ?x) (Disease ?y) (Flag 1))
    =>
    (printout t "Hasil Prediksi = " ?y crlf)
)