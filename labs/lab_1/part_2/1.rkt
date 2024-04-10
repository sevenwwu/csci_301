#lang racket

(car '(11 12 13 14))    ; 11
(car '(a b c d))        ; 'a
(cdr '(11 12 13 14))    ; 11
(cdr '(a b c d))        ; '(b c d)
(car (11 12 13 14))     ; invalid
(cdr (a b c d))         ; invalid

; car returns the first symbol
; cdr returns a sub-list with the first symbol removed