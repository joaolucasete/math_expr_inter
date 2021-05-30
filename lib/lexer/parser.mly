%{
    open Ast
%}

%token <float> FLOAT
%token LPAREN
%token RPAREN
%token DIV
%token MUL
%token PLUS
%token SUB
%token EOF
%token EQUAL
%token <string> ID
%token LET IN
%left PLUS SUB
%left MUL DIV

%start <ast option> main
%% 

%inline bin_op:
| PLUS  { Plus }
| SUB   { Sub  }
| MUL   { Mul  }
| DIV   { Div  }

main:
    | ast EOF { Some $1 }
    | EOF { None }

ast:
    | a=ast op=bin_op b=ast          { Binary(a, op, b)   }
    | LET id=ID EQUAL a=ast IN b=ast { Let(id, a, b)      }
    | ID                             { Id($1)             }
    | LPAREN a=ast RPAREN            { a                  }
    | FLOAT                          { Number($1)         }
    | SUB a=FLOAT                    { NegativeNumber(a)  }
