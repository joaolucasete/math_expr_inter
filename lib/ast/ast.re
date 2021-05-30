[@deriving show]
type op =
  | Plus
  | Sub
  | Div
  | Mul;

[@deriving show({with_path: false})]
type ast =
  | Binary(ast, op, ast)
  | Number(float)
  | NegativeNumber(float)
  | Let(string, ast, ast)
  | Id(string);
