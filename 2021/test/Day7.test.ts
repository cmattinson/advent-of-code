import { describe, expect, test } from "vitest";
import { readInput } from "../src/Common.bs.js";
import { solve } from "../src/Day7.bs.js";

describe("Day 7", () => {
	test("example", () => {
		const input = readInput("test/inputs/day7-example.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 37,
			  "part2": 168,
			}
		`);
	});

	test("full", () => {
		const input = readInput("test/inputs/day7.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 342641,
			  "part2": 93006301,
			}
		`);
	});
});
