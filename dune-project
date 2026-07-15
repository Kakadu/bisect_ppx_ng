(lang dune 3.18)

(cram enable)

(name bisect_ppx)

(generate_opam_files true)

(authors
 "Xavier Clerc <bisect@x9c.fr>"
 "Leonid Rozenberg <leonidr@gmail.com>"
 "Anton Bachin <antonbachin@yahoo.com>")

(maintainers "Dmitrii Kosarev <kakadu.hafanana@gmail.com")

(homepage "https://github.com/Kakadu/bisect_ppx_ng")

(documentation "https://github.com/Kakadu/bisect_ppx_ng")

(bug_reports "https://github.com/Kakadu/bisect_ppx_ng")

;(dev-repo "git+https://github.com/Kakadu/bisect_ppx_ng.git")

(license MIT)

(maintenance_intent "(latest)")

(package
 (name bisect_ppx)
 (synopsis "Code coverage for OCaml")
 (depends
  (ppxlib
   (>= "0.36.0"))
  (cmdliner
   (>= "1.3.0"))
  (js_of_ocaml :with-test)
  (js_of_ocaml-compiler :with-test)
  (reason :with-test))
 ;
 )
