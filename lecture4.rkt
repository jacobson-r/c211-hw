;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lecture4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 1
 
; 1. Data definitions
; Tempature is a number
 
; 2. Signature, purpose, header
; ftoc: Temp -> temp
; converts celsius to kelvin
; (define (ctok c) ...)

; 3. Function examples
; given 0 expect: 273.15
; given 100 expect: 373.15

; 4. Function template
; (define (ctok c) (...c...))

; 5. Function definition
(define (ftoc c) (+ c 273))


; 6. Testing