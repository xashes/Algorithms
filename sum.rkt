#lang racket

(module+ test
  (require rackunit))

(define/contract (sum lon)
  (-> (listof number?) number?)
  (if (empty? lon)
      0
      (+ (car lon) (sum (cdr lon)))
      )
  )

(module+ test
  (check-= (sum '()) 0 0.1)
  (check-= (sum '(1 2 3)) 6 0.1)
  )
