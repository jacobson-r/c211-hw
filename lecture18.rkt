;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lecture18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 1
; build-list
; 2 NaturalNumber [NaturalNumber -> X]
; 2 NaturalNumber [NaturalNumber -> X]

;Exercise 2
; has-e : String -> Boolean
; returns true if the string contains e and vice versa
(define (has-e s)
  (not (string-contains? "e" s)))

(filter has-e '("hello" "nope" "I am" "bomb"))