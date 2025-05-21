fn check_match(digits: &Vec<u32>, index: usize, digit: u32) -> bool {
    let step = digits.len() / 2;

    let check_index = {
        let result = index + step;

        if result >= digits.len() {
            result - digits.len()
        } else {
            result
        }
    };

    if digit == digits[check_index] {
        true
    } else {
        false
    }
}

fn parse_input(input: &str) -> Vec<u32> {
    input
        .trim()
        .chars()
        .map(|c| c.to_digit(10).unwrap())
        .collect()
}

fn part1(digits: &Vec<u32>) -> u32 {
    let mut iter = digits.windows(2);
    let mut sum = 0;
    while let Some(window) = iter.next() {
        if window[0] == window[1] {
            sum += window[0];
        }
    }

    let first = digits.get(0);
    let last = digits.get(digits.len() - 1);

    if first == last {
        sum += first.unwrap();
    }

    sum
}

fn part2(digits: &Vec<u32>) -> u32 {
    let mut sum = 0;
    for i in 0..digits.len() {
        if check_match(digits, i, digits[i]) {
            sum += digits[i];
        }
    }
    sum
}

pub fn solve(input: &str) {
    let parsed = parse_input(input);
    println!("Part 1 - {}", part1(&parsed));
    println!("Part 2 - {}", part2(&parsed));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1_1122() {
        let input = parse_input("1122");
        let result = part1(&input);
        assert_eq!(result, 3);
    }

    #[test]
    fn test_part1_1111() {
        let input = parse_input("1111");
        let result = part1(&input);
        assert_eq!(result, 4);
    }

    #[test]
    fn test_part1_1234() {
        let input = parse_input("1234");
        let result = part1(&input);
        assert_eq!(result, 0);
    }

    #[test]
    fn test_part1_91212129() {
        let input = parse_input("91212129");
        let result = part1(&input);
        assert_eq!(result, 9);
    }

    #[test]
    fn test_part2_1212() {
        let input = parse_input("1212");
        let result = part2(&input);
        assert_eq!(result, 6);
    }

    #[test]
    fn test_part2_1221() {
        let input = parse_input("1221");
        let result = part2(&input);
        assert_eq!(result, 0);
    }

    #[test]
    fn test_part2_123425() {
        let input = parse_input("123425");
        let result = part2(&input);
        assert_eq!(result, 4);
    }

    #[test]
    fn test_part2_123123() {
        let input = parse_input("123123");
        let result = part2(&input);
        assert_eq!(result, 12);
    }

    #[test]
    fn test_part2_12131415() {
        let input = parse_input("12131415");
        let result = part2(&input);
        assert_eq!(result, 4);
    }
}
