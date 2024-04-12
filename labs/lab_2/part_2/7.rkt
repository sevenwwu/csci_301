#lang racket

(define (pair-sum? lst val)
    (if [<= (length lst) 1]
        #f
        (or 
            (= (+ (car lst) (car (cdr lst))) val)
            (pair-sum? (cdr lst) val)
        )    
    )
)

(pair-sum? '(1 2 3) 3) 

; (pair-sum? (gen-list 1 100) 1000) 