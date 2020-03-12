#lang racket

(module+ test
  (require rackunit rackunit/text-ui)
  )

(define/contract (qsort lon)
  (-> (listof number?) (listof number?))
  (if (null? lon)
      null
      (let ([c (car lon)])
        (append (qsort (filter (lambda (x) (< x c)) lon))
                (list c)
                (qsort (filter (lambda (x) (> x c)) lon)))))
  )
(module+ test
  (let ([l1 '(1 8 2 6 5)])
    (check-equal? (qsort l1) (sort l1 <)))
  )
