#lang racket

(define (member? x set)
    (cond 
        ([null? set]
            #f
        )
        ([equal? x (car set)]
            #t
        )
        (else
            (member? x (cdr set))
        )
    )
)


(define (subset? s1 s2)
    (cond 
        ([null? s1]
            #t
        )
        ([member? (car s1) s2]
            (subset? (cdr s1) s2)
        )
        (else
            #f
        )
    )
)

;;; (subset? '(1 2 3) '(3 2 1)) ;; ;; ---> #t
;;; (subset? '(1 2 3) '(4 5 6)) ;; ;; ---> #f
;;; (subset? '(1 2 3) '(1 2 3 4 5 6)) ;; ;; ---> #t
;;; (subset? '(1 2) '()) ;; ;; ---> #f


(define (set-equal? s1 s2)
    (and (subset? s1 s2) (subset? s2 s1))
)

;;; (set-equal? '(1 2 3) '(3 2 1)) ;; ;; ---> #t
;;; (set-equal? '(1 2) '(3 2 1)) ;; ;; ---> #f
;;; (set-equal? '(ryan susan john) '(susan john ryan)) ;; ;; ---> #t


;;; union checks to see if it's our first run (when s2 is not null)
;;; if so, throw everything into s1, set s2 to null and run it again.
;;; Then, we simply remove duplicates for s1 until s1 is empty, and 
;;; join all the unique elements together. 
(define (union s1 s2)
    (cond 
        ([not (null? s2)] 
            (union (append s1 s2) '())
        )
        ([null? s1]
            '()
        )
        ([member? (car s1) (cdr s1)] 
            (union (cdr s1) '())
        )
        (else 
            (cons (car s1) (union (cdr s1) '()))
        )
    )
)


;;; intersect checks to see if the first element of s1 is 
;;; in the rest of s1 or in s2. If either is the case
;;; do not add it to the return list. Otherwise, the element
;;; is unique and should be included in the return list.
;;; Then we join all the included items together on bubble up.
;;; This way shared elements only enter the return list once.
(define (intersect s1 s2)
    (cond 
        ([null? s1] 
            '()
        )
        ([member? (car s1) (cdr s1)]
            (intersect (cdr s1) s2)
        )
        ([member? (car s1) s2]
            (cons (car s1) (intersect (cdr s1) s2))
        )
        (else
            (intersect (cdr s1) s2)
        )
    )
)

;;; (union '(1 2 3) '(3 2 2 1)) ;; ---> (1 2 3)
;;; (union '(1 2 3 2) '(3 4 5)) ;; ---> (1 2 3 4 5)
;;; (union '(a b c c) '(1 3 2 1)) ;; ---> (a b c 1 2 3)
;;; (intersect '(1 2 3 3) '(2 3 2 1)) ;; ---> (1 2 3)
;;; (intersect '(1 2 1 3) '(1 4 1 5 1 6)) ;; ---> (1)
;;; (intersect '(1 2 1 3) '(2 3 4 5 2 6)) ;; ---> (2 3)