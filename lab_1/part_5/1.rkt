#lang racket

(lambda (x)     ; returns nothing
    (+ x 1)
) 


(               ; returns 4
    (lambda (x) 
        (+ x 1)
    ) 
    3
) 

