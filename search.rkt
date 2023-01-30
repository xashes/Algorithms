#lang racket

(module+ test
  (require rackunit))

(define/contract (linear-search/list lon v)
  (-> (listof number?) number? (or/c nonnegative-integer? #f))
  (let search-from-index ([i 0]
                          [l lon])
    (if (null? l)
        #f
        (if (= (car l) v)
            i
            (search-from-index (add1 i) (cdr l)))))
  )
(module+ test
  (check-equal? (linear-search/list '(2 3 4 6) 0) #f)
  (check-equal? (linear-search/list '(2 3 4 6) 3)
                (index-of '(2 3 4 6) 3))
  )

(define/contract (linear-search/vector von v)
  (-> (vectorof number?) number? (or/c natural-number/c #f))
  (define len (vector-length von))
  (let loop ([i 0])
    (if (>= i len)
        #f
        (if (= v (vector-ref von i))
            i
            (loop (add1 i))
            ))))
(module+ test
  (let ([v1 #(1 2 3 4)]
        [v2 #(6 7 8 9)]
        [n 6])
    (check-equal? (linear-search/vector v1 n)
                  (vector-member n v1))
    (check-equal? (linear-search/vector v2 n)
                  (vector-member n v2))
    )
  )

(define/contract (binary-add/list l1 l2)
  (-> list? list? list?)
  (cond
    [(null? l1) l2]
    [(null? l2) l1]
    [else (let-values ([(carry r) (quotient/remainder (+ (car l1)
                                                         (car l2))
                                                      2)])
            (cons r
                  (if (zero? carry)
                      (binary-add/list (cdr l1)
                                       (cdr l2))
                      (binary-add/list
                       (binary-add/list (cons carry null)
                                        (cdr l1))
                       (cdr l2)))))]
    ))
(module+ test
  (check-equal? (binary-add/list '(1 0 1 1)
                                  '(1 1 0 1))
                '(0 0 0 1 1))
  ;; (string->list (number->string (+ #b1101 #b1011) 2))
  )

(define/contract (merge-sort-< lon)
  (-> (listof number?) (listof number?))
  (if (<= (length lon) 1)
      lon
      (let ([fst (car lon)])
        (append (merge-sort-< (filter (lambda (x) (< x fst)) (cdr lon)))
                (list fst)
                (merge-sort-< (filter (lambda (x) (>= x fst)) (cdr lon)))
                )
        )))
(module+ test
  (check-equal? (merge-sort-< '())
                '())
  (check-equal? (merge-sort-< '(3 2 6 8 1 9))
                '(1 2 3 6 8 9))
  )
