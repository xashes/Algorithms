#lang racket

(module+ test
  (require rackunit))
(require math/number-theory)

;; use seive method
(define/contract (sieve stm)
  (-> stream? stream?)
  (stream-cons (stream-first stm)
               (sieve (stream-filter (lambda (x) (not (zero? (remainder x (stream-first stm)))))
                                     (stream-rest stm)))))
(define/contract (integers-from-n n)
  (-> integer? stream?)
  (stream-cons n (integers-from-n (add1 n)))
  )
(define primes/stream (sieve (integers-from-n 2)))

(module+ test
  (check-equal? (nth-prime 5) (stream-ref primes/stream 5))
  )


