(define-library (scheme-v ast)
 (import (scheme base) (scheme case-lambda))
 (export (rename realexp ast->three))
 (begin
  (define counter 0)
  (define (gen-sym)
   (string->symbol (number->string (begin (set! counter (+ counter 1)) counter))))
  (define ast->three
   (case-lambda
    [(fn arg) (if (pair? arg) (let [[t (gen-sym)]] (list 'let t (apply ast->three arg) (list fn t))) (list fn arg))]
    [(fn arg1 arg2)
     (cond
      [(pair? arg1) (let [[t (gen-sym)]] (list 'let t (apply ast->three arg1) (ast->three fn t arg2)))]
      [(pair? arg2) (let [[t (gen-sym)]] (list 'let t (apply ast->three arg2) (list fn arg1 t)))]
      [else (list fn arg1 arg2)])]
    [(fn arg1 arg2 arg3) (if (symbol=? fn 'let) (list fn arg1 (realexp arg2) (realexp arg3)) (error "Output syntax error" "The only 3-arg form is `let'"))]))
  (define (realexp obj) (if (pair? obj) (apply ast->three obj) obj))))
