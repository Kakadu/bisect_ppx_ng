Bad attributes generate an error message.

  $ echo "(lang dune 2.7)" > dune-project
  $ cat > dune <<'EOF'
  > (executable
  >  (name test)
  >  (modes byte)
  >  (instrumentation (backend bisect_ppx)))
  > EOF
  $ cat > test.ml <<'EOF'
  > [@@@coverage invalid]
  > EOF
  $ dune build --instrument-with bisect_ppx --display quiet
  File "test.ml", line 1, characters 0-21:
  1 | [@@@coverage invalid]
      ^^^^^^^^^^^^^^^^^^^^^
  Error: Bad payload in coverage attribute.
  [1]


Warnings 4 (fragile pattern matching due to wildcard) and 11 (unused match case)
in generated case instrumentation are suppressed. Warning 26 (unused variable
from as binding) is suppressed. Warning 28 (wildcard given to constant
constructor) is suppressed. One instance is still displayed for the user's code.

  $ cat > test.ml <<'EOF'
  > type t = A | B | C
  > let _ =
  >   match A with
  >   | A | B -> ()
  >   | C -> ()
  > let _ =
  >   match A with
  >   | A | B | C -> ()
  > let _ =
  >   match A with
  >   | (A as x) | (B as x) -> x
  >   | C -> C
  > let _ =
  >   match A with
  >   | A _ | B | C -> ()
  > EOF
  $ dune build --instrument-with bisect_ppx --display quiet 2>&1 | sed -e 's/ \[[^]]*\]//g'
  File "test.ml", line 15, characters 6-7:
  15 |   | A _ | B | C -> ()
             ^
  Error (warning 28): wildcard pattern given as argument to a constant constructor

