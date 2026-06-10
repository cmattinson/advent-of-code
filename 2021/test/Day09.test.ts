import { describe, expect, test } from "vitest";
import { readLines } from "../src/Common.bs.js";
import { solve } from "../src/Day09.bs.js";

describe("Day 9", () => {
	test("example", () => {
		const input = readLines("test/inputs/day09-example.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 15,
			  "part2": 1134,
			}
		`);
	});

	test("full", () => {
		const input = readLines("test/inputs/day09.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 539,
			  "part2": 736920,
			}
		`);
	});
});
