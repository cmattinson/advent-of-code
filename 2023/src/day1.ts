const file = Bun.file("inputs/day1.txt");
const text = await file.text();

const numbers = {
	one: "1",
	two: "2",
	three: "3",
	four: "4",
	five: "5",
	six: "6",
	seven: "7",
	eight: "8",
	nine: "9",
};

function getDigits(line: string): number {
	const digits = line
		.split("")
		.filter((character) => Number.parseInt(character));
	return Number.parseInt(`${digits[0]}${digits[digits.length - 1]}`);
}

function part1(input: string[]): number {
	return input
		.map((line) => getDigits(line))
		.reduce((accum, num) => (accum += num), 0);
}

function part2(input: string[]): number {
	return input
		.map((line) => {
			const replaced = line.split("").reduce((accum, char) => {
				let accumWithNext = accum + char;
				for (const [key, value] of Object.entries(numbers)) {
					if (accumWithNext.includes(key)) {
						return accumWithNext.replace(key, value);
					}
				}

				return accumWithNext;
			}, "");

			console.log(line, "->", replaced, "->", getDigits(replaced));

			return getDigits(replaced);
		})
		.reduce((accum, num) => (accum += num), 0);
}

let lines = text.trim().split("\n");
console.log("Part 1 -", part1(lines));
console.log("Part 2 -", part2(lines));
