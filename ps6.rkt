;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ps6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Show is one of:
; - (make-movie String Number Number)
; - (make-sitcom String Number Number)
(define-struct movie (title year minutes))
(define-struct sitcom (series season episode))

(define show1 (make-movie "One Cut of the Dead" 2017 97))
(define show2 (make-sitcom "Rick and Morty" 2 6))
(define show3 (make-movie "Welt am Draht" 1973 205))
(define show4 (make-sitcom "Futurama" 4 15))

;Exercise 1
(define (process-show s)
  (cond [(movie? s) (...(movie-title s) (movie-year s)(movie-minutes s)) ]
        [(sitcom? s) (...(sitcom-series s) (sitcom-season s) (sitcom-episode))]))

;Exercise 2
; show-minutes : Show -> number
(define (show-minutes s)
  (cond [(movie? s) (movie-minutes s)]
        [(sitcom? s) 20]))

(check-expect (show-minutes show1) 97)
(check-expect (show-minutes show2) 20)
(check-expect (show-minutes show3) 205)
(check-expect (show-minutes show4) 20)

;Exercise 3
; show-name : Show -> string
(define (show-name s)
    (cond [(movie? s) (string-append (movie-title s) " (" (number->string (movie-year s)) ")")]
          [(sitcom? s) (string-append (sitcom-series s) " S" (number->string (sitcom-season s)) "E"
                                      (number->string(sitcom-episode s)))]))

(check-expect (show-name show1) "One Cut of the Dead (2017)")
(check-expect (show-name show2) "Rick and Morty S2E6")
(check-expect (show-name show3) "Welt am Draht (1973)")
(check-expect (show-name show4) "Futurama S4E15")

;Exercise 4
; A Job is one of:
; - (make-entry Number)
; - (make-promotion Number)
(define-struct entry (salary))
(define-struct promotion (old-job raise))

;Exercise 5
(define job1 (make-entry 10))
(define job2 (make-promotion (make-entry 10) 10))
(define job3 (make-promotion (make-promotion (make-entry 10)10)-5))

;Exercise 6
(define (process-job j)
  (cond [(entry? j) (entry-salary j)]
        [(promotion? j) ( ... (process-job j) (promotion-raise))]))

;Exercise 7
; salary : Job -> number
(define (salary j)
  (cond [(entry? j) (entry-salary j)]
        [(promotion? j) (+ (salary (promotion-old-job j)) (promotion-raise j))]))

(check-expect (salary job1) 10)
(check-expect (salary job2) 20)
(check-expect (salary job3) 15)

;Exercise 8
; pay-cut? : Job -> boolean
(define (pay-cut? j)
    (cond [(entry? j) #false]
          [(promotion? j) (cond [(< 0 (promotion-raise j)) #true]
                                [(> 0 (promotion-raise j)) (pay-cut? (promotion-old-job j))])]))

(check-expect (pay-cut? job1) #false)
;(check-expect (pay-cut? job2) #false)
(check-expect (pay-cut? job3) #true)

;Exercise 9
; promote : Job -> Job
(define (promote j r)
  (make-promotion j r))

(check-expect (promote job1 5) (make-promotion (make-entry 10) 5))
(check-expect (promote job2 5) (make-promotion (make-promotion (make-entry 10) 10) 5))
(check-expect (promote job3 5) (make-promotion (make-promotion (make-promotion (make-entry 10) 10) -5)
                                               5))

(require 2htdp/image)
;Exercise 10
; chart : Job -> image
(define (chart j)
  (beside/align "bottom"
                (rectangle 20 (/ 100 (salary j)) "solid" "blue")))


;Exercide 11
; A Mobile is one of:
; - (make-leaf Number)
; - (make-rod Mobile Number Number Mobile)
(define-struct leaf [weight])
(define-struct rod [lm ld rd rm])

(define mobile1 (make-leaf 5))
(define mobile2 (make-rod (make-leaf 5) 5 5 (make-leaf 10)))
(define mobile3 (make-rod (make-rod (make-leaf 5) 5 5 (make-leaf 10)) 5 5 (make-leaf 10)))

;Exercise 12
; weight : mobile -> number
(define (weight m)
  (cond [(rod? m) (+ (weight (rod-lm m)) (weight (rod-rm m)))]
        [(leaf? m) (leaf-weight m)]))

(check-expect (weight mobile1) 5)
(check-expect (weight mobile2) 15)
(check-expect (weight mobile3) 25)

;Exercise 13
; weight-helper : mobile -> number
(define (weight-helper m)
  ...)
; average-weight : Mobile -> number
(define (average-weight m)
  (cond [(rod? m) (+ (weight (rod-lm m)) (weight (rod-rm m)))]
        [(leaf? m) (leaf-weight m)]))

;Exercise 14
; balanced? : Mobile -> Boolean
; determines whether the given mobile is balanced at the top
(define (balanced? m)
  (cond [(leaf? m) true]
        [(rod? m) (= (* (rod-ld m) (weight (rod-lm m)))
                     (* (rod-rd m) (weight (rod-rm m))))]))

; all-balanced? : Mobile -> boolean
(define (all-balanced? m)
    (cond [(rod? m) (balanced? (rod-lm m))]
          [(leaf? m) #true]))