open Core

type box =
  { length : int
  ; width : int
  ; height : int
  }

let create_box length width height = { length; width; height }

let smallest_area x y z =
  let sorted = [| x; y; z |] |> Array.sorted_copy ~compare:(fun a b -> a - b) in
  Array.get sorted 0 * Array.get sorted 1
;;

let required_area box =
  let x = 2 * box.length * box.width in
  let y = 2 * box.width * box.height in
  let z = 2 * box.height * box.length in
  x + y + z + smallest_area box.length box.width box.height
;;

let smallest_perimiter x y z =
  let sorted = [| x; y; z |] |> Array.sorted_copy ~compare:(fun a b -> a - b) in
  (Array.get sorted 0 + Array.get sorted 1) * 2
;;

let volume x y z = x * y * z

let ribbon_amount box =
  smallest_perimiter box.length box.width box.height
  + volume box.length box.width box.height
;;
