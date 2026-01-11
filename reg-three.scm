(define-library (scheme-v reg-three)
 (import (scheme base) (scheme cxr) (scheme list) (scheme write))
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
      prog))
    obj))))
