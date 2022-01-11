;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exersice 1
; A ByTwoN is one of:
; - empty
; - (make-two Number ByTwoN Number)
(define-struct two [left rest right])

(define var (make-two 2 empty 4))

; count-bytwon : bytwon -> number
; counts the number of numbers in a bytwon
(define (count-bytwon a)
  (cond [(equal? (two-rest a) empty) 2]
        [else (+ 2 (count-bytwon (two-rest a)))]))

(check-expect (count-bytwon (make-two 2 empty 4)) 2)
(check-expect (count-bytwon (make-two 2 (make-two 2 empty 4) 4)) 4)

;Exersice 2
; sum-bytwon : bytwon -> number
; sums the numbers in a bytwon
(define (sum-bytwon a)
;  (cond [(equal? (two-rest a) empty) (+ (two-left a) (two-right a))]
;        [else (+ (two-left a) (two-right a) (sum-bytwon (two-rest a)))]))
  (fold-bytwon a +))

(check-expect (sum-bytwon (make-two 2 empty 4)) 6)
(check-expect (sum-bytwon (make-two 2 (make-two 2 empty 4) 4)) 12)

;Exersice 3
; sum-bytwon : bytwon -> number
; sums the numbers in a bytwon
(define (product-bytwon a)
;  (cond [(equal? (two-rest a) empty) (* (two-left a) (two-right a))]
;        [else (* (two-left a) (two-right a) (product-bytwon (two-rest a)))]))
  (fold-bytwon a *))

(check-expect (product-bytwon (make-two 2 empty 4)) 8)
(check-expect (product-bytwon (make-two 2 (make-two 2 empty 4) 4)) 64)

;Exersice 5
(define (fold-bytwon a b)
  (cond [(equal? (two-rest a) empty) (b (two-left a) (two-right a))]
        [else (b (two-left a) (two-right a) (fold-bytwon (two-rest a) b))]))


;Exersice 6
(define (count2 a)
  (fold-bytwon (lambda (left rest right) (+ 2 rest))))

;(check-expect (count2 (make-two 2 (make-two 2 empty 4) 4)) 4)

;Exersice 7
; A ByTwoS is one of:
; - empty
; - (make-two string ByTwoS String)
;(define-struct two [left rest right])

;Exersice 8
(define (ntos a)
   (cond [(empty? a) empty]
        [else (make-two (number->string (two-left a)) (ntos (two-rest a)) (number->string (two-right a)))]))

;Exersice 9

(define (ston a)
   (cond [(empty? a) empty]
        [else (make-two (string->number (two-left a)) (ntos (two-rest a)) (string->number (two-right a)))]))

;Exersice 10

(define (folderrr a w)
   (cond [(empty? a) empty]
        [else (make-two (w (two-left a)) (ntos (two-rest a) w) (w (two-right a)))]))