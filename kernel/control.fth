\ Control stack definitions, using the normal data stack.

: cs-pick ( u -- ) ( C: x1 x2 ... xn -- x1 ... xn xu ) pick ; compile-only

: cs-roll ( u -- ) ( C: x1 x2 ... xn -- x2 ... xn x1 ) roll ; compile-only
