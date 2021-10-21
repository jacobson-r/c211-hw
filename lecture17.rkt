;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lecture17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 2

; between-20-50 : ListOfNumbers -> ListOfNumbers
; returns a list of numbers that that is between 20 and 50
(define (between-20-50 a)
  (cond [(empty? a) a]
        [(cons? a)
                (cond [(and (<= (first a) 50) (<= 20 (first a))) (cons (first a) (between-20-50
                                                                                  (rest a)))]
                      [else (between-20-50 (rest a))])]))

(check-expect (between-20-50 (cons 5 (cons 23 (cons 49 (cons 60 '()))))) (list 23 49))
(check-expect (between-20-50 (cons 10 (cons 23 (cons 49 (cons 60 '()))))) (list 23 49))
(check-expect (between-20-50 (cons 23 (cons 30 (cons 79 (cons 80 '()))))) (list 23 30))
(check-expect (between-20-50 (cons 80 (cons 500 (cons 25 (cons 90 '()))))) (list 25))