#lang racket

;; binary-search : Int Listof(Int) -> Int
;; usage: (binary-search n loi) -> index of n in loi, #f if not found
(define (binary-search n loi)
  (let bs-helper ([hi (sub1 (length loi))]
                  [lo 0]
                  [n n]
                  [loi loi])
    (let* ([mid (quotient (+ hi lo) 2)]
           [mid-val (list-ref loi mid)])
      (cond
        [(> lo hi) #f]
        [(> n mid-val) (bs-helper hi (add1 mid) n loi)]
        [(< n mid-val) (bs-helper (sub1 mid) lo n loi)]
        [else mid]
        ))))

(module+ test

  (require rackunit rackunit/text-ui)

  (check-equal? (binary-search 2 '(2 3 6 7 9 16)) 0)
  (check-equal? (binary-search 6 '(2 3 6 7 9 16)) 2)
  (check-equal? (binary-search 16 '(2 3 6 7 9 16)) 5)
  (check-equal? (binary-search 18 '(2 3 6 7 9 16)) #f)

  )
