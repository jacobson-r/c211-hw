;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ps9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; convert : Number Number Number Number Number -> Number
; if a1 becomes b1 and a2 becomes b2, then what should a become? b

; *Assumption*: a1 and a2 are different
(check-expect (convert 0 32 100 212   0)  32)
(check-expect (convert 0 32 100 212 100) 212)
(check-expect (convert 0 32 100 212  50) 122)
(define (convert a1 b1 a2 b2 a)
  (/ (+ (* b1 (- a2 a)) (* b2 (- a a1))) (- a2 a1)))

;Exersice 1
; celsius->fahrenheit : number-> number
; returns a temp in fahrenheit

(define (celsius->fahrenheit in)
  (convert 0 32 100 212 in))

(check-expect (celsius->fahrenheit 0)  32)
(check-expect (celsius->fahrenheit 100) 212)
(check-expect (celsius->fahrenheit 50) 122)

;Exersice 2
; number-between-20-and-180 : number -> number
; returns a number based on the percent of the difference of 20 and 180
(define (number-between-20-and-180 in)
  (convert 0 20 100 180 in))

(check-expect (number-between-20-and-180 0) 20)
(check-expect (number-between-20-and-180 100) 180)
(check-expect (number-between-20-and-180 50) 100)

;Exersice 3
; fahrenheit->celsius : number-> number
; returns a temp in celsius
(define (fahrenheit->celsius in)
  (convert 32 0 212 100 in))

(check-expect (fahrenheit->celsius 32)  0)
(check-expect (fahrenheit->celsius 212) 100)
(check-expect (fahrenheit->celsius 122) 50)

;Exersice 4
(define (posn-helper in)
  (make-posn in (+ (sin in) 200)))
(define width 400)
(define height 400)
(define my-points (build-list 500  posn-helper))
; anything

;Exersice 5
; visible : ListOfPosn -> ListOfPosn
; returns a ListOfPosn where the posn is between 0 and width/height
(define (visible a)
  (cond [(empty? a) empty]
        [(and (> (posn-y (first a)) 0) (> (posn-x (first a)) 0) (< (posn-x (first a)) width)
              (< (posn-y (first a)) height)) (cons (first a) (visible (rest a)))]
        [else (visible (rest a))])) 

;Exersice 6
(require 2htdp/image)
(define bg (empty-scene width height))
(define (img-helper p img)
  (place-image (ellipse 2 2 "solid" "red") (posn-x p) (posn-y p) img))
; draw-lop : ListOfPosn -> Image
; plot the points
(define (draw-lop a)
  (foldr img-helper bg a))

(define my-plot (draw-lop my-points))

;Optional exercise W
(define wells-library (make-posn -86.5170 39.1710))
(define sample-gates  (make-posn -86.5270 39.1665))
(define courthouse    (make-posn -86.5340 39.1670))
(define stadium       (make-posn -86.5255 39.1810))
(define college-mall  (make-posn -86.4955 39.1615))
(define bloomington-places
  (list wells-library sample-gates courthouse stadium college-mall))

(define my-plot2 (draw-lop bloomington-places))
; nothing, the points are negative

;Optional exercise X
; bloomington-x->screen : Number -> Number
; turn a longitude in Bloomington into an X on screen
(check-expect (bloomington-x->screen -86.5725) 0)
(check-expect (bloomington-x->screen -86.5225) (/ width 2))
(check-expect (bloomington-x->screen -86.4725) width)
(define (bloomington-x->screen n)
  (convert -86.5725 0 -86.4725 width n))
;Optional exercise Y
; bloomington-y->screen : Number -> Number
; turn a latitude in Bloomington into an Y on screen
(check-expect (bloomington-y->screen 39.1150) height)
(check-expect (bloomington-y->screen 39.1650) (/ height 2))
(check-expect (bloomington-y->screen 39.2150) 0)
(define (bloomington-y->screen n)
  (convert 39.1150 height 39.2150 0 n))

;Optional exercise Z
; bloomington->screen : Posn -> Posn
; turn Bloomington coordinates into screen coordinates
(check-expect (bloomington->screen wells-library)
              (make-posn (* 0.555 width) (* 0.440 height)))
