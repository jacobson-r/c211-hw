;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lab8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Trip is [ListOf Step]
 
; A Step is one of:
; - (make-draw Number)
; - (make-turn Number)
; *Interpretation*: angle is how many degrees to turn left (counterclockwise)
(define-struct draw [distance])
(define-struct turn [angle])

(define square-trip
  (list (make-draw 50)
        (make-turn 90)
        (make-draw 50)
        (make-turn 90)
        (make-draw 50)
        (make-turn 90)
        (make-draw 50)))
(define z-trip
  (list (make-draw 80)
        (make-turn -135)
        (make-draw 120)
        (make-turn 135)
        (make-draw 80)))

;Exercise 1
(define line-trip
  (list (make-draw 50)
        (make-draw 50)
        (make-draw 50)
        (make-draw 50)
        (make-draw 50)))

(define zig-zag-trip
  (list (make-draw 50)
        (make-turn 90)
        (make-draw 50)
        (make-turn -90)
        (make-draw 50)
        (make-turn 90)
        (make-draw 50)
        (make-turn -90)))

;Exercise 2
(define (process-step a)
  (cond [(draw? a) (...(draw-distance a))]
        [(turn? a) (...(turn-angle a))]))

(define (process-trip a)
  (cond [(empty? a) a]
        [(draw? (first a)) (...(process-step) (process-trip (rest a)))]
        [(turn? (first a)) (...(process-step) (process-trip (rest a)))]))

;Exercise 3
; yes

;Exersice 4
; step-length : Step -> number
; calculates the length of a step
(define (step-length a)
  (cond [(draw? a) (draw-distance a)]
        [(turn? a) 0]))
(check-expect (step-length (make-turn 90)) 0)
(check-expect (step-length (make-draw 50)) 50)
(check-expect (step-length (make-draw 150)) 150)

;Exersice 5
; trip-length : Trip -> number
; calculates the total length of a trip
(define (trip-length a)
  (cond [(equal? '() a) 0]
        [else (+ (step-length (first a)) (trip-length (rest a)))]))

(check-expect(trip-length square-trip)200)
(check-expect(trip-length zig-zag-trip)200)
(check-expect(trip-length z-trip)280)
(check-expect(trip-length line-trip)250)

;Exersice 6

; A Turtle is (make-turtle Number Number Number)
; *Interpretation*: dir=0 faces east,
;                   dir=90 faces north,
;                   dir=180 faces west,
;                   dir=270 faces south
(define-struct turtle [x y dir])

; move : Step Turtle -> Turtle
; moves the turtle
(define (move s t)
  (cond [(draw? s) (make-turtle (+ (turtle-x t) (* 50 (cos(* (turtle-dir t) (/ pi 180)))))
                    (- (turtle-y t) (* 50 (sin(* (turtle-dir t) (/ pi 180))))) (turtle-dir t))]
        [(turn? s) (make-turtle (turtle-x t) (turtle-y t) (+ (turtle-dir t) (turn-angle s)))]))

;Exersice 7
; draw-step : Step Turtle Image -> image
; draw a step
(define backgroud (empty-scene 300 300))
(require 2htdp/image)
(define (draw-step s t i)
  (scene+line i (turtle-x t) (turtle-y t) (turtle-x (move s t)) (turtle-y (move s t)) "black"))

;Exersice 8
; draw-trip : Turtle Trip Image -> image
; take a trip and turn it into a image
(define (draw-trip t a i)
  (cond [(equal? a '()) backgroud]
        [else (draw-step (first a) t (draw-trip (move (first a) t) (rest a) i))]))

;Exersice 9
; repeat : NaturalNumber Trip -> trip
; replicates a trip n times
(define (repeat n a)
  (cond [(equal? n 0) a]
        [else (append a (- n 1))]))


(define hexagon-trip
  (repeat 6 (list (make-draw 50) (make-turn 60))))

(define ring-trip
  (repeat 36 (list (make-draw 100) (make-turn 130))))