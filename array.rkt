#lang racket

; Usage
(module+ test
  (require rackunit rackunit/text-ui)

  ; Initialize
  (define arr (make-vector 5))
  (define arr2 #5(1 2 3))
  (define arr3 (vector 1 2 3 3 3))
  (define arr4 (vector-immutable 1 2 3 3 3))

  (check-equal? arr #(0 0 0 0 0))
  (check-equal? arr2 arr3)
  (check-equal? arr2 arr4)
  (check-false (immutable? arr))
  (check-false (immutable? arr3))
  (check-true (immutable? arr2))
  (check-true (immutable? arr4))

  ; Get Length
  (check-equal? (vector-length arr) 5)

  ; Access Element
  (check-equal? (vector-ref arr2 4) 3)

  ; Iterate all Elements
  (check-equal? (for/vector ([i (in-vector arr4)])
                  i)
                #(1 2 3 3 3))

  ; Modify Element
  (check-true (void? (vector-set! arr3 4 6)))
  (check-equal? arr3 #(1 2 3 3 6))

  ; sort
  (check-equal? (vector-sort arr4 > 0 3)
                #(3 2 1))
  )
