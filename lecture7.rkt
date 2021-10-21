;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define background (rectangle 100 300 "solid" "black"))

(define (draw-tl tl)
  (cond [(string=? tl "red")
         (place-image (circle 40 "solid" "red") 50 50 background)]
        [(string=? tl "yellow")
         (place-image (circle 40 "solid" "yellow") 50 150 background)]
        [(string=? tl "green")
         (place-image (circle 40 "solid" "green") 50 250 background)]))

(define (next-tl in)
  (cond [(string=? in "green") "yellow"]
        [(string=? in "yellow") "red"]
        [(string=? in "red") "green"]))

(check-expect (key-tl "red" "j") "green")
(check-expect (key-tl "yellow" "m") "red")

(define (key-tl tl ke) (next-tl tl))


;Exercise 1

; TrafficLight is a world
;
; reset-to-red: TrafficLight KeyEvent -> World
; set the traffic light to red whenever any key is pressed
; (define (reset-to-red TrafficLight KeyEvent) ...)

(check-expect (reset-to-red "green" "j") "red")
(check-expect (reset-to-red "yellow" "k") "red")

; (define (reset-to-red tl ke) ... tl ke...)

(define (reset-to-red tl ke)
  (cond [(string=? tl "green") "red"]
        [(string=? tl "yellow") "red"]
        [(string=? tl "red") "red"]))

(big-bang "red"
  [to-draw draw-tl]
  [on-key reset-to-red]
  [on-tick next-tl 2])