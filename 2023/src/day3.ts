export function isDigit(char: string): boolean {
    if (char) {
        return /[0-9]/.test(char);
    }
    return false;
}

export function isSymbol(char: string): boolean {
    if (char) {
        return /[^0-9A-Za-z.]/.test(char);
    }
    return false;
}

function checkAdjacent(grid: string[][], x: number, y: number): boolean {
    const directions = [
        [-1, -1],
        [-1, 0],
        [-1, 1],
        [0, -1],
        [0, 1],
        [1, -1],
        [1, 0],
        [1, 1],
    ];

    for (const [dx, dy] of directions) {
        if (x + dx < 0 || x + dx >= grid.length || y + dy < 0 || y + dy >= grid[0].length) {
            continue;
        }

        if (isSymbol(grid[y + dy][x + dx])) {
            return true;
        }
    }
    return false;
}

function isGear(grid: string[][], x: number, y: number): boolean {
    return grid[y][x] === "*";
}

export function part1(grid: string[][]): number {
    let sum = 0;
    let numString = "";
    let isAdjacent: boolean[] = [];

    for (let y = 0; y < grid.length; y++) {
        for (let x = 0; x < grid[0].length; x++) {
            if (isDigit(grid[y][x])) {
                numString += grid[y][x];
                isAdjacent.push(checkAdjacent(grid, x, y));
                if (!isDigit(grid[y][x + 1]) && isAdjacent.includes(true)) {
                    sum += Number.parseInt(numString);
                    numString = "";
                    isAdjacent = [];
                }
            } else {
                numString = "";
                isAdjacent = [];
            }
        }
    }

    return sum;
}

export function part2(grid: string[][]): number {
    return 0;
}

export function solve(grid: string[][]): [number, number] {
    return [part1(grid), 0];
}
