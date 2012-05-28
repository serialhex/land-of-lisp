
;; some cool list things

; a dotted list:
(cons 1 (cons 2 3))
;; (1 2 . 3)

; one can also do:
'(1 . (2 . (3 . nil)))
; to make a regular list

(cons 2 3)
; the above makes a simple pair

; Association lists
(defparameter *drink-order* '((bill . double-espresso)
                              (lisa . small-drip-coffee)
                              (john . medium-latte)))

(assoc 'lisa *drink-order*)
;;(LISA . SMALL-DRIP-COFFEE)

(push '(lisa . large-mocha-with-whipped-cream) *drink-order*)
;;((LISA . LARGE-MOCHA-WITH-WHIPPED-CREAM) (BILL . DOUBLE-ESPRESSO) (LISA . SMALL-DRIP-COFFEE) (JOHN . MEDIUM-LATTE))
(assoc 'lisa *drink-order*)
;;(LISA . LARGE-MOCHA-WITH-WHIPPED-CREAM)

; tree-like data
(defparameter *house* '((walls  (mortar (cement)
                                        (water)
                                        (sand))
                                (bricks))
                        (windows  (glass)
                                  (frame)
                                  (curtains))
                        (roof (shingles)
                              (chimney))))

