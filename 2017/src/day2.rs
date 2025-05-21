fn parse_line(line: &str) -> Vec<u32> {
    line.trim()
        .split(" ")
        .map(|s| s.parse::<u32>().unwrap())
        .collect()
}

fn part1(input: &str) -> u32 {
    let mut sum = 0;
    for line in input.lines() {
        let digits: Vec<u32> = parse_line(line);

        let mut max = u32::MIN;
        let mut min = u32::MAX;

        for &num in &digits {
            if num > max {
                max = num;
            }
            if num < min {
                min = num;
            }
        }

        sum += max - min;
    }
    sum
}

fn part2(input: &str) -> u32 {
    let mut sum = 0;
    for line in input.lines() {
        let digits: Vec<u32> = parse_line(line);

        let find_evenly_divisible = |num: u32| -> Option<(u32, u32)> {
            for &other in &digits {
                if num != other && num % other == 0 {
                    return Some((num, other));
                }
            }
            None
        };

        for &num in &digits {
            if let Some((num, other)) = find_evenly_divisible(num) {
                sum += num / other;
            }
        }
    }
    sum
}

pub fn solve(input: &str) {
    println!("Part 1 - {}", part1(&input));
    println!("Part 2 - {}", part2(&input));
}
