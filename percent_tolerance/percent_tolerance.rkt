#lang racket

(define (almost-equal-relative? a b percent-tolerance)
  (let ((epsilon (* (median (list a b 0)) (/ percent-tolerance 100.0))))
    (<= (abs (- a b)) epsilon)
  )
)

(define (median lst)
  (let* ((sorted (sort lst <))
         (len (length sorted))
         (mid (/ len 2)))
    (if (even? len)
        (/ (+ (list-ref sorted (sub1 mid)) (list-ref sorted mid)) 2)
        (list-ref sorted mid))))