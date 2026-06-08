import { describe, expect, test } from "vitest";
import { readLines } from "../src/Common.bs.js";
import { solve } from "../src/Day2.bs.js";

describe("Day 2", () => {
	test("example", () => {
		const input = readLines("test/inputs/day2-example.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 150,
			  "part2": 900,
			}
		`);
	});

	test("full", () => {
		const input = readLines("test/inputs/day2.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 1989265,
			  "part2": 2089174012,
			}
		`);
	});
});
