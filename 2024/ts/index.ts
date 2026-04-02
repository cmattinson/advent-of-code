const text = await Bun.file("input/day2.txt").text();

function isSafe(levels: number[]): boolean {
	const isAscending = levels[0]! < levels[1]!;

	return levels.every((level, i) => {
		const next = levels[i + 1]!;

		const diff = Math.abs(level - next);
		if (diff < 1 || diff > 3) return false;

		if (isAscending && level >= next) return false;
		if (!isAscending && level <= next) return false;

		return true;
	});
}

function isSafeDampened(levels: number[]): boolean {
	if (isSafe(levels)) return true;

	for (let i = 0; i < levels.length; i++) {
		if (isSafe(levels.filter((_, j) => j !== i))) return true;
	}

	return false;
}

function countSafe(
	reports: number[][],
	checkFn: (levels: number[]) => boolean,
): number {
	return reports.reduce((acc, levels) => acc + (checkFn(levels) ? 1 : 0), 0);
}

const digits = text
	.trim()
	.split("\n")
	.map((line) => line.split(" ").map((char) => Number.parseInt(char)));

console.log("Part 1 - %d", countSafe(digits, isSafe));
console.log("Part 2 - %d", countSafe(digits, isSafeDampened));
