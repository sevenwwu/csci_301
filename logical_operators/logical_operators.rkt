#lang racket

; (define (|| p q) (or p q))

(define-syntax || 
  (syntax-rules ()
    ((_ x ...) (or x ...))))

(|| #t #t)
(|| #t #f)
(|| #f #t)
(|| #f #f)
