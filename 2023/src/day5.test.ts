import { solve } from "./day4.ts";
import { expect, test } from "bun:test";
import type { Card } from "./day4.ts";

async function getLines(filepath: string): Promise<string[][]> {
    const file = await Bun.file(filepath).text();
    return file.split("\n\n").map((str) => str.split("\n").map((s) => s.trim()));
}

test("Day 5 example", async () => {
    const lines = await getLines("inputs/day5-example.txt");
    console.log(lines);
});
