#lang racket



(define (sum nums)
    (if [null? nums]
        0
        (+ (car nums) (sum (cdr nums)))
    )
)

(sum '(4 5 0 1)) 

(sum '())
; (sum (gen-list 1 5))