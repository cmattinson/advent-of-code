import { describe, expect, test } from "vitest";
import { readInput } from "../src/Common.bs.js";
import { solve } from "../src/Day4.bs.js";

describe("Day 4", () => {
	test("example", () => {
		const input = readInput("test/inputs/day4-example.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 4512,
			  "part2": 1924,
			}
		`);
	});

	test("full", () => {
		const input = readInput("test/inputs/day4.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 6592,
			  "part2": 31755,
			}
		`);
	});
});
