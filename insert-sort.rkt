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
  (-> (vectorof number?) void?)
  (for ([j (in-range 1 (vector-length vec))])
    (let ([key (vector-ref vec j)])
      (let insert-to ([i (sub1 j)])
        (if (and (>= i 0)
                 (> (vector-ref vec i) key))
            (begin
              (vector-set! vec (add1 i) (vector-ref vec i))
              (insert-to (sub1 i)))
            (vector-set! vec (add1 i) key)
            ))))
  )
(module+ test
  (define v (vector 4 6 1 2 8 3))
  (define v2 (vector))
  (check-equal? (begin (insertion-sort! v) v)
                (vector 1 2 3 4 6 8))
  (check-equal? (begin (insertion-sort! v2) v2)
                (vector))
  )

(define (insert-to-sorted-< n lon)
  (if (null? lon)
      (cons n null)
      (if (< n (car lon))
          (cons n lon)
          (cons (car lon)
                (insert-to-sorted-< n (cdr lon))))))
