;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; An Invader is Posn
; A Posn is (make-posn Number Number)
; Examples of a Posn:
(define p1 (make-posn 1 2))
(define p2 (make-posn 150 100))
; Template for a function that processes a Posn:
(define (process-posn p)
  (... (posn-x p) (posn-y p) ...))

; A ListOfPosns is one of:
; - empty
; - (cons Posn ListOfPosns)
; Examples of a ListOfPosns:
(define ps0 empty)
(define ps1 (cons p1 empty))
(define ps2 (cons p2 ps1))
; Template for a function that processes a ListOfPosns:
(define (process-listofposns ps)
  (cond [(empty? ps) ...]
        [(cons? ps) (... (process-posn (first ps))
                         (process-listofposns (rest ps)) ...)]))

; draw-invaders : ListOfPosns -> Image
; draws invader markers at the given positions
(define (draw-invaders ps) ...)
(define background (rectangle 200 300 "solid" "black"))
(define invader-sprite (square 10 "solid" "white"))
(check-expect (draw-invaders empty) background)
(check-expect (draw-invaders ps1)
              (place-image invader-sprite 1 2 background))
(check-expect (draw-invaders ps2)
              (place-image invader-sprite 150 100
                           (place-image invader-sprite 1 2 background)))

; move-invaders : ListOfPosns -> ListOfPosns
; increase each Y coordinate by 1
(define (move-invaders ps) ...)
(check-expect (move-invaders empty) empty)
(check-expect (move-invaders ps1)
              (cons (make-posn 1 3) empty))
(check-expect (move-invaders ps2)
              (cons (make-posn 150 101) (cons (make-posn 1 3) empty)))

; A NaturalNumber is one of:
; - 0
; - (+ 1 NaturalNumber)
; Template for a function that processes a NaturalNumber:
(define (process-naturalnumber n)
  (cond [(= n 0) ...]
        [else (... (process-naturalnumber (- n 1)) ...)]))

; random-invaders : NaturalNumber -> ListOfPosns
; generate that many random invaders in a list
;(define (random-invaders n) ...)
(check-random (random-invaders 0) empty)
(check-random (random-invaders 1)
              (cons (make-posn (random 200) (random 150)) empty))
(check-random (random-invaders 2)
              (cons (make-posn (random 200) (random 150))
                    (cons (make-posn (random 200) (random 150)) empty)))
(define (random-invaders n)
  (cond [(= n 0) empty]
        [else (cons (make-posn (random 200) (random 150))
                    (random-invaders (- n 1)))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; A MaybePosn is one of:
; - (make-none)
; - Posn
(define-struct none [])

; Examples of MaybePosn:
(define b1 (make-none))
(define b2 (make-posn 70 50))

; Template for a function that processes a MaybePosn:
(define (process-maybeposn b)
  (cond [(none? b) ...]
        [(posn? b) (... (posn-x b) (posn-y b) ...)]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; A World is (make-world ListOfPosns Number MaybePosn)
(define-struct world [invaders player bullet])
; *Interpretation*: the player is at the given X coordinate and the bottom of the screen

; Examples of World:
(define w1 (make-world ps2 80 b1))
(define w2 (make-world ps1 100 b2))

; Template for a function that processes a World:
(define (process-world w)
  (... (process-listofposns (world-invaders w))
       (world-player w)
       (process-maybeposn (world-bullet w)) ...))

; tick : World -> World
; update the world as time passes
; (define (tick w) ...)
(check-expect (tick w1)
              (make-world (move-invaders ps2) 80 b1))
(check-expect (tick w2)
              (make-world (move-invaders ps1) 100 (make-posn 70 45)))
(define (tick w)
  (make-world (move-invaders (world-invaders w))
              (world-player w)
              (move-bullet (world-bullet w))))

; move-bullet : MaybePosn -> MaybePosn
; update the bullet as time passes
; (define (move-bullet b) ...)
(check-expect (move-bullet b1) b1)
(check-expect (move-bullet b2) (make-posn 70 45))
(define (move-bullet b)
  (cond [(none? b) b]
        [(posn? b) (make-posn (posn-x b) (- (posn-y b) 5))]))

; draw-world : World -> Image
; draw the given world as an image
; (define (draw-world w) ...)
(define player-sprite (triangle 10 "solid" "red"))
(define bullet-sprite (circle 5 "solid" "green"))
(check-expect (draw-world w1)
              (place-image player-sprite
                           80 295
                           (draw-invaders ps2)))
(check-expect (draw-world w2)
              (place-image bullet-sprite
                           70 50
                           (place-image player-sprite
                                        100 295
                                        (draw-invaders ps1))))
(define (draw-world w)
  (draw-bullet (world-bullet w)
               (place-image player-sprite
                            (world-player w)
                            295
                            (draw-invaders (world-invaders w)))))

; draw-bullet : MaybePosn Image -> Image
; draw the bullet on the given image
(define (draw-bullet b img) ...)
(check-expect (draw-bullet b1
                           (place-image player-sprite
                                        80 295
                                        (draw-invaders ps2)))
              (place-image player-sprite
                           80 295
                           (draw-invaders ps2)))
(check-expect (draw-bullet b2
                           (place-image player-sprite
                                        100 295
                                        (draw-invaders ps1)))
              (place-image bullet-sprite
                           70 50
                           (place-image player-sprite
                                        100 295
                                        (draw-invaders ps1))))

(require 2htdp/universe)

(big-bang w2
  [to-draw draw-world]
  [on-tick tick])

; What's missing??

; player : World KeyEvent -> World
; move player left/right, shoot bullet

; tick : World -> World
; remove invaders/bullet

; the-end : World -> Boolean
; did invaders land? are invaders gone?


; Exercise 1
; A MaybePosn is one of:
; - (make-none)
; - Posn
; (define-struct none [])

(define (MaybePosn p)
  (cond [(none? p) ...]
        [(posn? p) (...(pson-x p) (pson-y))]))

; A World is (make-world ListOfPosns Number MaybePosn)
; (define-struct world [invaders player bullet])
; *Interpretation*: the player is at the given X coordinate and the bottom of the screen

(define (process-world w)
  (... (process-listofposns (world-invaders w))
       (world-player w)
       (process-maybeposn (world-bullet w)) ...))

;Exercise 2

(define b1 (make-none))
(define b2 (make-posn 70 50))
(define bullet-sprite (circle 5 "solid" "green"))

; draw-bullet : MaybePosn Image -> Image
; draw the bullet on the given image
(check-expect (draw-bullet b1
                           (place-image player-sprite
                                        80 295
                                        (draw-invaders ps2)))
              (place-image player-sprite
                           80 295
                           (draw-invaders ps2)))
(check-expect (draw-bullet b2
                           (place-image player-sprite
                                        100 295
                                        (draw-invaders ps1)))
              (place-image bullet-sprite
                           70 50
                           (place-image player-sprite
                                        100 295
                                        (draw-invaders ps1))))
(define (draw-bullet b img)
  (cond [(none? b) img]
        [(posn? b) (place-image bullet-sprite (posn-x b) (posn-y b) img)]))