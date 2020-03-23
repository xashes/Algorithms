#lang racket

(provide
 (contract-out
  [hash-func (-> symbol? integer?)]
  [hash-table (-> integer? vector?)]
  ))

(define (hash-table size)
  (make-vector size null)
  )

(define (hash-func key)
  (string-length (symbol->string key)))

(define (hash-table-set! ht key val)
  (let ([idx (hash-func key)])
    (vector-set! ht idx (cons val (vector-ref ht idx)))
    )
  )
(char-alphabetic? #\b)

(module+ test

  (require rackunit rackunit/text-ui)

  (check-equal? (hash-func 'key) 3)
  (let ([ht (hash-table 10)])
    (hash-table-set! ht 'apple 4)
    ht
    )

  )
