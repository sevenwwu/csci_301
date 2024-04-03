#lang racket

(cond 
    ((equal? 16 3) (+ 3 8)) 
    ((equal? 16 8) 12) 
    (else (* 6 3))          ; <-- this line returns with val 18
) 


(cond 
    ((equal? 8 3) (+ 3 8)) 
    ((equal? 8 8) 12)       ; <-- this line returns with val 12
    (else (* 6 3))
) 


(cond 
    ((equal? 3 3) (+ 3 8))  ; <-- this line return s with val 11
    ((equal? 3 8) 12) 
    (else (* 6 3))
) 

; the cond function iterates over each argument, of which each is an boolean expression pair.
; for each argument, if the boolean is #f, go to the next argument, if #t, then return the expression
; the else clause will always return its expression 