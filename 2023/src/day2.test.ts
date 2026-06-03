import { solve } from "./day2.ts";
import { expect, test } from "bun:test";

test("day2 - solve", async () => {
    const text = await Bun.file("inputs/day2.txt").text();
    const lines = text.trim().split("\n");
    expect(solve(lines)).toMatchInlineSnapshot(`
      [
        2369,
        66363,
      ]
    `);
});
