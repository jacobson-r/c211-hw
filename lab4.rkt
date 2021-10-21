;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;; 1. Data definition
; A Department is one of:
; - "biology"
; - "business"
; - "computer science"
; - "English"
 
;;; 2. Signature, Purpose, Header
; salary : Department -> Number
; returns the salary for each department.
; (define (salary d) ...)
 
;;; 3. Examples
(check-expect (salary "biology")          100000)
(check-expect (salary "business")         110000)
(check-expect (salary "computer science") 120000)
(check-expect (salary "English")          130000)
 
;;; 4. Template
(define (process-department d)
  (cond [(string=? d "biology")          ...]
        [(string=? d "business")         ...]
        [(string=? d "computer science") ...]
        [(string=? d "English")          ...]))
 
;;; 5. Definition
(define (salary d)
  (cond [(string=? d "biology")          100000]
        [(string=? d "business")         110000]
        [(string=? d "computer science") 120000]
        [(string=? d "English")          130000]))
 
;;; 6. Testing
; All 4 tests passed!





;Exercise 1
; nothing becuase data deinition is the first step in the design recipe
; the coment telling you about the name of the structure
; the data definiton
; the signature

;Exercise 2
; A Vehicle is (make-vehicle String String Number)
(define-struct vehicle (company model year))

; nothing
; an error

;Exercise 3
; A Book is (make-book String String Number)
(define-struct Book (author name pages))

;Exercise 4
; A Pet is (make-pet String String Number)
(define-struct Pet (Name Species Age))

;Exercise 5
; An Instructor is (make-instructor String String Number)
(define-struct Instructor (Name Department Salary))

;Exercise 6 
; An School is (make-school String String String)
(define-struct School (Department1 Department2 Department3))

;Exercise 7
; no. It causes an error. The struct requires 3 args not 2

;Exercise 8
; no. It causes an error. The struct requires a string not a number

;Exercise 9
(define harrypooter (make-Book "jk rawling" "harry pooter" 40))
(define bible (make-Book "god" "bible" 3002))

;Exercise 10
(define pet1 (make-Pet "Jim" "dog" 7))
(define pet2 (make-Pet "sammy" "cat" 3000))

;Exercise 11
(define instructor1 (make-Instructor "dave" "biology" 10000))
(define instructor2 (make-Instructor "bob" "English" 13000))

;Exercise 12
(define school1 (make-School "Biology" "business" "computer science"))
(define school2 (make-School "business" "computer science" "english"))

;Exercise 13
; 1. make-book : String String Number -> book (constructor)
; 2. book-author : book -> String (selector)
; 3. book-name : book -> String (selector)
; 4. book-pages : book -> Number (selector)
; 5. book? : Anything -> Boolean (predicate)

;Exercise 14
; 1. make-pet : String String Number -> pet (constructor)
; 2. pet-name : pet -> String (selector)
; 3. pet-species : pet -> String (selector)
; 4. pet-age : pet -> Number (selector)
; 5. pet? : Anything -> Boolean (predicate)

;Exercise 15
; 1. make-instructor : String String Number -> instructor (constructor)
; 2. instructor-name : instructor -> String (selector)
; 3. instructor-department : instructor -> String (selector)
; 4. instructor-salary : instructor -> Number (selector)
; 5. instructor? : Anything -> Boolean (predicate)

;Exercise 16
; 1. make-school : String String String -> school (constructor)
; 2. school-department1 : school -> String (selector)
; 3. school-department2 : school -> String (selector)
; 4. school-department3 : school -> String (selector)
; 5. school? : Anything -> Boolean (predicate)

;Exercise 17
; yes
; no
; the department needs a cond to disginguish beweeen multiple strings whereas the vehicle does not

;Exercise 18

; process-book : book -> ...
; ...
(define (process-book b)
  (... (book-author b) ...
       (book-name b) ...
       (book-pages b) ...))

;Exercise 19

; process-pet : pet -> ...
; ...
(define (process-pet p)
  (... (pet-name p) ...
       (pet-species p) ...
       (pet-age p) ...))

;Exercise 20

; process-instructor : instructor -> ...
; ...
(define (process-instructor i)
  (... (instructor-name i) ...
       (instructor-department (process-department i) ...
       (instructor-salary i) ...)))

;Exercise 21
; (instructor-department (process-department i) ...

;Exercise 22
; process-school : school -> ...
; ...
(define (process-school s)
  (... (school-department1 (process-department i) ...
       (school-department2 (process-department i) ...
       (school-department3 (process-department i) ...)))))

;Exercise 23
; (school-department1 (process-department i) ...

;Exercise 24
;tome? : book -> boolean
; checks if a book has more than 300 pages

(check-expect (tome? bible) true)
(check-expect (tome? harrypooter) false)

(define (tome? b)
  (cond [(<= (Book-pages b) 300) false]
        [else true]))

;Exercise 25
; birthday : pet -> pet
; increments a pets age by 1

(check-expect (birthday pet1) (make-Pet "Jim" "dog" 8))
(check-expect (birthday pet2) (make-Pet "sammy" "cat" 3001))

(define (birthday p)
  (make-Pet (Pet-Name p) (Pet-Species p) (+ (Pet-Age p) 1)))


;Exercise 26
; equalize-salary : instructor->instructor
; returns an instructor with a corrected salary

(define (equalize-salary i)
  (make-Instructor (Instructor-Name i) (Instructor-Department i) (salary (Instructor-Department i))))


;Exercise 27
; average-salary : school -> number
; finds the average salary of the departs in the school

(define (average-salary s)
  (/ (+ (salary (School-Department1 s)) (salary (School-Department2 s)) (salary(School-Department3 s)
                                                                               )) 3))