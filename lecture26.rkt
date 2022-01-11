;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture26) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Place is String
; A Map is [ListOf Highway]
; A Highway is (make-highway Place Place)
(define-struct highway [start end])

;Example 1

;neighbors : Place Map -> list
; produces a list of all the places you can get in one step
(define (neighbors p m)
  (filter (lambda (a) (or (= (highway-start a) p) (= (highway-end a) p))) m))

;Example 2

; A WayTree is one of:
; - (make-done Place)
; - (make-stop Place [ListOf WayTree])
(define-struct done [at])
(define-struct stop [at children])

(define (process-waytree a)
  (cond [(done? a) ...]
        [(stop? a) (... (stop-at a) (process-waytree (stop-children)))]))