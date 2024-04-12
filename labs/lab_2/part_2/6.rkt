#lang racket

(define (retrieve-first-n n lst)
    (if [or (<= n 0) (null? lst)]
        '()
        (cons (car lst) (retrieve-first-n (- n 1) (cdr lst)))
    )
)

(retrieve-first-n 3 '(a b c d e f g h i)) 

(retrieve-first-n -1 '(a b c d e f g h i)) 

(retrieve-first-n 5 '(1 2))