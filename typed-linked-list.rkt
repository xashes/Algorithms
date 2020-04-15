#lang typed/racket

; API
; construct - cons
; item - car
; pointer - cdr
; llist - list
(provide construct
         llist
         item
         pointer
         node?
         llist?
         llist-append
         llist-head
         llist-drop
         )

; LL ::= '() | (cons Any LL)
(define-type LList (U Null node))
(define-predicate llist? LList)
(struct node ([item : Any] [pointer : LList]) #:transparent)

(module+ test

  (require typed/rackunit typed/rackunit/text-ui)

  (define ll0 '())
  (define ll1 (node 1 ll0))
  (define ll2 (node 2 ll1))
  (check-false (node? ll0))
  (check-true (llist? ll0))
  (check-true (node? ll1))
  (check-true (node? ll2))

  )

; construct node
(: construct (All (A) (-> A LList node)))
(define (construct v ll)
  (node v ll)
  )
(module+ test
  (check-equal? (construct 1 '()) ll1)
  )

; construct LList from args
(: llist (All (A) (-> A * LList)))
(define (llist . rst)
  (if (empty? rst)
      '()
      (construct (first rst)
                 (apply llist (rest rst))))
  )
(module+ test
  (check-equal? (llist) '())
  (check-equal? (llist 6 1)
                (construct 6
                           (construct 1 '())))
  )

; extract the left part of node
(: item (-> node Any))
(define (item n)
  (node-item n))
(module+ test
  (check-equal? (item ll1) 1)
  )

; extract the LList that the node pointed
(: pointer (-> node LList))
(define (pointer n)
  (node-pointer n))
(module+ test
  (check-equal? (pointer ll1) ll0)
  )

; append ll2 to ll1
(: llist-append (-> LList LList LList))
(define (llist-append ll1 ll2)
  (if (empty? ll1)
      ll2
      (construct (item ll1)
                 (llist-append (pointer ll1) ll2))
      )
  )
(module+ test
  (check-equal? (llist-append ll0 ll0) ll0)
  (check-equal? (llist-append ll0 ll1) ll1)
  (check-equal? (llist-append ll1 ll0) ll1)
  (check-equal? (llist-append ll2 ll1) (llist 2 1 1))
  )

(: llist-length (-> LList Natural))
(define (llist-length ll)
  (if (null? ll)
      0
      (add1 (llist-length (pointer ll))))
  )
(module+ test
  (check-equal? (llist-length '()) 0)
  (check-equal? (llist-length (llist 1 2 3)) 3)
  )

(: llist-head (-> LList Natural LList))
(define (llist-head ll n)
  (cond
    [(> n (llist-length ll)) (error 'llist-head "expected: a LList with at least ~a elements\ngiven: ~a"
                                    n ll)]
    [(zero? n) '()]
    [else (construct (item (assert ll node?))
                     (llist-head (pointer (assert ll node?)) (sub1 n)))])
  )
(module+ test
  (check-equal? (llist-head (llist 1 2 3) 0) '())
  (check-equal? (llist-head (llist 1 2 3) 2) (llist 1 2))
  )

(: llist-drop (-> LList Natural LList))
(define (llist-drop ll n)
  (cond
    [(> n (llist-length ll)) (error 'llist-drop "expected: a LList with at least ~a elements\ngiven: ~a"
                                    n ll)]
    [(zero? n) ll]
    [else (llist-drop (pointer (assert ll node?))
                      (sub1 n))]))
(module+ test
  (check-equal? (llist-drop (llist 1 2 3) 0) (llist 1 2 3))
  (check-equal? (llist-drop (llist 1 2 3) 2) (llist 3))
  (check-equal? (llist-drop (llist 1 2 3) 3) '())
  )