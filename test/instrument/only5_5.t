
Missing record labels warning (9) is suppressed from inserted documentation. It
is still emitted for the user's code.

  $ cat > test.ml <<'EOF'
  > type t = {a : int; b : int}
  > let _ =
  >   match {a = 0; b = 1} with
  >   | {a} | {a} -> a
  > EOF
  $ dune build --instrument-with bisect_ppx --display quiet 2>&1 | sed -e 's/ \[[^]]*\]//g'
  File "test.ml", line 4, characters 4-7:
  4 |   | {a} | {a} -> a
          ^^^
  Error (warning 9): the following labels are not bound
    in this record pattern: b.
    Either bind these labels explicitly or add ; _ to the pattern.

  File "test.ml", line 4, characters 10-13:
  4 |   | {a} | {a} -> a
                ^^^
  Error (warning 9): the following labels are not bound
    in this record pattern: b.
    Either bind these labels explicitly or add ; _ to the pattern.

  File "test.ml", line 4, characters 10-13:
  4 |   | {a} | {a} -> a
                ^^^
  Error (warning 12): this sub-pattern is unused.


$ bash test.sh <<'EOF'
  > let _ = let module Foo = struct end in 0
  > let _ =
  >   let module Foo = struct let () = print_endline "foo" end in
  >   print_endline "bar"
  > let _ = fun () ->
  >   let module Foo = struct let () = print_endline "foo" end in
  >   print_endline "bar"
  > EOF
  let _ = let module Foo = struct  end in 0
  let _ =
  let
  module Foo =
  struct let () = ___bisect_post_visit___ 0 (print_endline "foo") end in
  ___bisect_post_visit___ 1 (print_endline "bar")
  let _ =
  fun () ->
  ___bisect_visit___ 3;
  (let
  module Foo =
  struct let () = ___bisect_post_visit___ 2 (print_endline "foo") end
  in print_endline "bar")

