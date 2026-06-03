import { expect, test } from "bun:test";
import { part2, solve } from "./day1.ts";

const getLines = async (filepath: string): Promise<string[]> => {
    const file = await Bun.file(filepath).text();
    return file.trim().split("\n");
};

test("part2", async () => {
    const lines = await getLines("inputs/day1-example2.txt");
    expect(part2(lines)).toMatchInlineSnapshot("281");
});

test("day1 - solve", async () => {
    const lines = await getLines("inputs/day1.txt");
    expect(solve(lines)).toMatchInlineSnapshot(`
      [
        55447,
        54706,
      ]
    `);
});
