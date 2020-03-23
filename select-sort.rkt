#lang racket

(module+ test
  (require rackunit rackunit/text-ui)
  )

;; O(n^2)
(define/contract (sort/select lon)
  (-> (listof number?) (listof number?))
  (if (null? lon)
      null
      (let ([m (minimum lon)])
        (cons m
              (sort/select (remove m lon))))
      )
  )
(module+ test
  (let ([lon '(2 3 1 6 8)])
    (check-equal? (sort/select lon) (sort lon <)))
  )
;; O(n)
(define/contract (minimum lon)
  (-> (listof number?) number?)
  (let min-with ([i (car lon)]
                 [lst (cdr lon)])
    (if (null? lst)
        i
        (let ([c (car lst)])
          (if (< i c)
              (min-with i (cdr lst))
              (min-with c (cdr lst))))))
  )
(module+ test
  (check-equal? (minimum '(2 3 1 -6 9)) -6)
  )
