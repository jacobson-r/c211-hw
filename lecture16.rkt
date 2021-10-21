;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture16) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A ListOfNumbers is one of:
; - empty
; - (cons Number ListOfNumbers)

;Exercise 1

; triple-numbers : ListOfNumbers -> ListOfNumbers
; returns a ListOfNumbers where each number is triple of the ListOfNumbers inputed
(define (triple-numbers A)
  (cond [(empty? A) A]
        [(cons? A)(cons (* (first A) 3) (triple-numbers (rest A)))]))

(check-expect (triple-numbers (cons 1 (cons 2 (cons 3 '())))) (cons 3 (cons 6 (cons 9 '()))))
(check-expect (triple-numbers (cons 3 (cons 2 (cons 1 '())))) (cons 9 (cons 6 (cons 3 '()))))
(check-expect (triple-numbers (cons 10 (cons 20 (cons 30 '())))) (cons 30 (cons 60 (cons 90 '()))))

;Exercise 2
; product : ListOfNumbers -> number
(define (product A)
    (cond [(empty? A) 1]
          [(cons? A) (* (first A) (product (rest A)))]))

(check-expect (product (cons 1 (cons 2 (cons 3 '())))) 6)
(check-expect (product (cons 3 (cons 2 (cons 1 '())))) 6)
(check-expect (product (cons 5 (cons 2 (cons 10 '())))) 100)