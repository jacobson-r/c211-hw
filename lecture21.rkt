;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lecture21) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 1
; A Month is one of:
; - "January"
; - "February"
; - "March"
; - "April"
; - "May"
; - "June"
; - "July"
; - "August"
; - "September"
; - "October"
; - "November"
; - "December"
 
; A MonthFormat is one of:
; - "long"
; - "short"
 
; format-month : Month MonthFormat -> String
; abbreviates the given Month to three letters or not
(check-expect (format-month "November" "long") "November")
(check-expect (format-month "November" "short") "Nov")
(define (format-month m f)...
  )

; monthformat : the template is shorter

;Exercise 2

; A Move is one of:
; - "split"
; - "steal"
(define (process-move m)
  (cond [(string=? "split") ...]
        [(string=? "steal") ...]))