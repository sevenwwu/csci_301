#lang racket

(define (mystery L) 
    (if (null? L)
        L
        (append 
            (mystery (cdr L))
            (list (car L))
        )
    )
)


(mystery '(1 2 3))              ; '(3 2 1)
(mystery '((1 2) (3 4) 5 6))    ; '(6 5 (3 4) (1 2))

; This function reverses a given list. It does this by recursing
; down the list until we reach the `null` pointer for the list
; that was returned by the final `cdr`. Then, we go down the
; stack grabbing the value in current node with `car` and 
; appending it to the end of our growing reverse list. Eventually
; we return the `mystery` procedure when the outermost append 
; returns. 
