;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 1
; A Wagon is one of:
;  - (make-passenger-wagon Company)
;  - (make-freight-wagon String Number)
 
; A Company is one of:
;  - "Alstom"
;  - "Bombardier"
 
(define-struct passenger-wagon (model))
(define-struct freight-wagon (destination axles))

(define wagon1 (make-passenger-wagon "Alstom"))
(define wagon2 (make-passenger-wagon "Bombardier"))
(define wagon3 (make-freight-wagon "texas" 6))

;Exercise 2
; passenger-wagon?
; passenger-wagon-model
; make-passenger-wagon

; freight-wagon?
; freight-wagon-destination
; freight-wagon-axles
; make-freight-wagon

;Exercise 3
(define (process-wagon w)
  (cond [(passenger-wagon? w)
         (process-company(passenger-wagon-model w))]
        [(freight-wagon? w)
         (freight-wagon-axles w)]))
 
(define (process-company c)
  (cond [(string=? c "Alstom")
         "Alstom"]
        [(string=? c "Bombardier")
         "Bombardier"]))

;Exercise 4
; (make-passenger-wagon Company)
; yes

;Exercise 5
; wagon-weight: wagon -> number
; take a wagon and returns how much it weighs
(define (wagon-weight w)
  (cond [(passenger-wagon? w) (cond
                                [(string=? "Bombardier" (process-wagon w)) 60]
                                [(string=? "Alstom" (process-wagon w)) 45])]
        [(freight-wagon? w) (* 6(freight-wagon-axles w))]))

(check-expect (wagon-weight wagon1) 45)
(check-expect (wagon-weight wagon2) 60)
(check-expect (wagon-weight wagon3) 36)

;Exercise 6
; A Shuttle is one of:
; - (engine)
; - (engine Wagon)
; - (engine Wagon Wagon)

; An engine is one of:
; - "a"
; - "b"

(define-struct engine (model))
(define-struct shuttle1 (engine))
(define-struct shuttle2 (engine Wagon1))
(define-struct shuttle3 (engine Wagon1 Wagon2))

;Exercise 7
(define shuttle01 (make-shuttle1 (make-engine "a" )))
(define shuttle02 (make-shuttle2 (make-engine "a" ) (make-passenger-wagon "Bombardier")))
(define shuttle03 (make-shuttle3 (make-engine "b" ) (make-passenger-wagon "Alstom")
                               (make-freight-wagon "nyc" 110)))

;Exercise 8
; engine?
; engine-model
; make-engine

; shuttle01?
; make-shuttle01
; shuttle01-engine

; shuttle02?
; make-shuttle02
; shuttle02-engine
; shuttle02-wagon1

; shuttle03?
; make-shuttle03
; shuttle03-engine
; shuttle03-wagon1
; shuttle03-wagon2