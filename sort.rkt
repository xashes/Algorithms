#lang racket
(require rackunit)

(define (barrel lat)
  (let ([l range (11)])
    (cond [(null? lat) '()]
          )))

(check-equal? (barrel '(5 3 5 2 8)) '(8 5 5 3 2))
