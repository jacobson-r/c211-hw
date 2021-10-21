;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Point is (make-point Number Number)
(define-struct point [x y])

(define (process-point p)
  (... (point-x p) ... (point-y p)))

 
; A BunchOfPoints is one of:
; - (make-none)
; - (make-some Point BunchOfPoints)
(define-struct none [])
(define-struct some [first rest])

;Exercise 1
(make-some (make-point 9 9) (make-none))
(make-some (make-point 9 9) (make-some (make-point 9 9) (make-none)))
(make-some (make-point 9 9) (make-some (make-point 9 9) (make-some (make-point 9 9) (make-none))))

;Exercise 2
; No some takes point and BunchOfPoints not point and point
; yes
; no make-none needs parnes
; yes

;Exercise 3
; count-all-points : BunchOfPoints -> Number
; count how many points are in the bunch
;(define (count-all-points bop)
;  (cond [(none? bop) ...]
;        [(some? bop) (... (some-first bop) ... (rest-bop) ...)]))

;Exercise 4
;(define (count-all-points bop)
;  (cond [(none? bop)...]
;        [(some? bop) (... process-point ...)]))