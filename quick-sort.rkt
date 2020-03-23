#lang racket

(define (quick-sort lor)
  (let ([len (length lor)])
    (cond
      [(<= len 1) lor]
      [(= len 2)
       (if (<= (first lor) (second lor))
           lor
           (reverse lor))]
      [else
       (let* ([pivot (car lor)]
              [left (filter (lambda (x) (<= x pivot)) (cdr lor))]
              [right (filter (lambda (x) (> x pivot)) (cdr lor))]
              )
         (append (quick-sort left) (list pivot) (quick-sort right)))]
      )
    )
  )

(quick-sort '(6 3 8 1 9 2 7 6))
