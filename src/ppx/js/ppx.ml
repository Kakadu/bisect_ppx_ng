let _ = Bisect_ppx_ng.Register.conditional := true

let () = Ppxlib.Driver.run_as_ppx_rewriter ()
