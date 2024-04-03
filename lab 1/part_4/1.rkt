#lang racket
                                    ; equal? does a recursive value equality comparison
(equal? '(hi there) '(hi there))    ; #t

                                    ; eqv? does a reference equality comparison (compare locations in memory)
(eqv? '(hi there) '(hi there))      ; #f 

                                    ; = does a numeral equality comparison (with coercion)
(= '(hi there) '(hi there))         ; error -> contract violation


(equal? '(hi there) '(bye now))     ; #f
(eqv? '(hi there) '(bye now))       ; #f
(equal? 3 3)                        ; #t
(eqv? 3 3)                          ; #t
(= 3 3)                             ; #t
(equal? 3 (+ 2 1))                  ; #t
(eqv? 3 (+ 2 1))                    ; #t
(= 3 (+ 2 1))                       ; #t
(equal? 3 3.0)                      ; #f
(eqv? 3 3.0)                        ; #f
(= 3 3.0)                           ; #t
(equal? 3 (/ 6 2))                  ; #t
(eqv? 3 (/ 6 2))                    ; #t
(= 3 (/ 6 2))                       ; #t
(equal? -1/2 -0.5)                  ; #f
(eqv? -1/2 -0.5)                    ; #f
(= -1/2 -0.5)                       ; #t