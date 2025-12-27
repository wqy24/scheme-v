(define-library (risc-v ast)
 (import (scheme base) (scheme case-lambda))
 (export (ast->three))
 (begin
  (define ast->three
   (case-lambda
    [(fn arg) (if (pair? arg) (let [[t (gensym)]] (list 'let t (apply ast->three arg) (list fn t))) (list fn arg))]
    [(fn arg1 arg2)
     (cond
      [(pair? arg1) (let [[t (gensym)]] (list 'let t (apply ast->three arg1) (ast->three fn t arg2)))]
      [(pair? arg2) (let [[t (gensym)]] (list 'let t (apply ast->three arg2) (list fn arg1 t)))]
      [else (list fn arg1 arg2)])]))))
