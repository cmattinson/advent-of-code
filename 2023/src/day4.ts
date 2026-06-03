export type Card = {
    id: number;
    winning: number[];
    have: number[];
};

export function part1(cards: Card[]): number {
    return cards.reduce((acc, card) => {
        let total = 0;
        for (const have of card.have) {
            if (card.winning.includes(have)) {
                total = total === 0 ? 1 : total * 2;
            }
        }
        return acc + total;
    }, 0);
}

export function part2(cards: Card[]): number {
    const totalCards = cards.length;
    const winners: Map<number, number> = new Map();
}

export function solve(cards: Card[]): [number, number] {
    return [part1(cards), part2(cards)];
}
