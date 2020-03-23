#lang typed/racket

(require "stack.rkt")

(: list-reverse (-> (Listof Any) (Listof Any)))
(define (list-reverse l)
  (stack->list
   (let push-to-stack ([stk : Stack (empty-stack)]
                       [lst l])
     (if (empty? lst)
         stk
         (push-to-stack (push (car lst) stk)
                        (cdr lst)))
     ))
  )

(module+ test

  (require typed/rackunit typed/rackunit/text-ui)

  (let ([l1 '(6 5 4 3 2 1)])
    (check-equal? (list-reverse l1)
                  '(1 2 3 4 5 6))
    )

  )
