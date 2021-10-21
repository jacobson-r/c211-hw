;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Point is (make-point Number Number)
(define-struct point [x y])
 
; A Person is (make-person String Number)
(define-struct person [name age])

;Exercise 1
; 1. Number
; 2. boolean
; 3. string
; 4. string
; 5. circle
; 6. point
; 7. person

;Exercise 2
; b : point -> point
; adds one to each x,y of a point
; (define (move-point p)...)

(check-expect (move-point (make-point 1 1)) (make-point 2 2))
(check-expect (move-point (make-point 2 2)) (make-point 3 3))

;(define (move-point p) ...p...)
(define (move-point p)
  (make-point (+ 1 (point-x p)) (+ 1 (point-y p))))

;Exercise 3
; point is a struct not just 2 numbers
; you give numbers not points
; you give 2 numbers not a point
; it is refering to numbers not points
; the function does not make a new point

;Exercise 4
; half-point : point -> point
; halfs each x,y of a point
; (define (half-point p)...)

(check-expect (half-point (make-point 4 4)) (make-point 2 2))
(check-expect (half-point (make-point 6 6)) (make-point 3 3))

;(define (half-point p) ...p...)
(define (half-point p)
  (make-point (/ (point-x p) 2) (/ (point-y p) 2)))

;Exercise 5
; initial: person -> string
; gets the initials of the perosn
; (define (inital p) ...)

(check-expect (initial (make-person "allah" 0)) "a")
(check-expect (initial (make-person "barb" 0)) "b")

; (define (initial p) ...p...)
(define (initial p)
  (substring (person-name p) 0 1))

;Exercise 6
