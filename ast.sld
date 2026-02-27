(define-library (scheme-v ast)
 (import (scheme base) (srfi 1))
 (export ast->three)
 (begin
  (define counter 0)
  (define (gen-sym)
   (string->symbol (string-append "scheme-v's temporany symbol for `let' internal expression" (number->string (begin (set! counter (+ counter 1)) counter)))))
  (define (ast->three obj)
   (if (pair? obj)
    (let* [[bindings (map (lambda (x) (cons x (gen-sym))) (filter pair? obj))]
           [t-obj (let loop [[bindings-x bindings]
                             [t-obj obj]]
                   (if (pair? t-obj)
                    (if (pair? (car t-obj))
                     (cons (cdar bindings-x) (loop (cdr bindings-x) (cdr t-obj)))
                     (cons (car t-obj) (loop bindings-x (cdr t-obj))))
                    t-obj))]]
     (let loop [[bindings-2 bindings]
                [tt-obj t-obj]]
      (if (null? bindings-2)
       tt-obj
       (loop (cdr bindings-2) (list 'let (cdar bindings-2) (ast->three (caar bindings-2)) tt-obj)))))
    obj))))
