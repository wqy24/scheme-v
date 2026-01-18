(define-library (scheme-v ast)
 (import (scheme base) (scheme case-lambda) (srfi 1))
 (export (rename realexp ast->three))
 (begin
  (define counter 0)
  (define (gen-sym)
   (string->symbol (append "wqy24's scheme-v - internal temperony symbol" (number->string (begin (set! counter (+ counter 1)) counter)))))
  (define (ast->three obj)
   (if (pair? obj)
    (let* [[bindings (map (lambda (x) (cons (filter pair? obj) (gen-sym))))]
           [bindings-x bindings]
           [t-obj (map (lambda (x)
                        (if (pair? x)
                         (let [[s (cdar bindings-x)]]
                          (set! bindings-x (cdr bindings-x))
                          s)))
                       obj)]]
     (let loop [[bindings-2 bindings]
                [tt-obj t-obj]]
      (if (null? bindings-2)
       tt-obj
       (loop (cdr bindings-2) (list 'let (cdar bindings-2) (caar bindings-2) tt-obj)r))))
    obj))))
