open Mylexer;

let () = {
  let expression = input_line(stdin);
  let lexerbuf = Lexing.from_string(expression);
  let parsed = Parser.main(Lexer.read_token, lexerbuf);
  switch (parsed) {
  | Some(x) =>
    Inter.Expression.interpret(Hashtbl.create(0), x)
    |> Printf.printf("%.2f\n")
  | None => ()
  };
};
