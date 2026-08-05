(* this program appeared because I don't want to look for portable bash implementation

  This doesn't work for darwin: tac | sed -n '/ocaml.text/{p; q}; p' | tac
  In darwin 'tac' is 'tail -r' but it doesn't work on Linux
*)
let () =
  let lines = In_channel.input_lines stdin  in
  let cond s = String.equal s {|[@@@ocaml.text "/*"]|} in
  let print_list xs () =
    List.iter print_endline xs
  in
  let rec loop ~fk = function
    | [] -> fk ()
    | h::tl when cond h -> loop tl ~fk:(print_list tl )
    | _ :: tl -> loop ~fk tl
  in

  loop lines ~fk:(print_list lines )
