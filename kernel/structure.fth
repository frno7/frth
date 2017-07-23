\ Forth 2012 reference implementation of structures.
\ https://forth-standard.org/standard/rationale
\ https://forth-standard.org/standard/facility/BEGIN-STRUCTURE
\ https://forth-standard.org/standard/facility/PlusFIELD
\ https://forth-standard.org/standard/facility/FIELDColon
\ https://forth-standard.org/standard/facility/CFIELDColon
\ https://forth-standard.org/standard/facility/END-STRUCTURE

\ Begin definition of a new structure. Use in the form BEGIN-STRUCTURE <name>.
\ At run time <name> returns the size of the structure.
: begin-structure  ( -- addr 0 ) ( -- size )
   create
      here 0 0 ,   ( Mark stack, lay dummy. )
   does> @ ;       ( -- rec-len )

\ Create a new field within a structure definition of size n bytes.
: +field  ( n <"name"> -- ) ( Exec: addr -- 'addr )
   create over , +
   does> @ + ;

: field:  ( n1 "name" -- n2 ) ( addr1 -- addr2 )
   aligned 1 cells +field ;

: cfield: ( n1 "name" -- n2 ) ( addr1 -- addr2 )
   1 chars +field ;

\ Terminate definition of a structure.
: end-structure ( addr n -- )
   swap ! ;     ( Set length. )
