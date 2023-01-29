#lang racket

(module+ test
  (require rackunit))

;; input: 升序排列的数组
;; output: length of result list
;; Purpose: 原地删除重复出现的元素
(define/contract (rm-duplicates nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (if (<= (length nums) 1)
      nums
      (let ([fst (car nums)]
            [rst (cdr nums)])
        (if (< fst (car rst))
            (cons fst (rm-duplicates rst))
            (rm-duplicates rst))))
  )

(module+ test
  (check-equal? (rm-duplicates '(1 1 2 3 4 4 5))
                '(1 2 3 4 5))
  )

(define/contract (remove-duplicates nums)
  (-> (listof exact-integer?) exact-integer?)
  (set! nums (rm-duplicates nums))
  (length nums)
  )
(module+ test
  (let ([nums '(1 1 2 3 3 4 5 5)])
    (let ([result (remove-duplicates nums)])
      (check-equal? result 5)
      (check-equal? nums '(1 2 3 4 5))
      ))
  )
