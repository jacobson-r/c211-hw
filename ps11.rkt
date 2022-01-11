;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ps11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Bracket is one of:
; - Team
; - (make-bracket Bracket Bracket)
(define-struct bracket [left right])
 
; A Team is String

(define bracket1 (make-bracket "Bucknell" "Michigan St"))
(define bracket2 (make-bracket "TCU" (make-bracket "Syracuse"
                                                   "Arizona St")))
(define bracket3 (make-bracket bracket1 bracket2))

(define teams3
  (list "Arizona St" "Michigan St" "TCU" "Bucknell" "Syracuse"))

(define teams1 (list "Michigan St" "Bucknell"))
(define teams2 (list "Arizona St" "TCU" "Syracuse"))

;Exersice 1

(check-expect (odds  teams3) teams1)
(check-expect (odds  empty ) empty )
(check-expect (evens teams3) teams2)
(check-expect (evens empty ) empty )

(check-expect (odds  (list "a" "b" "c" "d")) (list "b" "d"))
(check-expect (evens (list "a" "b" "c" "d")) (list "a" "c"))

; odds : list -> list
; return a list of the odds

(define (evens a)
  (cond [(empty? a) empty]
        [(cons? a) (cons (first a) (odds (rest a)))]))

; evens : list -> list
; return a list of the evens

(define (odds a)
  (cond [(empty? a) empty]
        [(cons? a) (evens (rest a))]))

;Exersice 2
