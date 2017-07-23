variable state

: [ ( -- ) 0 state ! ; immediate \ Enter interpretation state.
: ] ( -- ) 1 state ! ;           \ Enter compilation state.
