#lang racket
                        ; length returns length of list
(length '(a b c))       ; 3

                        ; reverse returns reverse of list
(reverse '(a b c))      ; '(c b a)

                        ; member appears to return a new list beginning with arg1
                        ; and succeeded by the rest of the list after arg1, if the
                        ; element is not in the list, return #f
(member 'a '(a b c))    ; '(a b c)
(member 'b '(a b c))    ; '(b c)
(member 'c '(a b c))    ; '(c)
(member 'd '(a b c))    ; #f
