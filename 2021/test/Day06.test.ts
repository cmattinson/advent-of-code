import { describe, expect, test } from "vitest";
import { readInput } from "../src/Common.bs.js";
import { init, simulate } from "../src/Day06.bs.js";

describe("Day 6", () => {
	test("simulate - example", () => {
		const input = readInput("test/inputs/day06-example.txt");
		const state = init(input);
		expect(simulate(state, 18)).toMatchInlineSnapshot(`26n`);
		expect(simulate(state, 80)).toMatchInlineSnapshot(`5934n`);
		expect(simulate(state, 256)).toMatchInlineSnapshot(`26984457539n`);
	});

	test("simulate - full", () => {
		const input = readInput("test/inputs/day06.txt");
		const state = init(input);
		expect(simulate(state, 80)).toMatchInlineSnapshot(`366057n`);
		expect(simulate(state, 256)).toMatchInlineSnapshot(`1653559299811n`);
	});
});
