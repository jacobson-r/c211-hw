;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lecture24) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A CurveTree is one of:
; - (make-segment Posn Posn)
; - (make-connect CurveTree CurveTree)
(define-struct segment [p1 p2])
(define-struct connect [c1 c2])

;Exersice 1
(define (process-curvetree a)
  (cond [(segment? a) (... (segment-p1 a) (segment-p2 a))]
        [(connect? a) (... (connect-c1 a) (connect-c2 a))]))

;Exersice 2
(define (draw-curve-tree a bg)
  (cond [(segment? a) (scene+line bg (segment-p1 a) (segment-p2 a)  "solid")]
        [(connect? a) (... (connect-c1 a) (connect-c2 a))]))