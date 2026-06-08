import { describe, expect, test } from "vitest";
import { readLines } from "../src/Common.bs.js";
import { solve } from "../src/Day5.bs.js";

describe("Day 5", () => {
	test("example", () => {
		const input = readLines("test/inputs/day5-example.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 5,
			  "part2": 12,
			}
		`);
	});

	test("full", () => {
		const input = readLines("test/inputs/day5.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 6283,
			  "part2": 18864,
			}
		`);
	});
});
