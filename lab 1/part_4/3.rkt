#lang racket

(cond ((equal? 16 3) (+ 3 8)) 
    ((equal? 16 8) 12) 
    (else (* 6 3))
) 


(cond ((equal? 8 3) (+ 3 8)) 
    ((equal? 8 8) 12) 
    (else (* 6 3))
) 


(cond ((equal? 3 3) (+ 3 8)) 
    ((equal? 3 8) 12) 
    (else (* 6 3))
) 


(cond (#t 6 #f 3))

; the cond function iterates over each argument, of which each is an boolean, value expression
; for each argument, if the boolean is #f, go to the next argument, if #t, then return the expression
; the else clause will always return its expression 