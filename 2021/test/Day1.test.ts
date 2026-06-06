import { readFileSync } from "node:fs";
import { describe, expect, test } from "vitest";
import { solve } from "../src/Day1.bs.js";

describe("Day 1", () => {
	test("example", () => {
		const input = readFileSync("test/inputs/day1-example.txt", "utf-8")
			.trim()
			.split("\n");
		expect(solve(input)).toMatchInlineSnapshot(`
			"Part 1 - 7
			Part 2 - 5"
		`);
	});

	test("full", () => {
		const input = readFileSync("test/inputs/day1.txt", "utf-8")
			.trim()
			.split("\n");
		expect(solve(input)).toMatchInlineSnapshot(`
			"Part 1 - 1553
			Part 2 - 1597"
		`);
	});
});
