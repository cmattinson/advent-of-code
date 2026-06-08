import { describe, expect, test } from "vitest";
import { readLines } from "../src/Common.bs.js";
import { solve, getBitCounts, getRatings } from "../src/Day3.bs.js";

describe("Day 3", () => {
	test("getBitCounts", () => {
		const input = readLines("test/inputs/day3-example.txt");
		expect(getBitCounts(input)).toMatchInlineSnapshot(`
			[
			  {
			    "ones": 7,
			    "zeroes": 5,
			  },
			  {
			    "ones": 5,
			    "zeroes": 7,
			  },
			  {
			    "ones": 8,
			    "zeroes": 4,
			  },
			  {
			    "ones": 7,
			    "zeroes": 5,
			  },
			  {
			    "ones": 5,
			    "zeroes": 7,
			  },
			]
		`);
	});

	test("getRatings", () => {
		const input = readLines("test/inputs/day3-example.txt");
		expect(getRatings(input)).toMatchInlineSnapshot(`
			{
			  "co2": [
			    "01010",
			  ],
			  "oxygen": [
			    "10111",
			  ],
			}
		`);
	});

	test("example", () => {
		const input = readLines("test/inputs/day3-example.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 198,
			  "part2": 230,
			}
		`);
	});

	test("full", () => {
		const input = readLines("test/inputs/day3.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 3009600,
			  "part2": 6940518,
			}
		`);
	});
});
