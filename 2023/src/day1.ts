const digitStrings = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];

function getDigits(group: string[]): number {
    const digits = group.filter((char: string) => {
        return !Number.isNaN(Number.parseInt(char));
    });

    return Number.parseInt(`${digits[0]}${digits[digits.length - 1]}`);
}

export function part1(lines: string[]): number {
    return lines.map((line) => getDigits(line.split(""))).reduce((accum, num) => accum + num, 0);
}

export function part2(lines: string[]): number {
    return lines
        .map((line) => {
            const digits: number[] = [];
            for (const [index, char] of line.split("").entries()) {
                if (!Number.isNaN(Number.parseInt(char))) {
                    digits.push(Number.parseInt(char));
                } else {
                    for (const [digitIndex, digit] of digitStrings.entries()) {
                        if (line.startsWith(digit, index)) {
                            digits.push(digitIndex + 1);
                        }
                    }
                }
            }

            return Number.parseInt(`${digits[0]}${digits[digits.length - 1]}`);
        })
        .reduce((accum, num) => accum + num, 0);
}

export function solve(lines: string[]): [number, number] {
    return [part1(lines), part2(lines)];
}
