Summary.

  $ echo "(lang dune 2.7)" > dune-project
  $ cat > dune <<'EOF'
  > (executable
  >  (name test)
  >  (instrumentation (backend bisect_ppx_ng)))
  > EOF
  $ dune exec ./test.exe --instrument-with bisect_ppx_ng
  $ bisect-ppx-report summary --verbose
  Info: found *.coverage files in './'
  Coverage: 2/6 (33.33%)


Per-file coverage.

  $ rm -rf *.coverage
  $ echo "(lang dune 2.7)" > dune-project
  $ cat > dune <<'EOF'
  > (executable
  >  (name test)
  >  (modules test)
  >  (instrumentation (backend bisect_ppx_ng)))
  > 
  > (executable
  >  (name empty)
  >  (modules empty)
  >  (instrumentation (backend bisect_ppx_ng)))
  > EOF
  $ dune exec ./test.exe --instrument-with bisect_ppx_ng
  $ dune exec ./empty.exe --instrument-with bisect_ppx_ng
  $ bisect-ppx-report summary --per-file --verbose
  Info: found *.coverage files in './'
  100.00 %   0/0   empty.ml
   33.33 %   2/6   test.ml
   33.33 %   2/6   Project coverage
