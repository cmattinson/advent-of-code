.PHONY: deps utop test promote

deps:
	opam install . --deps-only -y -j 8

utop:
	utop -require core

test:
	dune test

promote:
	dune test --auto-promote
