type simulation = {days: int, buckets: array<bigint>}

let init = input => {
  let buckets = Array.make(9, 0n)
  input
  ->String.split(",")
  ->Array.forEach(value => {
    switch value->Int.fromString {
    | Some(timer) => {
        let _ = buckets[timer] = Array.getExn(buckets, timer) + 1n
      }
    | None => failwith("Invalid input")
    }
  })
  {days: 0, buckets}
}

let simulate = (initialState, targetDays) => {
  let rec loop = (buckets, days) => {
    if days == targetDays {
      buckets->Array.reduce(0n, (acc, count) => acc + count)
    } else {
      let newBuckets = Array.make(9, 0n)
      for i in 0 to 7 {
        let _ = newBuckets[i] = Array.getExn(buckets, i + 1)
      }
      let spawning = Array.getExn(buckets, 0)
      let _ = newBuckets[6] = Array.getExn(newBuckets, 6) + spawning
      let _ = newBuckets[8] = spawning
      loop(newBuckets, days + 1)
    }
  }
  loop(initialState.buckets, initialState.days)
}
