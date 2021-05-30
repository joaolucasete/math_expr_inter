{
open Parser
exception SyntaxError of string
}

let digit = ['0'-'9']

let int   = digit+          (* Ex: 123, 231, 2, 3, ... *)
let float = int '.' digit*  (* Ex: 1. , 2.3, 4.203, ... *)

let id    = ['a'-'z''A'-'Z''_']+ (* Ex: hola, name, number_, ...*)

rule read_token = 
  parse
  | "("         { LPAREN }
  | ")"         { RPAREN }
  | "="         { EQUAL  }
  | "/"         { DIV   }
  | "*"         { MUL   }
  | "+"         { PLUS  }
  | "-"         { SUB   }
  | "let"       { LET   }
  | "in"        { IN    }
  | id          { ID(Lexing.lexeme lexbuf)  }
  | float | int { FLOAT(float_of_string (Lexing.lexeme lexbuf)) }
  | " "+        { read_token lexbuf  }
  | eof         { EOF   }
  | _           { raise(SyntaxError "Token unknown") }

