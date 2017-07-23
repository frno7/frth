2variable (abort") \ FIXME 2value

: abort" ( i * x x1 -- | i * x ) ( R: j * x -- | j * x )
   postpone if
      postpone s"
      postpone (abort")
      postpone 2!
      -2 literal
      postpone throw
   postpone then ; immediate compile-only
