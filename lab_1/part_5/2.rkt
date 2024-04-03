#lang racket

(define add-one 
    (lambda (x) 
        (+ x 1)
    )
)
(add-one 1)


(define (add-one x) 
    (+ x 1)
) 


(add-one 1)