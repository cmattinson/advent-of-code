deps:
	opam install . --deps-only --yes --jobs 8

utop:
	utop -require core
