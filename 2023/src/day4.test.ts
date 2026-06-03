import { solve } from "./day4.ts";
import { expect, test } from "bun:test";
import type { Card } from "./day4.ts";

async function getLines(filepath: string): Promise<Card[]> {
    const file = await Bun.file(filepath).text();

    const process = (text: string) => {
        return text
            .trim()
            .split(" ")
            .filter((char) => /[0-9]/.test(char))
            .map((char) => Number.parseInt(char));
    };

    return file
        .trim()
        .split("\n")
        .map((line) => {
            const [winning, have] = line.split(" | ");
            const [id, rest] = winning.split(": ");

            return {
                id: Number.parseInt(id.split(" ")[1]),
                winning: process(rest),
                have: process(have),
            };
        });
}

test("Day 4 example", async () => {
    const lines = await getLines("inputs/day4-example.txt");
    expect(solve(lines)).toMatchInlineSnapshot(`
      [
        13,
        30,
      ]
    `);
});

test("Day 4", async () => {
    const lines = await getLines("inputs/day4.txt");
    expect(solve(lines)).toMatchInlineSnapshot(`
      [
        26914,
        40683,
      ]
    `);
});
