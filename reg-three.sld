(define-library (scheme-v reg-three)
 (import (scheme base) (scheme cxr) (srfi 1))
 (export three->reg-three)
 (begin

  (define (get-usings obj)
   (cond
    [(not (pair? obj)) '()]
    [(symbol=? (car obj) 'let-using) (cadr obj)]
    [else (filter symbol? (cdr obj))]))

  (define (three->three-using obj)
   (if (and (pair? obj) (symbol=? (car obj) 'let))
    (let [[prog (cadddr obj)]]
     (if (pair? prog)
      (let [[trf-prog (three->three-using prog)]]
       (if (memq (cadr obj) (get-usings trf-prog))
        (let [[trf-def (three->three-using (caddr obj))]]
         (list
          'let-using
          (append (get-usings trf-prog) (get-usings trf-def))
          (cadr obj) trf-def trf-prog))
        trf-prog))
      (if (eq? prog (cadr obj)) (caddr obj) prog)))
    obj))

  (define (three-using->reg-three obj free-sregs)
   ())

  (define (three->reg-three obj)
   (three-using->reg-three (three->three using obj) '(s2 s3 s4 s5 s6 s7 s8 s9 s10 s11)))))
