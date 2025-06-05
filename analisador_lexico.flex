package compilador;

import java_cup.runtime.*;

%%

%class Scanner
%unicode
%cup
%line
%column

%{ 
  // Código Java a ser incluído na classe gerada
  private Symbol symbol(int type) {
    return new Symbol(type, yyline + 1, yycolumn + 1);
  }

  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline + 1, yycolumn + 1, value);
  }
%}

/* --- Definições Regulares --- */

/* Espaços em branco */
WHITESPACE = [ \t\r\n]+

/* Comentários */
COMMENT_SL = "//" [^\n\r]*
COMMENT_ML = "/*" ( [^*] | \*+[^*/] )* "*/"

/* Identificadores */
LETTER = [A-Za-z_]
DIGIT = [0-9]
IDENTIFIER = {LETTER} ({LETTER} | {DIGIT})*

/* Números */
INTEGER_CONST = {DIGIT}+
FLOAT_CONST = {DIGIT}+ \. {DIGIT}+

/* String Literals */
STRING_LITERAL = \" ([^\"\\] | \\.)* \"

/* Keywords */
KW_IF = "if"
KW_ELSE = "else"
KW_WHILE = "while"
KW_RETURN = "return"
KW_INT = "int"
KW_FLOAT = "float"
KW_VOID = "void"
KW_PRINT = "print" // Adicionando uma keyword exemplo

/* Operadores */
OP_PLUS = "+"
OP_MINUS = "-"
OP_TIMES = "*"
OP_DIV = "/"
OP_ASSIGN = "="
OP_EQ = "=="
OP_NEQ = "!="
OP_LT = "<"
OP_GT = ">"
OP_LTE = "<="
OP_GTE = ">="

/* Delimitadores */
DELIM_SEMICOLON = ";"
DELIM_COMMA = ","
DELIM_LPAREN = "("
DELIM_RPAREN = ")"
DELIM_LBRACE = "{"
DELIM_RBRACE = "}"

%%

/* --- Regras Léxicas --- */
<YYINITIAL> {
  /* Ignorar espaços e comentários */
  {WHITESPACE}            { /* Ignorar */ }
  {COMMENT_SL}            { /* Ignorar */ }
  {COMMENT_ML}            { /* Ignorar */ }

  /* Keywords */
  {KW_IF}                 { return symbol(sym.IF); }
  {KW_ELSE}               { return symbol(sym.ELSE); }
  {KW_WHILE}              { return symbol(sym.WHILE); }
  {KW_RETURN}             { return symbol(sym.RETURN); }
  {KW_INT}                { return symbol(sym.INT); }
  {KW_FLOAT}              { return symbol(sym.FLOAT); }
  {KW_VOID}               { return symbol(sym.VOID); }
  {KW_PRINT}              { return symbol(sym.PRINT); }

  /* Identificadores */
  {IDENTIFIER}            { return symbol(sym.ID, yytext()); }

  /* Constantes */
  {INTEGER_CONST}         { return symbol(sym.INTEGER_LITERAL, Integer.parseInt(yytext())); }
  {FLOAT_CONST}           { return symbol(sym.FLOAT_LITERAL, Float.parseFloat(yytext())); }
  {STRING_LITERAL}        { return symbol(sym.STRING_LITERAL, yytext().substring(1, yytext().length() - 1)); } // Remove aspas

  /* Operadores */
  {OP_PLUS}               { return symbol(sym.PLUS); }
  {OP_MINUS}              { return symbol(sym.MINUS); }
  {OP_TIMES}              { return symbol(sym.TIMES); }
  {OP_DIV}                { return symbol(sym.DIV); }
  {OP_ASSIGN}             { return symbol(sym.ASSIGN); }
  {OP_EQ}                 { return symbol(sym.EQ); }
  {OP_NEQ}                { return symbol(sym.NEQ); }
  {OP_LT}                 { return symbol(sym.LT); }
  {OP_GT}                 { return symbol(sym.GT); }
  {OP_LTE}                { return symbol(sym.LTE); }
  {OP_GTE}                { return symbol(sym.GTE); }

  /* Delimitadores */
  {DELIM_SEMICOLON}       { return symbol(sym.SEMI); }
  {DELIM_COMMA}           { return symbol(sym.COMMA); }
  {DELIM_LPAREN}          { return symbol(sym.LPAREN); }
  {DELIM_RPAREN}          { return symbol(sym.RPAREN); }
  {DELIM_LBRACE}          { return symbol(sym.LBRACE); }
  {DELIM_RBRACE}          { return symbol(sym.RBRACE); }

  /* Erro Léxico */
  .                       { System.err.println("Erro léxico: Caractere ilegal '" + yytext() + "' na linha " + (yyline + 1) + ", coluna " + (yycolumn + 1)); }
}

