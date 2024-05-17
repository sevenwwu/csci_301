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

(define (union s1 s2)
    (cond 
        ([not (null? s2)] 
            (union (append s1 s2) '())
        )
        ([null? s1]
            '()
        )
        ([member? (car s1) (cdr s1)] 
            (union (cdr s1) '())
        )
        (else 
            (cons (car s1) (union (cdr s1) '()))
        )
    )
)



;;; Newly Defined Procedures

(define (Reflexive-Closure relations set)
    (union relations (get-reflexive-pairs set))
)

(define (get-reflexive-pairs set)
    (if [null? set]
        '()
        (cons (list (car set) (car set)) (get-reflexive-pairs(cdr set)))
    )
)

;;; (Reflexive-Closure '((a a) (b b) (c c)) '(a b c))  ;  ---> '((a a) (b b) (c c)) 
;;; (Reflexive-Closure '((a a) (b b)) '(a b c)) ;  ---> '((a a) (b b) (c c)) 
;;; (Reflexive-Closure '((a a) (a b) (b b) (b c)) '(a b c)) ; ---> ((a a) (a b) (b b) (b c) (c c)) 
;;; (Reflexive-Closure '() '(a b c)) ;  ---> '((a a) (b b) (c c)) 


(define (Symmetric-Closure relations)
    (union relations (get-symmetric-pairs relations))
)

(define (get-symmetric-pairs relations)
    (cond 
        ([null? relations]
            '()
        )
        ([member? (list (car (cdr (car relations))) (car (car relations))) relations]
            (get-symmetric-pairs (remove (list (car (cdr (car relations))) (car (car relations))) (cdr relations)))
        )
        (else
            (cons (list (car (cdr (car relations))) (car (car relations))) (get-symmetric-pairs (cdr relations)))
        )
    )
)

;;; (Symmetric-Closure '((a a) (a b) (b a) (b c) (c b))) ;   ---> '((a a) (a b) (b a) (b c) (c b)) 
;;; (Symmetric-Closure '((a a) (a b) (a c))) ;   ---> '((a a) (a b) (a c) (b a) (c a)) 
;;; (Symmetric-Closure '((a a) (b b))) ;   ---> '((a a) (b b)) 
;;; (Symmetric-Closure '()) ;   ---> '() 


(define (Transitive-Closure relations)
    (transitive-closure-helper relations relations)
)


(define (transitive-closure-helper iRelations relations)
    (if [null? iRelations]
        relations
        (let ([newPairs (add-transitive-pairs (car iRelations) relations relations)])
            (transitive-closure-helper (append (cdr iRelations) newPairs) (append relations newPairs))
        )
    )
)

(define (add-transitive-pairs current jRelations relations)
    (if [null? jRelations]
        '()
        (let ([a (car current)] [b (car (cdr current))] [x (car (car jRelations))] [y (car (cdr (car jRelations)))])
            (if [and (equal? b x) (not (member? (list a y) relations))]
                (cons (list a y) (add-transitive-pairs current (cdr jRelations) relations))
                (add-transitive-pairs current (cdr jRelations) relations)
            )
        )
    )
)



(Transitive-Closure '((a b) (b c) (a c)))  ;  ---> '((a b) (b c) (a c)) 
(Transitive-Closure '((a a) (b b) (c c)))  ;  ---> '((a a) (b b) (c c)) 
(Transitive-Closure '((a b) (b a)))  ;  ---> '((a b) (b a) (a a) (b b))) 
(Transitive-Closure '((a b) (b a) (a a))) ;  ---> '((a b) (b a) (a a) (b b)) 
(Transitive-Closure '((a b) (b a) (a a) (b b))) ;  ---> '((a b) (b a) (a a) (b b)) 
(Transitive-Closure '()) ;  ---> '() 