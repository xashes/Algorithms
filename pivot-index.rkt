#lang racket

;; 给定一个整数类型的数组 nums，请编写一个能够返回数组“中心索引”的方法。

;; 我们是这样定义数组中心索引的：数组中心索引的左侧所有元素相加的和等于右侧所有元素相加的和。

;; 如果数组不存在中心索引，那么我们应该返回 -1。如果数组有多个中心索引，那么我们应该返回最靠近左边的那一个。

(provide (contract-out [pivot-index (-> (vectorof integer?) nonnegative-integer?)]))
(define (pivot-index vec)
  (let ([s (vector-sum vec)])
    (let helper ([n 0])
      (let ([partial-sum (vector-sum (vector-take vec n))])
        (cond
          [(= n (vector-length vec)) -1]
          [(= partial-sum (/ s 2)) n]
          [else (helper (add1 n))]
          ))
      ))
  )
(module+ test
  (require rackunit rackunit/text-ui)

  (check-equal? (pivot-index #(1 7 3 6 5 6)) 3)
  (check-equal? (pivot-index #(1 2 3)) -1)
  )

(provide (contract-out [vector-sum (-> (vectorof integer?) integer?)]))
(define (vector-sum vec)
  (apply + (vector->list vec))
  )
(module+ test
  (check-equal? (vector-sum #()) 0)
  (check-equal? (vector-sum #(1 2 3)) 6)
  )
