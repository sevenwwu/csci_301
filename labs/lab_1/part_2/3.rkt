#lang racket
                        ; cons appears to add arg1 to the beginning of arg2 (where arg 2 is a list)
(cons 3 '(1 2))         ; '(3 1 2)
(cons '(1 5) '(2 3))    ; '((1 5) 2 3)

                        ; list appears to take all the arguments and put them in a list
(list 3 '(1 2))         ; '(3 (1 2))
(list '(1 5) '(2 3))    ; '((1 5) (2 3))

                        ; append adds to front each element in arg1 (which is a list) to arg2's list
(append '(1) '(2 3))    ; '(1 2 3)
(append '(1 5) '(2 3))  ; '((1 5 2 3))

(cons 'x '(1 2))        ; '(x 1 2)
(list 1 2 3 '(4 5))     ; '(1 2 3 (4 5))
(cons '1 '2 '3 '(4 5))  ; INVALID, cons expects 2 arguments 
