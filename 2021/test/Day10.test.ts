import { describe, expect, test } from "vitest";
import { readLines } from "../src/Common.bs.js";
import { solve, scoreStack } from "../src/Day10.bs.js";

describe("Day 10", () => {
	test("example", () => {
		const input = readLines("test/inputs/day10-example.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 26397,
			  "part2": 288957n,
			}
		`);
	});

	test("scoreStack", () => {
		expect(scoreStack("}}]])})]".split(""))).toBe(288957n);
		expect(scoreStack(")}>]})".split(""))).toBe(5566n);
		expect(scoreStack("}}>}>))))".split(""))).toBe(1480781n);
		expect(scoreStack("]]}}]}]}>".split(""))).toBe(995444n);
		expect(scoreStack("])}>".split(""))).toBe(294n);
	});

	test("full", () => {
		const input = readLines("test/inputs/day10.txt");
		expect(solve(input)).toMatchInlineSnapshot(`
			{
			  "part1": 392139,
			  "part2": 4001832844n,
			}
		`);
	});
});
