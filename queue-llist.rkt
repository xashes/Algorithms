#lang typed/racket

(module+ test
  (require typed/rackunit)
  )

(provide empty-queue
         enqueue
         dequeue
         empty?
         size)

(define-type Queue (Listof Any))

(: empty-queue (-> Queue))
(define (empty-queue)
  null)
(module+ test
  (check-equal? (empty-queue) null)
  )

;; O(n)
(: enqueue (-> Any Queue Queue))
(define (enqueue v q)
  (if (empty? q)
      (cons v null)
      (cons (car q)
            (enqueue v (cdr q))))
  )
(module+ test
  (check-equal? (enqueue 'a '(1 2 3))
                '(1 2 3 a))
  )

;; O(1)
(: dequeue (-> Queue Queue))
(define (dequeue q)
  (if (empty? q)
      (error 'dequeue "The Queue is empty")
      (cdr q)))
(module+ test
  (check-equal? (dequeue '(1 2 3))
                '(2 3))
  )

;; observer
(: empty? (-> Queue Boolean))
(define (empty? q)
  (eq? (empty-queue) q)
  )
(module+ test
  (check-true (empty? null))
  (check-true (empty? (empty-queue)))
  )

(: size (-> Queue Natural))
(define (size q)
  (length q))
(module+ test
  (check-equal? (size '(1 2 3))
                3)
  )
