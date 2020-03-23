#lang typed/racket

(provide sum
         mean
         variance
         std)

(: sum (-> (Listof Real) Real))
(define (sum lor)
  (apply + lor))

(: square-sum (-> (Listof Real) Nonnegative-Real))
(define (square-sum lor)
  (apply + (for/list : (Listof Nonnegative-Real)
             ([i : Real lor])
             (sqr i))))

(: mean (-> (Listof Real) Real))
(define (mean lor)
  (/ (sum lor)
     (length lor)))

(: variance (-> (Listof Real) Real))
(define (variance lor)
  (let* ([mu : Real (mean lor)]
         [n : Integer (sub1 (length lor))]
         [diffs (for/list : (Listof Real)
                    ([i : Real lor])
                  (abs (- i mu)))])
    (with-asserts ([n positive-integer?])
      (/ (square-sum diffs)
         n))))

(: std (-> (Listof Real) Real))
(define (std lor)
  (real-part (sqrt (variance lor))))

(module+ test

  (require typed/rackunit typed/rackunit/text-ui)

  (let ([lor '(100 99 101 120 98 107 109 81 101 90)])
    (check-equal? (square-sum '(1 2 3)) 14)
    (check-equal? (mean lor) 503/5)
    (check-true (< (- (std lor) 10.51) 0.01))
    )

  )
