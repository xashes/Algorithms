#lang racket

(module+ test
  (require rackunit))

(define/contract (count lst)
  (-> list? natural?)
  (if (empty? lst)
      0
      (+ 1 (count (cdr lst)))
      )
  )

(module+ test
  (check-equal? (count '()) 0)
  (check-equal? (count '(a b c)) 3)
  )

(define/contract (max lon)
  (-> (listof number?) (or/c number? null?))
  (if (empty? lon)
      null
      (let ((c (car lon)))
        (if (= (length lon) 1)
            c
            (if (> c (max (cdr lon)))
                c
                (max (cdr lon))
                )
            ))))

(module+ test
  (check-equal? (max '()) null)
  (check-equal? (max '(1 2 3)) 3)
  )

(define/contract (bin-search lon value)
  (-> (listof number?) number? (or/c null? number?))
  (if (empty? lon)
      null
      (let ((mid-idx )))
      )
  )

(module+ test
  (check-equal? (bin-search '(1 3 5 7 2) 3) 1)
  )
