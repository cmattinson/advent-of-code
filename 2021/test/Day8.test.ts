import { describe, expect, test } from "vitest";
import { readLines } from "../src/Common.bs.js";
import { solve } from "../src/Day8.bs.js";

describe.skip("Day 8", () => {
	test("example", () => {
		const input = readLines("test/inputs/day8-example.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 26,
			  "part2": 0,
			}
		`);
	});

	test("full", () => {
		const input = readLines("test/inputs/day8.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 264,
			  "part2": 0,
			}
		`);
	});
});
