#lang racket

(define (add-one x) 
    (+ x 1)
) 


(define another-add-one add-one) 
(another-add-one 5) 
