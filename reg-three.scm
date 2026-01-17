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
      prog))
    obj))

  (define (three-using->three-replacing obj)
   (define (recur obj symlist)
    (if (and (pair? obj) (symbol=? (car obj) 'let-using))
     (begin
      (if (apply or (map (lambda (x) (not (memq x symlist))) (cadr obj)))
       (error "Internal Transferring Exception" "Using symbol that doesn't exist in three-using->three-replacing"))
      (let* [[replacables (filter (lambda (x) (not (memq x (cadr obj)))) symlist)]
             [replaced (if (null? replacables) #f (car replacables))]
             [new-symlist (cons (cadr obj) (remove (lambda (x) (and replaced (symbol=? x replaced))) symlist))]]
       (list
        'let-replacing
        replaced
        (caddr obj) 
        (recur (cadddr obj) new-symlist)
        (recur (car (cddddr obj) new-symlist)))))
     obj))
   (recur obj '()))))
