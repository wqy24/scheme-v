(define-library (scheme-v reg-three)
 (import (scheme base) (scheme cxr) (scheme list))
 (export three->reg-three)
 (begin
  (define (get-usings obj)
   (if (symbol=? (car obj) 'let-using) (cadr obj) (filter symbol? (cdr obj))))
  (define (three->three-using obj)
   (if (atom? obj) (error "Syntax error" "Recieved atom in three->three-using"))
   (if (symbol=? (car obj) 'let)
    (let [[prog (caddr obj)]]
     (if (pair? prog)
      (let [[trf-prog (three->three-using prog)]]
       (if (symbol=? (car trf-prog) 'let-using)
        (if (memq (cadr obj) (cadr trf-prog))
         (let [[trf-def (three->three-using (cadr obj))]]
          (list 'let-using (append (get-usings trf-prog) (get-usings trf-def))))
         trf-prog) ;# (let-using (symbol ...) name def prog)
        (trf-prog)))
      prog))
    obj))))