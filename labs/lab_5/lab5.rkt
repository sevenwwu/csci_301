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
    (Reflexive?-helper relations set set)
)

(define (Reflexive?-helper relations workingSet set)
    (begin
        (display "--------------\n")
        (display relations)
        (display "\n")
        (display workingSet)
        (display "\n")
        (display set)
        (display "\n\n\n")
    (cond
        ([and (null? workingSet) (null? relations)] 
                #t
        )
        ((null? relations)
                #f    
        )
        (else
            (let ([e1 (car (car relations))] [e2 (car (cdr (car relations)))])
                (cond
                    ([and (equal? e1 e2) (member? e1 set)]
                        (Reflexive?-helper (cdr relations) (remove e1 workingSet) set)
                    )
                    ([or (not (member? e1 set)) (not (member? e2 set))]
                        #f
                    )
                    (else
                        (Reflexive?-helper (cdr relations) workingSet set)
                    )
                )
            )
        )
    ))
)

;;; (display "Reflexive?\n") 
;;; (Reflexive? '((a a) (b b) (c c)) '(a b c)) ;; -->#t 
;;; (Reflexive? '((a a) (b b)) '(a b c)) ;; -->#f 
;;; (Reflexive? '((a a) (a s) (b b) (c c)) '(a b c)) ;; -->#f 
;;; (Reflexive? '() '()) ;; -->#t 


(define (Symmetric? relations)
    (begin
        (display "--------------\n")
        (display relations)
        (display "\n")
    (cond
        ([null? relations]
            #t
        )
        ([member? (list (car (cdr (car relations))) (car (car relations))) relations]
            (Symmetric? (remove (list (car (cdr (car relations))) (car (car relations))) (cdr relations)))
        )
        (else
            #f
        )
    ))
)

;;; (display "Symmetric?\n") 
;;; (Symmetric? '((a a) (a b) (b a) (b c) (c b)))  ;; --> #t 
;;; (Symmetric? '((a a) (a b) (a c) (c a)))  ;; --> #f 
;;; (Symmetric? '((a a) (b b)))  ;; --> #t 
;;; (Symmetric? '())  ;; --> #t 


(define (Transitive? relations)
    (Transitive?-helper relations relations)
)

(define (Transitive?-helper iRelations relations)
    ;;; (begin
    ;;;     (display "--------------\n")
    ;;;     (display relations)
    ;;;     (display "\n")
    (cond
        ([null? iRelations]
            #t
        )
        ([TransitiveChecker (car iRelations) relations relations]
            (Transitive?-helper (cdr iRelations) relations)
        )
        (else
            #f
        )
    )
)

(define (TransitiveChecker current jRelations relations)
    (if [null? jRelations]
        #t
        (let ([a (car current)] [b (car (cdr current))] [x (car (car jRelations))] [y (car (cdr (car jRelations)))])
            (if [and (equal? b x) (not (member? (list a y) relations))]
                #f
                (TransitiveChecker current (cdr jRelations) relations)
            )
        )
    )
)

(display "Transitive? \n")  
(Transitive? '((a b) (b c) (a c)))  ;; --> #t 
(Transitive? '((a a) (b b) (c c)))  ;; --> #t 
(Transitive? '((a b) (b a)))  ;; --> #f 
(Transitive? '((a b) (b a) (a a)))  ;; --> #f 
(Transitive? '((a b) (b a) (a a) (b b)))  ;; --> #t 
(Transitive? '()) ;; --> #t
