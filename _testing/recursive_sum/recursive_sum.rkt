#lang racket

(define (sum n)
    (cond 
        [(= n 0) 0]
        [else (+ n (sum (- n 1)))]
    )
)

(define (sum_series n)
    (/ (* (+ n 1) n) 2)    
)

(define (sum_again n)
    (cond 
        [(eq? 'a n) 69]
        [(= n 0) 0]
        [else (+ n (sum_again (- n 1)))]
    )
)

(sum 5)

(sum_series 5)

(define a 5)


(sum_again 'a)