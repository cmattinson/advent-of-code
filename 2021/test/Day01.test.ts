import { describe, expect, test } from "vitest";
import { readLines } from "../src/Common.bs.js";
import { solve } from "../src/Day01.bs.js";

describe("Day 1", () => {
	test("example", () => {
		const input = readLines("test/inputs/day01-example.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 7,
			  "part2": 5,
			}
		`);
	});

	test("full", () => {
		const input = readLines("test/inputs/day01.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 1553,
			  "part2": 1597,
			}
		`);
	});
});
