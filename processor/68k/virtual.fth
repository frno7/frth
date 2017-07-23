: t:, ( x -- ) i32msb, ;
: t:@ ( x a-addr -- ) i32msb@ ;
: t:! ( x a-addr -- ) i32msb! ;
: t:u16, ( u -- u ) u16msb, ;
: t:u32, ( u -- u ) u32msb, ;
: t:u64, ( u -- u ) u64msb, ;
: t:cell+ ( x a-addr -- ) 4+ ;
