#lang racket

(car '(11 12 13 14))
(car '(a b c d)) 
(cdr '(11 12 13 14)) 
(cdr '(a b c d)) 
(car (11 12 13 14)) 
; (cdr (a b c d)) 

; car returns the first symbol
; cdr returns a sub-list with the first symbol removed