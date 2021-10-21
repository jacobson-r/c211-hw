;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ps5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;Exercise 1

; draw : string->image
; take a string and return a image with that string on it
(define (draw s)
  (overlay (text s 20 "red")(rectangle 150 80 "solid" "black")))


;Exercise 2/3

; makeText: world-> world
; add key press to the world
(define (makeText world ke)
  (cond [(string=? ke " ") (substring world 0 0)]
        [else(string-append world ke)]))

(big-bang ""
  [to-draw draw]
  [on-key makeText]
  )

;Exercise 4
; A Date is (make-date Number String Number)
; Examples:
;   (make-date 2018 "Sept" 12)
;   (make-date 0 "January" 1)
; Non-examples:
;   (make-date 2018 9 12)
;   "September 12, 2018"
(define-struct date (year month day))

; make-date
; date?
; date-year
; date-month
; date-day

;Exercise 5
; A address is (make-address String String String Number)
(define-struct address (street apartment city zip))

;Exercise 6
(define (process-address a)
  (... (address-street a) (address-apartment a) (address-city a) (address-zip a)))

;Exercise 7
; indiana?: address -> boolean
; returns a boolean based on if the zip is in indiana
(define (indiana? z)
  (cond [(< z 47999) (cond [(> z 46000) #true]
                           [else #false])]
        [else #false]))

;Exercise 8
; format-address: Address -> string
; take an Address and produce a string
(define (format-address a)
  (string-append (address-apartment a) (address-street a) (address-city a) (address-zip a)))

;Exercise 9
; smaller-zip : Address Address -> Address
; returen the adress with the smaller zip code
(define (smaller-zip a1 a2)
  (cond [(<= (address-zip a1) (address-zip a2)) a1]
        [else a2]))

;Problem 83
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(overlay/align "left" "center"
               (text "hello world" 11 "black")
               (empty-scene 200 20))

;render : Editor -> image
; take an editor and return an image with a cursor
(define (render e)
  (overlay/align "left" "center"
               (beside (text (editor-pre e) 16 "black")(beside (rectangle 1 20 "solid" "red")
                                                               (text (editor-post e) 16 "black")))
               (empty-scene 200 20)))
