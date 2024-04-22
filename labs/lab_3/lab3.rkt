#lang racket

(define (member? x set)
    (if [null? set]
        #f
        (if [equal? x (car set)]
            #t
            (member? x (cdr set))
        )
    )
)

;;; (member? 1 '(3 2 1)) ;; ---> #t
;;; (member? 4 '(3 2 1)) ;; ---> #f
;;; (member? 1 '());; ---> #f
;;; (member? 'susan '(susan john ryan)) ;; ---> #t
 


(define (subset? s1 s2)
    (if [null? s1]
        #t
        (if [member? (car s1) s2]
            (subset? (cdr s1) s2)
            #f
        )
    )
)

;;; (subset? '(1 2 3) '(3 2 1));; ---> #t
;;; (subset? '(1 2 3) '(4 5 6)) ;; ---> #f
;;; (subset? '(1 2 3) '(1 2 3 4 5 6)) ;; ---> #t
;;; (subset? '(1 2) '());; ---> #f


(define (set-equal? s1 s2)
    (and (subset? s1 s2) (subset? s2 s1))
)

;;; (set-equal? '(1 2 3) '(3 2 1)) ;; ---> #t
;;; (set-equal? '(1 2) '(3 2 1)) ;; ---> #f
;;; (set-equal? '(ryan susan john) '(susan john ryan)) ;; ---> #t


(define (union s1 s2)
    (if [null? s2]
        s1
        (if [member? (car s2) s1]
            (union s1 (cdr s2))
            (union (append s1 (list (car s2))) (cdr s2))
        )
    )
)

(define (intersect s1 s2)
    (if [null? s1]
        '()
        (if [member? (car s1) s2]
            (cons (car s1) (intersect (cdr s1) s2))
            (intersect (cdr s1) s2)
        )
    )
)

(union '(1 2 3) '(3 2 1)) ;; ---> (1 2 3)
(union '(1 2 3) '(3 4 5)) ;; ---> (1 2 3 4 5)
(union '(a b c) '(3 2 1)) ;; ---> (a b c 1 2 3)
(intersect '(1 2 3) '(3 2 1)) ;; ---> (1 2 3)
(intersect '(1 2 3) '(4 5 6)) ;; ---> ()
(intersect '(1 2 3) '(2 3 4 5 6)) ;; ---> (2 3)


