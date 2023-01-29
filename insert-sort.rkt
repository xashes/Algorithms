#lang racket

(module+ test
  (require rackunit))

;; (for j ([in-range 2 len])
;;      key = A[j]
;;      (insert-to-sorted-sequence A[j] A[:j-1])
;;      )

(define/contract (insertion-sort lon)
  (-> (listof number?) (listof number?))
  (let insert-to ([old lon]
                  [newl null])
    (if (null? old)
        newl
        (insert-to (cdr old) (insert-to-sorted-< (car old) newl))
        )))
(module+ test
  (check-equal? (insertion-sort '(5 2 4 6 1 3))
                '(1 2 3 4 5 6))
  (check-equal? (insertion-sort '())
                '())
  )

(define/contract (insertion-sort! vec)
  (-> (vectorof number?) (vectorof number?))
  vec
  )

(define (insert-to-sorted-< n lon)
  (if (null? lon)
      (cons n null)
      (if (< n (car lon))
          (cons n lon)
          (cons (car lon)
                (insert-to-sorted-< n (cdr lon))))))
