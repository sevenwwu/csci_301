#lang racket

(define (mystery L) 
    (if (null? L)
        L
        (begin 
            (displayln L)
	        (append 
                (mystery (cdr L))
		        (list (car L))
            )
        )
    )
)

(mystery '(1 2 3))             
(mystery '((1 2) (3 4) 5 6))

; `begin` simply evaluates each expression passed to it
; returning the final expressions return value.
; `displayln` prints to the console the data passed to it.