const foo = Bun.file("inputs/day1.txt");
const text = await foo.text();

console.log(
	text
		.trim()
		.split("\n")
		.map((line) => {
			const digits = line.split("").filter((character) => {
				return Number.parseInt(character);
			});

			return Number.parseInt(`${digits[0]}${digits[digits.length - 1]}`);
		})
		.reduce((accum, num) => (accum += num)),
);

