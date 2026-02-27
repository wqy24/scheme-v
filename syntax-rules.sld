(define-library (scheme-v syntax syntax-rules)
 (import (scheme base) (scheme-v syntax))
 (export svs-syntax-rules ellipsis keywords transform-rules sv-syntax-rules)
 (begin
  (define svs-syntax-rules (sv-syntax 'syntax-rules))
  (define-record-type sv-syntax-rules
   (sv-syntax-rules ellipsis keywords transform-rules)
   sv-syntax-rules?
   [ellipsis ellipsis]
   [keywords keywords]
   [transform-rules transform-rules])))
