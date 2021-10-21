;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ps7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)


; An FT (short for family tree) is one of:
; - (make-no-parent)
; - (make-child FT FT String N String)
(define-struct no-parent [])
(define-struct child [father mother name date eyes])

;Exercise 1
; jake from state farm

;Exercise 2
; they have step parents

;Exercise 3
; beacuase they have more than a mother and father

;Exercise 4

; A 1String a String of length 1
 
; rot13 : 1String -> 1String
; returns the letter 13 spaces ahead in the alphabet
(define (rot13 letter)
  (cond
    [(or (and (string<=? "a" letter) (string<=? letter "m"))
         (and (string<=? "A" letter) (string<=? letter "M")))
     (int->string (+ (string->int letter) 13))]
    [(or (and (string<=? "n" letter) (string<=? letter "z"))
         (and (string<=? "N" letter) (string<=? letter "Z")))
     (int->string (- (string->int letter) 13))]
    [else letter]))

(check-expect (rot13 "a") "n")
(check-expect (rot13 "A") "N")
(check-expect (rot13 "z") "m")
(check-expect (rot13 "Z") "M")
(check-expect (rot13 ".") ".")
(check-expect (rot13 " ") " ")

;Exercise 5

; A ListOf1Strings is one of:
; - empty
; - (cons String ListOf1Strings)

(define (process-ListOf1Strings l)
  (cond [(empty? l) ...]
        [(cons? l) (... (first l) (rest l) )]))

;Exercise 6

; combine-1strings : ListOf1Strings -> string

(define (combine-1strings l)
  (cond [(empty? l) ""]
        [(cons? l) (string-append (first l) (combine-1strings (rest l)))]))

(check-expect (combine-1strings (cons "a" '())) "a")
(check-expect (combine-1strings (cons "a" (cons "b" '() ))) "ab")

;Exercise 8

; convert-to-r13 : ListOf1Strings -> ListOf1Strings
(define (convert-to-r13 l)
  (cond [(empty? l) l]
        [(cons? l) (cons (rot13 (first l)) (convert-to-r13 (rest l)))]))

(check-expect (convert-to-r13 (cons "a" '())) (cons "n" '()))
(check-expect (convert-to-r13 (cons "b" '())) (cons "o" '()))
(check-expect (convert-to-r13 (cons "z" '())) (cons "m" '()))


;Exercise 9

; file-to-r13 : string -> ListOf1Strings
(define (file-to-r13 l)
  (convert-to-r13 (read-1strings l)))

;Exercise 10

; decrypt-file : String -> String
(define (decrypt-file a)
  (combine-1strings (file-to-r13 a)))

(check-expect (decrypt-file "secretmsg1.txt") "Meet me at midnight.")
(check-expect (decrypt-file "secretmsg2.txt") "Congrats on decrypting this message! You are awesome.")
(check-expect (decrypt-file "secretmsg3.txt") "Computer science is awesome. Don't you agree?")
(check-expect (decrypt-file "secretmsg4.txt")
              "Once upon a time, a long time ago, there was a computer science student,
all lonely and with no place to go.
But then they discovered C211 and found that it was heaven.
This describes me, but I hope it's the way you'll come to be.")
(check-expect (decrypt-file "secretmsg5.txt") "Congrats on coming so far. We love you.")

;Exercise 11

; encrypt-string : String -> String
(define (encrypt-string s)
  (combine-1strings (convert-to-r13 (explode s))))

(check-expect (encrypt-string "hello") "uryyb")
(check-expect (encrypt-string "five guys") "svir thlf")
(check-expect (encrypt-string "this is a test") "guvf vf n grfg")

;Exercise 12

; encrypt-string-to-file : string string -> string
(define (encrypt-string-to-file a b)
  (write-file a (encrypt-string b)))


;Exercise 13

; remove-<=100 : ListOfNumbers -> ListOfNumbers
(define (remove-<=100 a)
   (cond [(empty? a) a]
         [(cons? a) (cond [(<= (first a) 100) (remove-<=100 (rest a))]
                          [else (cons (first a) (remove-<=100 (rest a)))])]))

(check-expect (remove-<=100 (cons 20 (cons 120 (cons 30 (cons 130 '()))))) (cons 120 (cons 130 '())))
(check-expect (remove-<=100 (cons 200 (cons 100 (cons 0 (cons 190 '()))))) (cons 200 (cons 190 '())))
(check-expect (remove-<=100 (cons 20 (cons 90 '()))) '())

;Exercise 14

;(make-struct frequency string number)
(define-struct frequency (word count))


;Exercise 15

; A ListOfStrings is one of:
; - empty
; - (cons string ListOfStrings)


; A ListOfFrequencies is one of:
; - empty
; - (cons frequency ListOfFrequencies)


;Exercise 16

; count-word : ListOfFrequencies string -> ListOfFrequencies
(define (count-word a s)
  (cond [(empty? a) (cons (make-frequency s 1) a)]
        [(cons? a) (cond [(empty?(first a)) (cons(make-frequency s 1) a)]
                         [(string=? (frequency-word (first a)) s)
                          (cons (make-frequency s (+ 1 (frequency-count (first a)))) (rest a))]
                         [else (cons (first a) (count-word (rest a) s))])]))

(check-expect
 (count-word (cons (make-frequency "hhhh" 1) (cons (make-frequency "hello" 1) '())) "hello")
 (list (make-frequency "hhhh" 1) (make-frequency "hello" 2)))
(check-expect
 (count-word (cons (make-frequency "hhhh" 1) (cons (make-frequency "hello" 1) '())) "hhhh")
 (list (make-frequency "hhhh" 2) (make-frequency "hello" 1)))
(check-expect
 (count-word (cons (make-frequency "hhhh" 1) (cons (make-frequency "hello" 1) '())) "5head")
 (list (make-frequency "hhhh" 1) (make-frequency "hello" 1) (make-frequency "5head" 1)))

(check-expect (count-word (cons empty empty) "hello") (list (make-frequency "hello" 1) '()))

;Exercise 17
; count-all-words : ListOfStrings -> ListOfFrequencies
(define (count-all-words a)
  (cond [(empty? a) a]
        [(cons? a) (count-word (count-all-words (rest a)) (first a))]))


(check-expect (count-all-words (cons "hello" (cons "hello" (cons "5head" '()))))
              (list (make-frequency "5head" 1) (make-frequency "hello" 2)))


;Exercise 18
;(define hamlet-frequencies (count-all-words (read-words "hamlet.txt")))

;Exercise 19
; frequents : ListOfFrequencies -> ListOfFrequencies
(define (frequents a)
  (cond [(empty? a) a]
        [(cons? a) (cons (...))]))

(cons (make-frequency "hhhh" 1) (cons (make-frequency "hello" 1) '()))
