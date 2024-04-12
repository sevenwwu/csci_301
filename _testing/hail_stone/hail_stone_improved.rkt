#lang racket

(define (hailstone_step n)
  (if (even? n)
      (/ n 2)
      (+ (* 3 n) 1)))

(define (hailstone_print n)
  (displayln n)
  (unless (= n 1)
    (hailstone_print (hailstone_step n))))

(define (hailstone_num_of_iter n)
  (if (= n 1)
      1
      (+ 1 (hailstone_num_of_iter (hailstone_step n)))))

(define (sum_of_range_hailstone_iters n)
  (let loop ((i n) (sum 0))
    (if (= i 0)
        sum
        (loop (- i 1) (+ sum (hailstone_num_of_iter i))))))

(define (average_sum_of_range_hailstone_iters n)
  (real->double-flonum (/ (sum_of_range_hailstone_iters n) n)))