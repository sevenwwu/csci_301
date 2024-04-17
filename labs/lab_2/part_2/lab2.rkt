#lang racket


(define (gen-list start end)
    (if [> start end]
        '()
        (cons start (gen-list (+ start 1) end))
    )
)

(define (sum nums)
    (if [null? nums]
        0
        (+ (car nums) (sum (cdr nums)))
    )
)

(define (retrieve-first-n n lst)
    (if [or (<= n 0) (null? lst)]
        '()
        (cons (car lst) (retrieve-first-n (- n 1) (cdr lst))) ; grab current item and put it
                                                              ; to front of list that will
                                                              ; soon exist
    )
)

(define (pair-sum? lst val)
    (if [<= (length lst) 1]
        #f 
        (or 
            (= (+ (car lst) (car (cdr lst))) val)   ; grab current and next and check if 
                                                    ; they sum to `val`.

            (pair-sum? (cdr lst) val)               ; if not, check the next pair which is
                                                    ; next and next's next
        )    
    )
)