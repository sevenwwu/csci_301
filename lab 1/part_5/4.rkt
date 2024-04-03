#lang racket

(define a 2);;binding a variable to a value 
(define b 3) 
(define c 4) 
(define (strange x) 
    (let ((a 1) (b 2)) 
        (+ x a b)
    )
) 


(strange 4)     ; the return value of (strange 4) is 7, this is because
                ; for this scope, the symbols `a` and `b` have been bound
                ; to `1` and `2` respectively
                ; 4 + 1 + 2 = 7