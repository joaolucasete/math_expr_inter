open Ast;
let rec interpret = ctx =>
  fun
  | Number(num) => num
  | NegativeNumber(num) => num *. (-1.)
  | Let(name, value, expr) => {
      Hashtbl.add(ctx, name, interpret(ctx, value));
      interpret(ctx, expr);
    }
  | Id(name) => {
      Hashtbl.find(ctx, name);
    }
  | Binary(left, op, right) => {
      let left = interpret(ctx, left);
      let right = interpret(ctx, right);
      switch (op) {
      | Plus => left +. right
      | Sub  => left -. right
      | Mul  => left *. right
      | Div  => left /. right
      };
    };
