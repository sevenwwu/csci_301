#lang racket

(define (gen-list start end)
    (if [> start end]
        '()
        (cons start (gen-list (+ start 1) end))
    )
)

(gen-list 1 5) 
(gen-list 6 23)
(gen-list 7 7)
(gen-list 5 2)