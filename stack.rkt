#lang typed/racket

(provide Stack
         empty-stack
         push
         top
         pop
         stack->list
         list->stack)

(define-type Stack (U empty-stack ext-stack))
(struct empty-stack () #:transparent)
(struct ext-stack ([top : Any] [rest : Stack]) #:transparent)

;; constructors
(: push (-> Any Stack Stack))
(define (push val stk)
  (ext-stack val stk))

;; observers
(: top (-> Stack Any))
(define (top stk)
  (if (empty-stack? stk)
      (error 'top "Stack is empty.")
      (ext-stack-top stk)))

(: pop (-> Stack Stack))
(define (pop stk)
  (if (empty-stack? stk)
      (error 'pop "Stack is empty.")
      (ext-stack-rest stk)))

(: stack->list (-> Stack (Listof Any)))
(define (stack->list stk)
  (if (empty-stack? stk)
      null
      (cons (top stk) (stack->list (pop stk))))
  )

(: list->stack (-> (Listof Any) Stack))
(define (list->stack l)
  (let push-to-stack ([stk : Stack (empty-stack)]
                      [lst l])
    (if (empty? lst)
        stk
        (push-to-stack (push (car lst) stk)
                       (cdr lst)))
    ))

(module+ test

  (require typed/rackunit typed/rackunit/text-ui)

  (let* ([s1 (empty-stack)]
         [s2 (push 8 s1)]
         [s3 (push 9 s2)]
         )
    (check-equal? (top s2) 8)
    (check-equal? (top s3) 9)
    (check-equal? (pop s3) s2)
    (check-equal? (pop s2) s1)
    (check-equal? (stack->list s3) '(9 8))
    (check-equal? (list->stack '(a 1 2))
                  (push 2 (push 1 (push 'a (empty-stack)))))
    )
  )

