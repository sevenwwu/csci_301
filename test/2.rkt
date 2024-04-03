#lang racket

(car '(x y z m))

(car (cdr '(y x z m)))

(car (cdr (cdr (cdr '(y z m x)))))

(car (car (cdr '((y) (x) (z) (m)))))

(car (cdr (car (cdr '((y z) (m x))))))