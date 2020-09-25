lexer grammar rel;

tokens {
    GE,
    LE,
    G,
    L,
    NE,
    EQ,
    Other
}

GE: '>=';
LE: '<=';
G: '>';
L: '<';
NE: '<>';
EQ: '=';
Other:  ~[<=>\r\n]+;

WhiteSpace: [\r\n]+ -> skip;
