open Common
type accum = {previous: option<int>, increasing: int, decreasing: int}

let iter = nums => {
  let result = nums->Array.reduce({previous: None, increasing: 0, decreasing: 0}, (acc, num) => {
    switch num {
    | Some(num) =>
      switch acc.previous {
      | Some(prev) if num > prev => {
          ...acc,
          previous: Some(num),
          increasing: acc.increasing + 1,
        }
      | Some(prev) if num < prev => {
          ...acc,
          previous: Some(num),
          decreasing: acc.decreasing + 1,
        }
      | _ => {...acc, previous: Some(num)}
      }
    | None => acc
    }
  })

  result.increasing
}

let slidingWindow = nums =>
  nums
  ->Array.mapWithIndex((i, _) => nums->Array.slice(~offset=i, ~len=3))
  ->Array.keep(a => a->Array.length == 3)

let windowSums = nums =>
  nums
  ->slidingWindow
  ->Array.map(window => window->Array.reduce(0, (sum, val) => sum + val->Option.getWithDefault(0)))

let solve = nums => {
  let nums = nums->Array.map(Int.fromString)
  let part1 = iter(nums)
  let part2 = iter(nums->windowSums->Array.map(x => Some(x)))
  {part1, part2}
}
