;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 1

; I learned that even production software has many bugs.
; How difficlt is it to run virtual tets to get a very close appriximation
; A similarity between the SDI software is both can have major bugs

; A Doll is one of:
; - (make-small-doll String)
; - (make-larger-doll Doll)
(define-struct small-doll (color))
(define-struct larger-doll (smaller))

; green-doll: Doll -> Doll
; returns a dool where the inner doll is green
(define (green-doll d)
  (make-small-doll "green"))

(check-expect (green-doll (make-small-doll "blue")) (make-small-doll "green"))