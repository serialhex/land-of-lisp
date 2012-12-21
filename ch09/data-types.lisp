;; arrays
; makin
(make-array 3)
; #(NIL NIL NIL)

; gettin
(defparameter x (make-array 3))
(aref x 1)
; NIL

; settin
(setf (aref x 1) 'foo)
x
; #(NIL FOO NIL)
; setf being a generic setter for stuff!



;; hashes!!
; makin
(defparameter x (make-hash-table))

; gettin
(gethash 'yup x)
; NIL ;   <- value
; NIL     <- present

; settin
(setf (gethash 'yup x) '25)
; 25
(gethash 'yup x)
; 25;   <- value
; T     <- present

;; structures
; makin
(defstruct person
            name
            age
            waist-size
            favorite-color)
(defparameter *bob* (make-person  :name "Bob"
                                  :age 35
                                  :waist-size 32
                                  :favorite-color "blue"))
*bob*
; #S(PERSON :NAME "Bob" :AGE 35 :WAIST-SIZE 32 :FAVORITE-COLOR "blue")

; gettin
(person-age *bob*)
; 35

; settin
; ...you get the picture....



;; GENERICS!!!

;; sequences
(length '(a b c))
; 3
(length "blub")
; 4
(length (make-array 5))
; 5

; searching
(find-if #'numberp '(a b 5 d))
; 5
(count #\s "mississippi")
; 4
(position #\4 "2kewl4skewl")
; 5
(some #'numberp '(a b 5 d))
; T
(every #'numberp '(a b 5 d))
; NIL

; iterating
(reduce #'+ '(3 4 6 5 2))
; 20

(reduce (lambda (best item)
          (if (and (evenp item) (> item best))
                item
            best))
          '(7 4 6 5 2)
          :initial-value 0)