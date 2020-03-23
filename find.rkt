#lang typed/racket

;; 给定两个字符串，如果第一个字符串有在第二个字符串中出现，则返回其第一个字符的索引，否则返回#f.
;; 从字符串开始开始检查
;; 如果当前字符开始的片段与第一个字符串相等，则返回当前字符的索引
;; 如果不等，则逐字符遍历字符串，如果没有相等片段，则返回#f
(: find (-> String String (U Boolean Integer)))
(define (find search source)
  (let find-from-n ([search (string->list search)]
                    [source (string->list source)]
                    [n 0])
    (if (empty? source)
        #f
        (if (empty? search)
            n
            (if (equal? (car search) (car source))
                (find-from-n (cdr search) (cdr source) n)
                (find-from-n search (cdr source) (add1 n))
                )))))

(module+ test

  (require typed/rackunit typed/rackunit/text-ui)

  (check-equal? (find "yes" "abcdyesok") 4)
  (check-false (find "yes" "abcdyeahok"))

  )
