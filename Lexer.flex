// JFlex spec: generates Lexer.java and returns Token objects.

%%

%public
%class Lexer
%unicode
%line
%column
%type Token
%function yylex

%{
// Store the SymbolTable
private SymbolTable symtab;

public Lexer(java.io.Reader in, SymbolTable symtab) {
  this(in);
  this.symtab = symtab;
}

private Token make(TokenType type, String lexeme) {
  return new Token(type, lexeme, false, yyline + 1, yycolumn + 1);
}
private Token makeId(String id) {
  boolean isNew = symtab.add(id);
  return new Token(TokenType.IDENTIFIER, id, isNew, yyline + 1, yycolumn + 1);
}
%}

// Macros
ALPHA  = [A-Za-z]
DIGIT  = [0-9]
ID     = {ALPHA}({ALPHA}|{DIGIT})*
INT    = {DIGIT}+

%%  // ========== Rules ==========

// whitespace
[ \t\r\n]+                          { /* skip */ }

// line comments (ignore everything to end of line)
"//"[^\r\n]*                        { /* skip */ }

// block comments (ignore everything between /* and */)
"/\*"([^*]|\*+[^*/])*\*+ "/"        { /* skip */ }

// multi-char operators
"++" | "--" | ">=" | "<=" | "=="    { return make(TokenType.OPERATOR, yytext()); }

// single-char operators
">" | "<" | "+" | "-" | "*" | "/" | "="  { return make(TokenType.OPERATOR, yytext()); }

// brackets / semicolon
"(" | ")"                           { return make(TokenType.BRACKET, yytext()); }
";"                                 { return make(TokenType.SEMICOLON, yytext()); }

// keywords
"if" | "then" | "else" | "endif" |
"while" | "do" | "endwhile" |
"print" | "newline" | "read"        { return make(TokenType.KEYWORD, yytext()); }

// integers
{INT}                               { return make(TokenType.INTEGER, yytext()); }

// identifiers
{ID}                                { return makeId(yytext()); }

// strings with escapes
\"([^\"\\\r\n]|\\[btnfr'\\]|\\\")*\" { return make(TokenType.STRING, yytext()); }

// unterminated string
\"([^\"\\\r\n]|\\.)*$               { return new Token(TokenType.ERROR, "Unterminated string literal", false, yyline+1, yycolumn+1); }

// EOF
<<EOF>>                             { return null; }

// anything else -> error
.                                   { return new Token(TokenType.ERROR, "Illegal token: " + yytext(), false, yyline+1, yycolumn+1); }
