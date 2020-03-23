#lang racket

(define queue%
  (class object%
    (init size)

    (define head 0)
    (define tail (sub1 size))

    (super-new)

    (define/public (get-tail) tail)

    ))

(module+ test

  (require rackunit rackunit/text-ui)

  (define q (new queue% [size 10]))
  (send q get-tail)

  )
