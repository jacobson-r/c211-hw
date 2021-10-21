;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 1
; A TrainOfWagons is one of:
; - (make-none)
; - (make-some Wagon TrainOfWagons)

; A Wagon is one of:
;  - (make-passenger-wagon Company)
;  - (make-freight-wagon String Number)
 
; A Company is one of:
;  - "Alstom"
;  - "Bombardier"


(define-struct none ())
(define-struct some (Wagon TrainOfWagons))
(define-struct passenger-wagon (model))
(define-struct freight-wagon (destination axles))

;Exercise 2

(define wagon1 (make-passenger-wagon "Alstom"))
(define wagon2 (make-passenger-wagon "Bombardier"))
(define wagon3 (make-freight-wagon "texas" 6))

;Exercise 3

; make-none
; none?

; make-some
; some?
; some-Wagon
; some-TrainOfWagons

; passenger-wagon?
; passenger-wagon-model
; make-passenger-wagon

; freight-wagon?
; freight-wagon-destination
; freight-wagon-axles
; make-freight-wagon

;Exercise 4

(define (process-company c)
  (cond [(string=? c "Alstom")
         "Alstom"]
        [(string=? c "Bombardier")
         "Bombardier"]))

(define (process-wagon w)
  (cond [(passenger-wagon? w)
         (process-company(passenger-wagon-model w))]
        [(freight-wagon? w)
         (freight-wagon-axles w)]))

(define (process-train-of-wagons t)
  (cond [(none? t) ...]
        [(some? t) (... (process-wagon (some-Wagon t)) (process-train-of-wagons t))]))

;Exercise 5
; (process-wagon (some-Wagon t))

;Exercise 6
; (process-train-of-wagons t)

;Exercise 7

(define (length-helper w)
  (cond [(passenger-wagon? w) 1]
        [(freight-wagon? w) 1]))

; train-length : TrainOfWagons -> number
; count the number of wagons in the train

(define (train-length t)
  (cond [(none? t) 0]
        [(some? t)
         (+ (length-helper (some-Wagon t)) (train-length (some-TrainOfWagons t)))]))

(passenger-wagon? wagon1)
(check-expect (train-length (make-some wagon1 (make-some wagon2 (make-some wagon3 (make-none))))) 3)
(check-expect (train-length (make-some wagon1 (make-some wagon2 (make-none)))) 2)
(check-expect (train-length (make-some wagon1 (make-none))) 1)


;Exercise 8

(define (wagon-weight w)
  (cond [(passenger-wagon? w) (cond
                                [(string=? "Bombardier" (process-wagon w)) 60]
                                [(string=? "Alstom" (process-wagon w)) 45])]
        [(freight-wagon? w) (* 6(freight-wagon-axles w))]))

; train-weight : TrainOfWagons -> number
; calculate the weight of the train

(define (train-weight t)
  (cond [(none? t) 0]
        [(some? t)
         (+ (wagon-weight (some-Wagon t)) (train-weight (some-TrainOfWagons t)))]))

(check-expect (train-weight (make-some wagon1 (make-some wagon2 (make-some wagon3 (make-none))))) 141)
(check-expect (train-weight (make-some wagon1 (make-some wagon2 (make-none)))) 105)
(check-expect (train-weight (make-some wagon1 (make-none))) 45)

;Exercise 9
; has-passenger? : TrainOfWagons -> Boolean
; determins if a train has passengers
(define (has-passenger? t)
  (cond [(none? t) #false]
        [(some? t) (cond [(passenger-wagon? (some-Wagon t)) #true]
                         [(freight-wagon?(some-Wagon t)) (has-passenger? (some-TrainOfWagons t))])]))

(check-expect (has-passenger? (make-some wagon1 (make-some wagon2 (make-some wagon3 (make-none)))))#t)
(check-expect (has-passenger? (make-some wagon1 (make-some wagon2 (make-none)))) #t)
(check-expect (has-passenger? (make-some wagon1 (make-none))) #t)
(check-expect (has-passenger? (make-some wagon3 (make-none))) #f)

;Exercise 10
;