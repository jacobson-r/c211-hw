;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/json)
 
; read-json/web : String -> JSON
; Retrieves the remote file at the given URL and returns JSON data
 
; read-json/file : String -> JSON
; Retrieves the local file with the given name and returns JSON data

;Exersice 3
;It holds the same data however it is delimited my make-object, list and make-member instead of commas

; A JSON is one of:
; - String
; - Number
; - [ListOf JSON]
; - (make-object [ListOf Member])
;(define-struct object [members])
 
; A Member is (make-member String JSON)
;(define-struct member [name value])

;Exersice 4
; (make-member "name" "686")(make-member "bus_type" "bus")
; List of make-object  make-object

;Exersice 5

; parse : Anything -> JSON
; Ignore the input. Retrieve bus data.
(define (parse whatever)
  (read-json/web "http://iub.doublemap.com/map/v2/buses"))

(require 2htdp/image)
(define width 400)
(define height 400)
(define bg (empty-scene width height))
(define (img-helper p img)
  (place-image (ellipse 2 2 "solid" "red") (posn-x p) (posn-y p) img))
; draw-lop : ListOfPosn -> Image
; plot the points
(define (draw-lop a)
  (foldr img-helper bg a))

(define-struct world [xmin xmax ymin ymax])

(define bloomington-view
  (make-world -86.5725 -86.4725 39.1150 39.2150))

(define (convert a1 b1 a2 b2 a)
  (/ (+ (* b1 (- a2 a)) (* b2 (- a a1))) (- a2 a1)))

(define (cartesian->screen w a)
  (map (lambda (f) (make-posn (convert (world-xmin w) 0 (world-xmax w) width (posn-x f))
                              (convert (world-ymin w) height (world-ymax w) 0 (posn-y f)))) a))

(define sample-bus-posns
  (list
   (make-posn -86.52805 39.18395)
   (make-posn -86.52836 39.18398)
   (make-posn -86.50961 39.17321)
   (make-posn -86.52168 39.16847)
   (make-posn -86.51697 39.18409)
   (make-posn -86.52782 39.1801)))

(define (draw w a)
  (draw-lop(cartesian->screen w a)))

;Exersice 7
(draw bloomington-view sample-bus-posns)

;Exersice 8
; name bus_type lastStop lat id lastUpdate fields route heading lon