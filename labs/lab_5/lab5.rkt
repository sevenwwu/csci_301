#lang racket

;;; Previously Defined Procedures

(define (member? x set)
    (cond 
        ([null? set]
            #f
        )
        ([equal? x (car set)]
            #t
        )
        (else
            (member? x (cdr set))
        )
    )
)

;;; New stuff for this lab

(define (Reflexive? relations set)
    (begin

        (cond
            ([and (null? set) (null? relations)] 
                #t
            )
            ((null? relations)
                #f    
            )
            ([and (equal? (car (car relations)) (car (cdr (car relations)))) (member? (car (car relations)) set)]
                (Reflexive? (cdr relations) (remove (car (car relations)) set))
            )
            ;;;; WRONG CURRENTLY BECAUSE VALUE MAY NO LONGER BE IN THE SET, BUT WAS WHEN WE STARTED
            ([or (not (member? (car (car relations)) set)) (not (member? (car (cdr (car relations))) set))]
                #f
            )
            (else
                (Reflexive? (cdr relations) set)
            )
        )
    )
    
)

(display "Reflexive?\n") 
(Reflexive? '((a a) (b b) (c c)) '(a b c)) ;; -->#t 
(Reflexive? '((a a) (b b)) '(a b c)) ;; -->#f 
(Reflexive? '((a a) (a s) (b b) (c c)) '(a b c)) ;; -->#f 
(Reflexive? '() '()) ;; -->#t 
