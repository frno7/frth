\ Word definition words.

: : ( C: "<spaces>name" -- colon-sys )
   prologue, parse-name ?redefined create-name, 0 c, 0 c, create-link, ] ;

: ; ( -- ) postpone exit latest code#! [ epilogue, ; immediate compile-only
