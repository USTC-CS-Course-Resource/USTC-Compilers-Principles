# Lab Lexer-3

## Antlr

### Lexer form
```antlr
/** Optional javadoc style comment */
[parser|lexer] grammar Name; // indicate `parser` or `lexer`
options {...}
import ... ;
 	
tokens {...}
channels {...} // lexer only
@actionName {...}
 	 
ruleName1 : alternative1 | ... | alternativeN ; // parser and lexer rules, possibly intermingled
...
ruleNameN : alternative1 | ... | alternativeN ;
```

- only lexer grammars can contain `mode` specifications and `custom channels`
```antlr
channels {
  WHITESPACE_CHANNEL,
  COMMENTS_CHANNEL
}
WS : [ \r\t\n]+ -> channel(WHITESPACE_CHANNEL) ;
```

[Useful lexer rules](https://github.com/antlr/antlr4/blob/master/doc/lexer-rules.md)

#### Tokens Section

```antlr
tokens { Token1, ..., TokenN }
```

#### Actions

##### Named Actions

`header` and `members`

#### Modes

```antlr
rules in default mode
...
mode MODE1;
rules in MODE1
...
mode MODEN;
rules in MODEN
...
```

#### Commands

- skip
- more
- popMode
- mode( x )
- pushMode( x )
- type( x )
- channel( x )
