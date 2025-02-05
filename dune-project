(lang dune 3.17)

(name advent_of_code)

(generate_opam_files true)

(source
 (github cmattinson/advent-of-code))

(authors "Chris Mattinson <cmattinson@outlook.com>")

(maintainers "Chris Mattinson <cmattinson@outlook.com>")

(license MIT)

(package
 (name advent_of_code)
 (synopsis "Advent of Code solutions")
 (depends ocaml core core_unix re ppx_let ppx_compare ppx_jane ppx_expect ppx_deriving))
