const RED = 12;
const GREEN = 13;
const BLUE = 14;

type Roll = {
	red: number;
	green: number;
	blue: number;
};

type Game = {
	id: number;
	rolls: Roll[];
};

function parseRolls(strings: string[]): Roll {
	const red = strings.find((value) => value.includes("red"));
	const green = strings.find((value) => value.includes("green"));
	const blue = strings.find((value) => value.includes("blue"));

	return {
		red: red && Number.parseInt(red) ? Number.parseInt(red) : 0,
		green: green && Number.parseInt(green) ? Number.parseInt(green) : 0,
		blue: blue && Number.parseInt(blue) ? Number.parseInt(blue) : 0,
	};
}

function parseGame(stringRep: string): Game {
	const split = stringRep.split(": ");
	const game = split[0].trim();
	const rolls = split[1]?.split("; ").map((roll) => {
		return roll.split(",");
	});

	return {
		id: Number.parseInt(game.split(" ")[1]),
		rolls: rolls.map((roll) => parseRolls(roll)),
	};
}

function part1(games: Game[]): number {
	return games
		.filter((game) =>
			game?.rolls.every(
				(roll) => roll.red <= RED && roll.green <= GREEN && roll.blue <= BLUE,
			),
		)
		.reduce((accum, game) => accum + game.id, 0);
}

function part2(games: Game[]): number {
	return games
		.map((game) => {
			let maxRed = 0;
			let maxGreen = 0;
			let maxBlue = 0;

			for (const roll of game.rolls) {
				if (roll.red > maxRed) {
					maxRed = roll.red;
				}

				if (roll.green > maxGreen) {
					maxGreen = roll.green;
				}

				if (roll.blue > maxBlue) {
					maxBlue = roll.blue;
				}
			}

			return maxRed * maxGreen * maxBlue;
		})
		.reduce((accum, product) => accum + product, 0);
}

const file = Bun.file("inputs/day2.txt");
const text = await file.text();
const games = text.trim().split("\n").map(parseGame);

console.log("Part 1 -", part1(games));
console.log("Part 2 -", part2(games));
