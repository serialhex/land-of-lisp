(if '()
	'i-am-true
	'i-am-false)
;;  I-AM-FALSE

(if '(1)
	'i-am-true
	'i-am-false)
;; I-AM-TRUE

(defun my-length (list)
	(if list
			(1+ (my-length (cdr list)))
			0))

(my-length '(list with four symbols))
;; 4

(eq '() nil)  ; T
(eq '() ())   ; T
(eq '() 'nil) ; T

(if (= (+ 1 2) 3)
	'yup
	'nope)
;; YUP

(if (= (+ 1 2) 4)
	'yup
	'nope)
;; NOPE

; if is lazy!!!
(if (oddp 5)
	'odd-number
	(/ 1 0))

; progn lets us do many things inside an if!
(defvar *number-was-odd* nil)

(if (oddp 5)
	(progn	(setf *number-was-odd* t)
			'odd-number)
	'even-number)
;; odd-number

*number-was-odd*
;; T

; other if-like things
(defvar *number-is-odd* nil)
(when (oddp 5)
	(setf *number-is-odd* t)
	'odd-number)
;; odd-number
*number-is-odd*
;; T

(unless (oddp 4)
	(setf *number-is-odd* nil)
	'even-number)
;; even-number
*number-is-odd*
;; NIL

; and then there is spiffy cond!
(defvar *arch-enemy* nil)
(defun pudding-eater (person)
	(cond	((eq person 'henry)		(setf *arch-enemy* 'stupid-lisp-alien)
									'(curse you lisp alien - you ate my pudding!))
			((eq person 'johnny)	(setf *arch-enemy* 'useless-old-johnny)
									'(i hope you choked on my pudding johnny))
			(t						'(why you eat my pudding stranger?))))

(pudding-eater 'johnny)
;; (i hope you choked on my pudding johnny)
*arch-enemy*
;; useless-old-johnny

(pudding-eater 'george-clooney)
;; (why you eat my pudding stranger?)

; or, the above moar nicerer...
(defun pudding-eater (person)
	(case person
		((henry)	(setf *arch-enemy* 'stupid-lisp-alien)
					'(curse you lisp alien - you ate my pudding))
		((johnny)	(setf *arch-enemy* 'useless-old-johnny)
					'(i hope you choked on my pudding johnny))
		(otherwise	'(why you eat my pudding stranger?)))

; and & or can take 2 or more conditions
(and (oddp 5) (oddp 7) (oddp 9))
;; T

(or (oddp 4) (oddp 7) (oddp 8))
;; T

; short-circuit means it can be used to make cool stuff happen
(defparameter *is-it-even* nil)
(or (oddp 4) (setf *is-it-even* t))
;; T
*is-it-even*
;; T

(defparameter *is-it-even* nil)
(or (oddp 5) (setf *is-it-even* t))
;; T
*is-it-even*
;; NIL

; short-circuit anding!!!  (with a preceeding example of ifs)
(if *file-modified*
	(if (ask-user-about-saving)
		(save-file)))
;  OR...
(and *file-modified* (ask-user-about-saving) (save-file))
; compromize!!
(if (and *file-modified*
		(ask-user-about-saving))
	(save-file))

; interesting return values
(if (member 1 '(3 4 1 5))
	'one-is-in-the-list
	'one-is-not-in-the-list)
;; one-is-in-the-list
; &&
(member 1 '(3 4 1 5))
;; (1 5)
; it returns that because of the following edgecase
(if (member nil '(3 4 nil 5))
	'nil-is-in-the-list
	'nil-is-not-in-the-list)
; instead of returning *just* what we want, (nil in this case)
; it returns the tail of the list (even if it's (nil))
; otherwise it will return nil when true and nil when false :p

(find-if #'oddp '(2 4 5 6))
;; 5
(if (find-if #'oddp '(2 4 5 6))
	'there-is-an-odd-number
	'there-is-no-odd-number)
;; there-is-an-odd-number

