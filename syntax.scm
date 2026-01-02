(define-library (scheme-v syntax)
 (import (scheme base))
 (export
  sv-syntax
  sv-syntax?)
 (begin
  (define-record-type sv-syntax
   (sv-syntax name transformer)
   sv-syntax?
   (name name))))