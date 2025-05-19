.PHONY: deps utop test promote

utop:
	dune exec -- utop -require core

test:
	dune test

promote:
	dune test --auto-promote
