#lang typed/racket

(require "stack.rkt")

(: string->stack (-> String Stack))
(define (string->stack s)
  (list->stack (string->list s))
  )

(module+ test

  (require typed/rackunit typed/rackunit/text-ui)

  (let ([lst "(+ (+ 2 3 6) (* 2 6))"])
    (string->list lst)
    )

  )
