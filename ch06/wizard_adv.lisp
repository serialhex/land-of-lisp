; describing places
(defparameter *nodes* '((living-room (you are in the living room.
							a wizard is snoring loudly on the couch.))
						(garden (you are in a beautiful garden.
							there is a well in front of you.))
						(attic (you are in the attic.
							there is a giant weldong torch in the corner.))))

; we can get associations thusly:
(assoc 'garden *nodes*)
;; (GARDEN (YOU ARE IN A BEAUTIFUL GARDEN. THERE IS A WELL IN FRONT OF YOU.))

; getting location-based info
(defun describe-location (location nodes)
	(cadr (assoc location nodes)))

; paths, or edges in math-terms
(defparameter *edges* '((living-room	(garden west door)
										(attic upstairs ladder))
						(garden (living-room east door))
						(attic (living-room downstairs ladder))))

; describing a path between places
(defun describe-path (edge)
	`(there is a ,(caddr edge) going ,(cadr edge) from here.))
; describing multiple paths between places
(defun describe-paths (location edges)
	(apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

; higher-order functions are cool...  what if i could do that with objects?

; thingys, and where they are!!
(defparameter *objects* '(whiskey bucket frog chain))
(defparameter *object-locations*  '((whiskey living-room)
									(bucket living-room)
									(chain garden)
									(frog garden)))
; and list the objects in a given area!!
(defun objects-at (loc objs obj-locs)
	(labels ((at-loc-p (obj)
				(eq (cadr (assoc obj obj-locs)) loc)))
		(remove-if-not #'at-loc-p objs)))

(defun describe-objects(loc objs obj-loc)
	(labels ((describe-obj (obj)
				`(you see a ,obj on the floor.)))
		(apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))

; the variable that lets us know where the player is
(defparameter *location* 'living-room)
; and the function used to find out where we are!
(defun look ()
	(append (describe-location *location* *nodes*)
			(describe-paths *location* *edges*)
			(describe-objects *location* *objects* *object-locations*)))

; walking 'round
(defun walk (direction)
	(let ((next (find direction
					(cdr (assoc *location* *edges*))
					:key #'cadr)))
	(if next
		(progn (setf *location* (car next))
			(look))
		'(you cannot go that way))))

; picking up objects
(defun pickup (object)
	(cond ((member object
					(objects-at *location* *objects* *object-locations*))
				(push (list object 'body) *object-locations*)
					`(you are now carrying the ,object))
			(t '(you cannot get that.))))

(defun inventory ()
	(cons 'items- (objects-at 'body *objects* *object-locations*)))

