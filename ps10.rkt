;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ps10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A PrefixForest is a [NEListOf PrefixTree]
 
; A PrefixTree is one of:
; - (make-end)
; - (make-initial 1String PrefixForest)
 
(define-struct end [])
(define-struct initial [letter forest])
 
; A 1String a String of length 1

(define forest1
  (list
   (make-initial "n"
                 (list
                  (make-end)
                  (make-initial "e" (list (make-end)))))
   (make-initial "f"
                 (list
                  (make-end)
                  (make-initial "f" (list (make-end)))
                  (make-initial "t" (list (make-end)))))
   (make-initial "r" (list (make-end)))))

(define tree1 (make-initial "o" forest1))

;Exersice 1

(define forest2
  (list
   (make-initial "a"
                 (list
                  (make-end)
                  (make-initial "b" (list (make-end)))))
   (make-initial "c"
                 (list
                  (make-end)
                  (make-initial "d" (list (make-end)))
                  (make-initial "e" (list (make-end)))))
   (make-initial "f" (list (make-end)))))

(define tree2 (make-initial "g" forest2))

(define forest3
  (list
   (make-initial "z"
                 (list
                  (make-end)
                  (make-initial "x" (list (make-end)))))
   (make-initial "y"
                 (list
                  (make-end)
                  (make-initial "g" (list (make-end)))
                  (make-initial "h" (list (make-end)))))
   (make-initial "i" (list (make-end)))))

(define tree3 (make-initial "p" forest2))

;Exercise 2

(define (process-tree a)
  (cond [(cons? a) (... (first a) (process-forest(rest a)))]
        [(empty? a) a]))

(define (process-forest a)
  (process-tree a))

;Exercise 3

; tree-size : PrefixTree -> number
; returns the size of the tree
(define (tree-size a)
  (cond [(empty? a) 1]
        [(end? a) 1]
        [(initial? a) (+ (forest-size (initial-forest a)) 0)]
        [(list? a) (tree-size (first a))]))

; forest-size : PrefixForest -> number
; returns the size of the forest
(define (forest-size a)
  (+ (tree-size (first a)) (tree-size (rest a))))

(check-expect (tree-size tree1) 6)
(check-expect (tree-size tree2) 6)
(check-expect (tree-size tree3) 6)


;Exercise 4
; tree->list : PrefixTree -> list
; returns all posible words as a list
(define (tree->list a)...)
  

; forest->list : PrefixForest -> list
; returns all posible words as a list
