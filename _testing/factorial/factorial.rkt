#lang racket                                                                                                      
                                                                                                                   
(define (factorial n)                                                                                             
    (cond                                                                                                           
        [(= n 0) 1]                                                                                                   
        [else (* n (factorial (- n 1)))]
    )
)                                                                            
                                                                                                                   
(define result (factorial 5))                                                                                     
                                                                                                                   
(printf "The factorial of 5 is: ~a\n" result)  