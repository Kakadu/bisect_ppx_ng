(lang dune 3.18)

(cram enable)

(name bisect_ppx)

(version 3.0.0)

(generate_opam_files true)

(authors
 "Xavier Clerc <bisect@x9c.fr>"
 "Leonid Rozenberg <leonidr@gmail.com>"
 "Anton Bachin <antonbachin@yahoo.com>")

(maintainers "Dmitrii Kosarev a.k.a. Kakadu <kakadu.hafanana@gmail.com")

(homepage "https://github.com/Kakadu/bisect_ppx_ng")

(documentation "https://github.com/Kakadu/bisect_ppx_ng")

(bug_reports "https://github.com/Kakadu/bisect_ppx_ng")

(maintenance_intent "2.8.3" "(latest)")

(license MIT)

(package
 (name bisect_ppx)
 (synopsis "Code coverage for OCaml")
 (depends
  (ocaml
   (or
    (and
     (>= 4.14.2)
     (< 5.0.0))
    (and
     (>= 5.3.0))))
  (ppxlib
   (>= "0.36.0"))
  (cmdliner
   (>= "1.3.0"))
  (js_of_ocaml :with-test)
  (js_of_ocaml-compiler :with-test)
  (reason :with-test))
 ;
 )
