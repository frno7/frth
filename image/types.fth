\ Words to encode and decode standard integers of different sizes.

: lsr rshift ;
: lsl lshift ;

\ Shifting more than 16 bits is undefined for 16-bit Forths, hence two steps.
: 32lsr ( u -- u ) 16 lsr 16 lsr ;
: 32lsl ( u -- u ) 16 lsl 16 lsl ;
: swaplsr ( u u -- u ) >r swap r> lsr swap ;
: swap32lsr ( u -- u ) swap 32lsr swap ;

: u8+  ( a -- a ) 1 + ;
: u16+ ( a -- a ) 2 + ;
: u32+ ( a -- a ) 4 + ;
: u64+ ( a -- a ) 8 + ;

: u8,     ( x -- ) c, ;
: u16lsb, ( x -- ) dup u8, 8 lsr u8, ;
: u16msb, ( x -- ) dup 8 lsr u8, u8, ;
: u32lsb, ( x -- ) dup u16lsb, 16 lsr u16lsb, ;
: u32msb, ( x -- ) dup 16 lsr u16msb, u16msb, ;
: u64lsb, ( x -- ) dup u32lsb, 32lsr u32lsb, ;
: u64msb, ( x -- ) dup 32lsr u32msb, u32msb, ;

: u8!     ( x a -- ) c! ;
: u16lsb! ( x a -- ) 2dup u8! 8 swaplsr u8+ u8! ;
: u16msb! ( x a -- ) 2dup 8 swaplsr u8! u8+ u8! ;
: u32lsb! ( x a -- ) 2dup u16lsb! 16 swaplsr u16+ u16lsb! ;
: u32msb! ( x a -- ) 2dup 16 swaplsr u16msb! u16+ u16msb! ;
: u64lsb! ( x a -- ) 2dup u32lsb! swap32lsr u32+ u32lsb! ;
: u64msb! ( x a -- ) 2dup swap32lsr u32msb! u32+ u32msb! ;

: u8@     ( a -- x ) c@ ;
: u16lsb@ ( a -- x ) dup u8@ swap u8+ u8@ 8 lsl or ;
: u16msb@ ( a -- x ) dup u8@ 8 lsl swap u8+ u8@ or ;
: u32lsb@ ( a -- x ) dup u16lsb@ swap u16+ u16lsb@ 16 lsl or ;
: u32msb@ ( a -- x ) dup u16msb@ 16 lsl swap u16+ u16msb@ or ;
: u64lsb@ ( a -- x ) dup u32lsb@ swap u32+ u32lsb@ 32lsl or ;
: u64msb@ ( a -- x ) dup u32msb@ 32lsl swap u32+ u32msb@ or ;

: asr negate 2** ;
: asl 2** ;

: 32asr ( u -- u ) 16 asr 16 asr ;
: 32asl ( u -- u ) 16 asl 16 asl ;
: swapasr ( u u -- u ) >r swap r> asr swap ;
: swap32asr ( u -- u ) swap 32asr swap ;

: i8+  ( a -- a ) 1 + ;
: i16+ ( a -- a ) 2 + ;
: i32+ ( a -- a ) 4 + ;
: i64+ ( a -- a ) 8 + ;

: i8,     ( x -- ) c, ;
: i16lsb, ( x -- ) dup i8, 8 asr i8, ;
: i16msb, ( x -- ) dup 8 asr i8, i8, ;
: i32lsb, ( x -- ) dup i16lsb, 16 asr i16lsb, ;
: i32msb, ( x -- ) dup 16 asr i16msb, i16msb, ;
: i64lsb, ( x -- ) dup i32lsb, 32asr i32lsb, ;
: i64msb, ( x -- ) dup 32asr i32msb, i32msb, ;

: i8!     ( x a -- ) c! ;
: i16lsb! ( x a -- ) 2dup i8! 8 swapasr i8+ i8! ;
: i16msb! ( x a -- ) 2dup 8 swapasr i8! i8+ i8! ;
: i32lsb! ( x a -- ) 2dup i16lsb! 16 swapasr i16+ i16lsb! ;
: i32msb! ( x a -- ) 2dup 16 swapasr i16msb! i16+ i16msb! ;
: i64lsb! ( x a -- ) 2dup i32lsb! swap32asr i32+ i32lsb! ;
: i64msb! ( x a -- ) 2dup swap32asr i32msb! i32+ i32msb! ;

: i8@     ( a -- x ) c@ ;
: i16lsb@ ( a -- x ) dup i8@ swap i8+ i8@ 8 asl or ;
: i16msb@ ( a -- x ) dup i8@ 8 asl swap i8+ i8@ or ;
: i32lsb@ ( a -- x ) dup i16lsb@ swap i16+ i16lsb@ 16 asl or ;
: i32msb@ ( a -- x ) dup i16msb@ 16 asl swap i16+ i16msb@ or ;
: i64lsb@ ( a -- x ) dup i32lsb@ swap i32+ i32lsb@ 32asl or ;
: i64msb@ ( a -- x ) dup i32msb@ 32asl swap i32+ i32msb@ or ;
