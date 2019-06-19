#lang typed/racket

(provide create-node
         add-neighbor
         (struct-out node))

(struct node ([content : Any] [neighbors : (Listof node)]) #:transparent)

; create node with '() as default value for neighbors
(: create-node (-> Any node * node))
(define (create-node content . neighbors)
  (node content neighbors)
  )

; add neighbor to node n
(: add-neighbor (-> node node * node))
(define (add-neighbor n . nes)
  (let ([content (node-content n)]
        [neighbor (node-neighbors n)])
    (node content (append neighbor nes)))
  )

; create edge

; generate graph given edges and nodes

(module+ test

  (require typed/rackunit typed/rackunit/text-ui)

  (define n1 (node "n1" '()))
  (define n2 (node "n2" '()))
  (check-equal? (create-node "n0")
                (node "n0" '()))
  (check-equal? (create-node "n0" n1 n2)
                (node "n0" `(,n1 ,n2)))
  (check-equal? (add-neighbor n1 n2)
                (node "n1" `(,n2)))

  (define you (create-node "you"))
  (define bob (create-node "bob"))
  (define anuj (create-node "anuj"))
  (define peggy (create-node "peggy"))
  (define alice (create-node "alice"))
  (define claire (create-node "claire"))
  (define thom (create-node "thom"))
  (define jonny (create-node "jonny"))
  (set! you (add-neighbor you bob alice claire))
  (set! bob (add-neighbor bob anuj peggy))
  (set! alice (add-neighbor alice peggy))

  )
