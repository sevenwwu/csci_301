#lang racket

(define (hailstone_print n)
    (begin
        (displayln n)

        (if [= n 1]
            void
            (if [= (modulo n 2) 0]
                (hailstone_print (/ n 2))
                (hailstone_print (+ (* 3 n) 1))
            )
        )
    )
)

(define (hailstone_num_of_iter n)
    (if [= n 1]
        1
        (if [= (modulo n 2) 0]
            (+ 1 (hailstone_num_of_iter (/ n 2)))
            (+ 1 (hailstone_num_of_iter (+ (* 3 n) 1)))
        )
    )
)

(define (find_greatest_num_of_iter_hailstone n greatest)
    (if [= n 0]
        greatest
        (if [> (hailstone_num_of_iter n) (hailstone_num_of_iter greatest)]
            (find_greatest_num_of_iter_hailstone (- n 1) n)
            (find_greatest_num_of_iter_hailstone (- n 1) greatest)
        )
    )
)


(define (sum_of_range_hailstone_iters n)
    (if [= n 0]
        0
        (+ (hailstone_num_of_iter n) (sum_of_range_hailstone_iters (- n 1)))
    )
)

(define (average_sum_of_range_hailstone_iters n)
    (real->double-flonum (/ (sum_of_range_hailstone_iters n) n))
)


(find_greatest_num_of_iter_hailstone 10000000 1)