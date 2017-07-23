: t:, ( x -- ) i64lsb, ;
: t:@ ( x a-addr -- ) i64lsb@ ;
: t:! ( x a-addr -- ) i64lsb! ;
: t:u16, ( u -- u ) u16lsb, ;
: t:u32, ( u -- u ) u32lsb, ;
: t:u64, ( u -- u ) u64lsb, ;
: t:cell+ ( x a-addr -- ) 8+ ;
