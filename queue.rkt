#lang racket

;; (provide
;;  (contract-out
;;   [make-queue (-> integer? vector?)]
;;   [enqueue (-> any queue? queue?)]
;;   [dequeue (-> queue? queue?)]
;;   [head natural-number/c]
;;   [tail natural-number/c]
;;   ))

(define head -1)
(define tail -1)

(define (move-head)
  (set! head (add1 head))
  )
(define (move-tail)
  (set! tail (add1 tail)))

(define (reset-head-and-tail)
  (set! head -1)
  (set! tail -1))

(define (make-queue size)
  (make-vector size null))

(define (empty-queue? q)
  (or (= head -1)
      (= tail -1)))

(define (head-idx q head)
  (if (empty-queue? q)
      head
      (remainder head (vector-length q))))

(define (tail-idx q tail)
  (if (empty-queue? q)
      tail
      (remainder tail (vector-length q))))

(define (full-queue? q)
  (= (remainder head (vector-length q))
     (remainder (add1 tail) (vector-length q)))
  )

(define (display-queue q)
  (let ([h (head-idx q head)]
        [t (tail-idx q tail)])
    (if (empty-queue? q)
        #()
        (if (< (head-idx q head) (tail-idx q tail))
            (vector-copy q )
            #()))))

(define (enqueue val q)
  (if (full-queue? q)
      (error 'enqueue "The queue ~s is full." q)
      (if (empty-queue? q)
          (begin
            (move-head)
            (move-tail)
            (vector-set! q (tail-idx q tail) val))
          (begin
            (move-tail)
            (vector-set! q (tail-idx q tail) val))
          )))

(define (dequeue q)
  (cond
    [(empty-queue? q)
     (error 'dequeue "The queue ~s is empty." q)]
    [(= head tail)
     (reset-head-and-tail)]
    [else
     (move-head)]
    )
  )

(module+ test

  (require rackunit rackunit/text-ui)

  (let* ([q (make-queue 3)]
         )
    (displayln q)
    (enqueue 1 q)
    (enqueue 2 q)
    (enqueue 3 q)
    (display-queue q)
    (dequeue q)
    (dequeue q)
    (enqueue 4 q)
    (enqueue 5 q)
    (display-queue q)
    (dequeue q)
    (display-queue q)
    )

  )
