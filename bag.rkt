#lang typed/racket

(module+ test
  (require typed/rackunit)
  )

;; API
(provide empty-bag
         add-item
         empty?
         size)

(define-type Bag (Listof Real))

(: empty-bag (-> Bag))
(define (empty-bag)
  null)

(: add-item (-> Real Bag Bag))
(define (add-item n b)
  (cons n b))

(: add-item* (-> (Listof Real) Bag Bag))
(define (add-item* l b)
  (append l b))

(module+ test
  (let* ([eb (empty-bag)]
         [b1 (add-item 1 eb)]
         [b2 (add-item* '(2 3 4 5 6) b1)]
         )
    (check-equal? b1 '(1))
    (check-equal? b2 '(2 3 4 5 6 1))
    )
  )

(: empty? (-> Bag Boolean))
(define (empty? b)
  (equal? b (empty-bag))
  )
(module+ test
  (check-true (empty? (empty-bag)))
  (check-false (empty? '(1 2 3)))
  )

(: size (-> Bag Natural))
(define (size b)
  (length b)
  )
(module+ test
  (check-equal? (size (empty-bag)) 0)
  (check-equal? (size '(1 2 3)) 3)
  )