(check-expect (bloomington->screen sample-gates)
              (make-posn (* 0.455 width) (* 0.485 height)))

(define (bloomington->screen p)
  (make-posn (bloomington-x->screen (posn-x p)) (bloomington-y->screen (posn-y p))))

; A World is (make-world Number Number Number Number)
; *Interpretation*:
;   xmin is the Cartesian x coordinate of the left edge of the view
;   xmax is the Cartesian x coordinate of the right edge of the view
;   ymin is the Cartesian y coordinate of the BOTTOM edge of the view
;   ymax is the Cartesian y coordinate of the TOP edge of the view
(define-struct world [xmin xmax ymin ymax])

(define bloomington-view
  (make-world -86.5725 -86.4725 39.1150 39.2150))

;Exersice 7
; cartesian->screen : World ListOfPosn -> ListOfPosn
; converts map cords to pixels

(check-expect (cartesian->screen bloomington-view bloomington-places)
              (list (make-posn (* 0.555 width) (* 0.440 height))
                    (make-posn (* 0.455 width) (* 0.485 height))
                    (make-posn (* 0.385 width) (* 0.480 height))
                    (make-posn (* 0.470 width) (* 0.340 height))
                    (make-posn (* 0.770 width) (* 0.535 height))))

(check-expect (cartesian->screen (make-world -2 2 -1 1)
                                 (list (make-posn 0 0)
                                       (make-posn 2 0)
                                       (make-posn -2 1)))
              (list (make-posn (/ width 2) (/ height 2))
                    (make-posn width (/ height 2))
                    (make-posn 0 0)))

(check-expect (cartesian->screen (make-world -2 6 0 1)
                                 (list (make-posn 0 0)
                                       (make-posn 2 0)
                                       (make-posn -2 1)))
              (list (make-posn (/ width 4) height)
                    (make-posn (/ width 2) height)
                    (make-posn 0 0)))

(define (cartesian->screen w a)
  (map (lambda (f) (make-posn (convert (world-xmin w) 0 (world-xmax w) width (posn-x f))
                              (convert (world-ymin w) height (world-ymax w) 0 (posn-y f)))) a))

;Exersice 8
(define speed 0.2)
; navigate : world ke -> world
(define (navigate w ke)
  (cond [(string=? ke "w") ...]
        [(string=? ke "a") ...]
        [(string=? ke "s") ...]
        [(string=? ke "d") ...]
        [(string=? ke "up")(make-world(world-xmin w) (world-xmax w)
                                      (-(world-ymin w) (* speed (- (world-ymax w) (world-ymin w))))
                                      (-(world-ymax w) (* speed (- (world-ymax w) (world-ymin w)))))]
        [(string=? ke "left")(make-world(-(world-xmin w) (* speed (- (world-xmax w) (world-xmin w))))
                                        (-(world-xmax w) (* speed (- (world-xmax w) (world-xmin w))))
                                        (world-ymin w) (world-ymax w))]
        [(string=? ke "down")(make-world(world-xmin w) (world-xmax w)
                                        (+(world-ymin w)(* speed (- (world-ymax w) (world-ymin w))))
                                        (+(world-ymax w)(* speed (- (world-ymax w) (world-ymin w)))))]
        [(string=? ke "right")(make-world(+(world-xmin w)(* speed (- (world-xmax w) (world-xmin w))))
                                         (+(world-xmax w)(* speed (- (world-xmax w) (world-xmin w))))
                                         (world-ymin w) (world-ymax w))]
        [else w]))

;Exersice 9
(require 2htdp/universe)

;(define (draw-helper w)
;  (foldr img-helper (empty-scene (world-xmax w) (world-ymax w)) my-points))
;(define my-interactive-plot
;  (big-bang (make-world 0 width 0 height)
;    [to-draw draw-helper]
;    [on-key navigate]))

;Exersice 10
; xticks : number number number -> ListOfNumbers
; make a list of evenly spaced numebrs
(define (xticks max min n)
  (build-list n (lambda (f) (convert 0 min (- n 1) max f))))

;Exersice 11


