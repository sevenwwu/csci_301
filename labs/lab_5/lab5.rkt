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

;;; Newly Defined Procedures


;;; Reflexive? and Reflexive?-helper iterate through each
;;; relation and check to make sure that:
;;;    1) If the relationship is of the form (a,a), then
;;;       make sure that a is in set, and make note that
;;;       we have now seen the reflexivity of element a
;;;       (by removing it from the working set)
;;;    2) If the relationship is of any other form, 
;;;       just make sure each element is from the given
;;        set and move on to the next relation.
;;; Once we make it through all the relations (or return
;;; an early #f because we found an element not in the
;;; given set), if we found all reflexive pairs (this
;;; is when the working set is empty) return #t otherwise
;;; return false.
(define (Reflexive? relations set)
    (Reflexive?-helper relations set set)
)

(define (Reflexive?-helper relations workingSet set)
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
    )
)

;;; (display "Reflexive?\n") 
;;; (Reflexive? '((a a) (b b) (c c)) '(a b c)) ;; -->#t 
;;; (Reflexive? '((a a) (b b)) '(a b c)) ;; -->#f 
;;; (Reflexive? '((a a) (a s) (b b) (c c)) '(a b c)) ;; -->#f 
;;; (Reflexive? '() '()) ;; -->#t 

;;; Symmetric? iterates over each relation (a,b) and checks to 
;;; make sure that (b,a) is also in the the relations set. 
(define (Symmetric? relations)
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
    )
)

;;; (display "Symmetric?\n") 
;;; (Symmetric? '((a a) (a b) (b a) (b c) (c b)))  ;; --> #t 
;;; (Symmetric? '((a a) (a b) (a c) (c a)))  ;; --> #f 
;;; (Symmetric? '((a a) (b b)))  ;; --> #t 
;;; (Symmetric? '())  ;; --> #t 

;;; Transitive?, Transitive?-helper, and TransitiveChecker
;;; all work together to check all pairs of relations.
;;; If we ever find that (a b) and (b c), but not (a c),
;;; we return #f. If this is not found after checking 
;;; every case of (a b) and (b c), we return #t. 
(define (Transitive? relations)
    (Transitive?-helper relations relations)
)

(define (Transitive?-helper iRelations relations)
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

;;; (display "Transitive? \n")  
;;; (Transitive? '((a b) (b c) (a c)))  ;; --> #t 
;;; (Transitive? '((a a) (b b) (c c)))  ;; --> #t 
;;; (Transitive? '((a b) (b a)))  ;; --> #f 
;;; (Transitive? '((a b) (b a) (a a)))  ;; --> #f 
;;; (Transitive? '((a b) (b a) (a a) (b b)))  ;; --> #t 
;;; (Transitive? '()) ;; --> #t
