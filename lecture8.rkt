;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 1

; computers are not always very accurate
; how can we make the computer more accurate
; an exaple of a feedback loop is where more crime is expected to happen in one area so they put more
;     cops in the area so more is caught and the cycle repeats.

;Exercise 2

; A Point is (make-point Number Number)
(define-struct point [x y])
(define here  (make-point 30 50))
(define there (make-point 70 40))
 
; A Person is (make-person String Number)
(define-struct person [name age])
(define me  (make-person "Alice" 37))
(define you (make-person "Bob"   22))

; 40
; "bob"
; #false
; error
; (make-person "Carol" 21)