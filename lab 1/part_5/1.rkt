#lang racket

(lambda (x) 
 (+ x 1)) 


((lambda (x) 
 (+ x 1)) 3) 

((lambda (x y) 
    (+ x 1)) 3 5
)
