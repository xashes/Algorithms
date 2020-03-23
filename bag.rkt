#lang typed/racket

(require "stats.rkt")

;; API
;; empty-bag
;; add-item
;; size

(define-type Bag (Listof Real))

(: empty-bag (-> Null))
(define (empty-bag)
  null)

(: add-item (-> Real Bag Bag))
(define (add-item n b)
  (cons n b))

(: add-item* (-> (Listof Real) Bag Bag))
(define (add-item* l b)
  (append l b))

(module+ test

  (require typed/rackunit typed/rackunit/text-ui)

  (let* ([eb (empty-bag)]
         [b1 (add-item 1 eb)]
         [b2 (add-item* '(2 3 4 5 6) b1)]
         )
    (check-equal? b1 '(1))
    (check-equal? b2 '(2 3 4 5 6 1))
    )

  )
