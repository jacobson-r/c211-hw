;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; A EvenMorePoints is one of
;; - (make-none)
;; - (make-one Point)
;; - (make-two Point Point)
;; - (make-three Point Point Point)
(define-struct none ())
(define-struct one (first))
(define-struct two (first second))
(define-struct three (first second third))
 
;; A Point is (make-point Number Number)
(define-struct point [x y])

