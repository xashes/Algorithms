#lang racket

(module+ test
  (require rackunit rackunit/text-ui)
  )

(define/contract (bin-search n von)
  (-> number? (vectorof number?) (or/c natural? #f))
  (let search-in ([low 0]
                  [high (sub1 (vector-length von))])
    (let* ([mid (quotient (+ low high)
                          2)]
           [mid-number (vector-ref von mid)])
      (cond
        [(< high low) #f]
        [(= n mid-number) mid]
        [(> n mid-number) (search-in (add1 mid) high)]
        [(< n mid-number) (search-in low (sub1 mid))]
        ))
    )
  )
(module+ test
  (check-equal? (bin-search 5 #(1 2 5 8 9)) 2)
  (check-equal? (bin-search 3.5 #(1 2 3.5 5 8 9)) 2)
  (check-equal? (bin-search 5 #(1 2 6 7 8)) #f)
  )

(define/contract (bin-search-steps n von)
  (-> number? (vectorof number?) (listof (or/c natural? #f)))
  (let search-in ([low 0]
                  [high (sub1 (vector-length von))])
    (let* ([mid (quotient (+ low high)
                          2)]
           [mid-number (vector-ref von mid)])
      (cond
        [(< high low) (list #f)]
        [(= n mid-number) (cons mid null)]
        [(> n mid-number) (cons mid (search-in (add1 mid) high))]
        [(< n mid-number) (cons mid (search-in low (sub1 mid)))]
        ))
    )
  )
(module+ test
  (check-equal? (bin-search-steps 9 #(1 2 5 8 9)) '(2 3 4))
  (check-equal? (bin-search-steps 3.5 #(0 1 2 3.5 5 8 9 10 12 16)) '(4 1 2 3))
  (check-equal? (bin-search-steps 5 #(1 2 6 7 8)) '(2 0 1 #f))
  )
