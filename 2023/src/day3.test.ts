import { solve } from "./day3.ts";
import { expect, test } from "bun:test";
import { part1 } from "./day3.ts";
import { isSymbol } from "./day3.ts";

async function getGrid(filepath: string): Promise<string[][]> {
    const file = await Bun.file(filepath).text();
    return file
        .trim()
        .split("\n")
        .map((line) => line.split(""));
}

test("day3 - part1", async () => {
    const grid = await getGrid("inputs/day3-example.txt");
    expect(part1(grid)).toMatchInlineSnapshot("4361");
});

test("day3 - solve", async () => {
    const text = await Bun.file("inputs/day3.txt").text();
    const grid = text
        .trim()
        .split("\n")
        .map((line) => line.split(""));
    expect(solve(grid)).toMatchInlineSnapshot(`
      [
        539637,
        0,
      ]
    `);
});

test("isSymbol", () => {
    expect(isSymbol("1")).toBe(false);
    expect(isSymbol("a")).toBe(false);
    expect(isSymbol("*")).toBe(true);
    expect(isSymbol("!")).toBe(true);
    expect(isSymbol(".")).toBe(false);
});
