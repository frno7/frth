\ Setup image compilation in a separate compiler vocabulary.

wordlist-name target value target
vocabulary compiler also compiler definitions

include image/types.fth

: c:set-current set-current ;
: c:previous previous ;
: c:definitions definitions ;
: c:search-wordlist search-wordlist ;
: c:found found ;
: c:latest>name latest >name ;

variable state
