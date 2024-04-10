#lang racket


 (define (run-symbol-as-function sym)
   (eval sym))

 (define (_hello)
   (displayln "Hello, World!"))

 (run-symbol-as-function 'hello)