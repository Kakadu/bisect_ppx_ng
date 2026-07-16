
Missing record labels warning (9) is suppressed from inserted documentation. It
is still emitted for the user's code.

  $ export NO_DSOURCE=1
  $ bash test.sh <<'EOF'
  > [@@@ocaml.warning "-9-12"]
  > [@@@ocaml.warnerror "-9"]
  > type t = {a : int; b : int}
  > let _ =
  >   match {a = 0; b = 1} with
  >   | {a} | {a} -> a
  > EOF
  [@@@ocaml.warning "-9-12"]
  [@@@ocaml.warnerror "-9"]
  type t = {
  a: int ;
  b: int }
  let _ =
  match { a = 0; b = 1 } with
  | ___bisect_matched_value___ ->
  (match ___bisect_matched_value___ with
  | { a } | { a } ->
  ((((match ___bisect_matched_value___ with
  | { a } -> (___bisect_visit___ 0; ())
  | { a } -> (___bisect_visit___ 1; ())
  | _ -> ()))
  [@ocaml.warning "-4-8-9-11-26-27-28-33"]);
  a))



  $ dune build --instrument-with bisect_ppx  #--display quiet 2>&1 #| sed -e 's/ \[[^]]*\]//g'
  $ dune show pp test.ml --instrument-with bisect_ppx | tac | sed -n '/ocaml.text/{p; q}; p' | tac
  [@@@ocaml.text "/*"]
  [@@@ocaml.warning "-9-12"]
  [@@@ocaml.warnerror "-9"]
  type t = {
    a: int ;
    b: int }
  let _ =
    match { a = 0; b = 1 } with
    | ___bisect_matched_value___ ->
        (match ___bisect_matched_value___ with
         | { a } | { a } ->
             ((((match ___bisect_matched_value___ with
                 | { a } -> (___bisect_visit___ 0; ())
                 | { a } -> (___bisect_visit___ 1; ())
                 | _ -> ()))
              [@ocaml.warning "-4-8-9-11-26-27-28-33"]);
              a))

  $ unset  VERBOSE
$ export VERBOSE=1
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

  $ dune show pp test.ml --instrument-with bisect_ppx | tac | sed -n '/ocaml.text/{p; q}; p' | tac
  [@@@ocaml.text "/*"]
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
