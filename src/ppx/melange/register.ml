(* This file is part of Bisect_ppx, released under the MIT license. See
   LICENSE.md for details, or visit
   https://github.com/aantron/bisect_ppx/blob/master/LICENSE.md. *)

(* This driver drops the command-line switches (--exclude-files,
   --exclusions, --conditional, --bisect-file, --bisect-silent,
   --bisect-sigterm) of the native driver. The corresponding behaviour can
   still be controlled through the BISECT_* environment variables. *)



let enabled () = `Enabled

let () =
  let impl ctxt ast =
    match enabled () with
    | `Enabled ->
      new Instrument.instrumenter#transform_impl_file ctxt ast
    | `Disabled ->
      ast
  in
  let instrument = Ppxlib.Driver.Instrument.V2.make impl ~position:After in
  Ppxlib.Driver.register_transformation ~instrument "bisect_ppx"
