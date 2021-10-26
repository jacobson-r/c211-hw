;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lecture19) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exersice 1
; sort-list : ListOfNumbers -> ListOfNumbers
; sort a list of numbers
; (define (sort-list a) ...)
; (define (sort-list a)
;   (... (first a) (rest a)))


(define (insert a n)
  (cond [(empty? a) (append (list n) a)]
        [(> (first a) n) (append (list n) a)]
        [else (append (list(first a)) (insert (rest a) n))]))

(insert '( 1 2 4 5 6) 3)
(insert '( 1 2 4 5 6) 7)
(insert '( 2 3) 1)
