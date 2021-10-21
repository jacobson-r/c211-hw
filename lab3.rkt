;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


;Exercise 1
; A Boolean is one of:
; - true
; - false
; Examples:
;   true
;   false
; Non-examples:
;   "true"
;   0
 
; fever : Number -> Boolean
; returns whether a given Fahrenheit thermometer reading indicates a fever
; (greater than 100 degrees)
; (define (fever t) ...)
(check-expect (fever 98) false)
(check-expect (fever 100) false)
(check-expect (fever 100.1) true)
(check-expect (fever 105) true)

; (define (fever t) ...t...)

(define (fever t)
  (cond [(<= t 100) false]
        [(> t 100) true]))

;Exercise 2

; name is a string

; instructor? : string -> boolean
; checks the name of an instructor
; (define (instructor? name) ...)

(check-expect (instructor? "sita") true)
(check-expect (instructor? "ravana") false)

; (define (instructor? name) ...name...)

(define (instructor? name)
  (string=? name "sita"))


;Exercise 3

; wobble, cloud

;Exercise 4

; A Department is one of:
; - "biology"
; - "business"
; - "computer science"
; - "English"

; nothing, an error message

;Exercise 5

; A card is one of:
; - "Clubs"
; - "Diamonds"
; - "Hearts"
; - "Spades"


;Exercise 6

; A color is one of:
; - "hot pink"
; - "red"
; - "orange"
; - "yellow"
; - "green"
; - "turquoise"
; - "indigo"
; - "violet"


;Exercise 7:

; A shape is one of:
; - "triangle"
; - "rectangle"
; - "pentagon"
; - "hexagon"


;Exercise 8:

(define suit1 "diamonds")
(define suit2 "clubs")


;Exercise 9:

(define color1 "red")
(define color2 "orange")


;Exercise 10

(define shape1 "triangle")
(define shape2 "hexagon")


;Exercise 11:

(define dans-department "geology") ; Not an example of a Department
; nothing


;Exercise 12:

(define color3 "black") ; Not an example of a color


;Exercise 13:

(define shape3 "line") ; Not an example of a shape


;Exercise 14:

; It is a header because it is ... not ...d...


;Exercise 15:

; 4, 4, they are the same, the function is processing the enumeration.


;Exercise 16:

;(define (process-card d)
;  (cond [(string=? d "clubs")...]
;        [(string=? d "diamonds")...]
;        [(string=? d "hearts")...]
;        [(string=? d "spades")...]))


;Exercise 17:

;(define (process-color d)
;  (cond [(string=? d "red")...]
;        [(string=? d "blue")...]
;        [(string=? d "green") ...]
;        [(string=? d "hot pink")...]))


;Exercise 18:

;(define (process-shape d)
;  (cond [(string=? d "triangle")...]
;        [(string=? d "rectangle")...]
;        [(string=? d "pentagon")...]
;        [(string=? d "hexagon")...]))


;Exercise 19:

; 4, 4, they are the same, they are checking each test


;Exercise 20:

; suit-points : suit -> number
; returns the points for each suit
 
(check-expect (suit-points "clubs") 1)
(check-expect (suit-points "diamonds") 2)
(check-expect (suit-points "hearts") 3)
(check-expect (suit-points "spades") 4)
 
(define (suit-points in)
  (cond [(string=? in "clubs") 1]
        [(string=? in "diamonds") 2]
        [(string=? in "hearts") 3]
        [(string=? in "spades") 4]))


;Exercise 21:

; next-color : color -> color
; returns the next color

(check-expect (next-color "hot pink") "red")
(check-expect (next-color "red") "orange")
(check-expect (next-color "orange") "yellow")
(check-expect (next-color "yellow") "green")
(check-expect (next-color "green") "turquoise")
(check-expect (next-color "turquoise") "indigo")
(check-expect (next-color "indigo") "violet")
(check-expect (next-color "violet") "hot pink")

(define (next-color color)
  (cond [(string=? color "hot pink") "red"]
        [(string=? color "red") "orange"]
        [(string=? color "orange") "yellow"]
        [(string=? color "yellow") "green"]
        [(string=? color "green") "turquoise"]
        [(string=? color "turquoise") "indigo"]
        [(string=? color "indigo") "violet"]
        [(string=? color "violet") "hot pink"]))


;Exercise 22:

; sides : shape -> number
; returns the number of sides on a shape

(check-expect (sides "triangle") 3)
(check-expect (sides "rectangle") 4)
(check-expect (sides "pentagon") 5)
(check-expect (sides "hexagon") 6)

(define (sides shape)
  (cond [(string=? shape "triangle") 3]
        [(string=? shape "rectangle") 4]
        [(string=? shape "pentagon") 5]
        [(string=? shape "hexagon") 6]))


 
(define epigraph1 "A long time ago in a galaxy far,")
(define epigraph2 "far away....")
(define story-text
  (above (text "It is a period of civil war." 40 "yellow")
         (text "Rebel spaceships, striking"   40 "yellow")
         (text "lorem ipsum dolor sit"        40 "yellow")))


;Exercise 23:

(define background (rectangle 956 400 "solid" "black"))


;Exercise 24:

(define epigraph-text (above (text epigraph1 40 "blue") (text epigraph2 40 "blue")))
(define shot1 (place-image epigraph-text 478 200 background))

;Exercise 25:

; shot3 : number -> image
; place text over background
;(define (shot3 number) ...)

; see image output for tests

; (define (shot3 number) ...number...)

(define (shot3 number)
  (place-image
   (above (text "STAR" number "yellow") (text "WARS" number "yellow")) 478 200 background))