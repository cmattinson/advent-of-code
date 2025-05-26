///|
priv struct Passport {
  passport_id : Int64?
  birth_year : Int?
  issue_year : Int?
  expiration_year : Int?
  height : String?
  hair_color : String?
  eye_color : String?
  country_id : Int64?
} derive(Show)

///|
fn parse_int_opt(s : String) -> Int? {
  match @strconv.parse_int?(s) {
    Ok(i) => Some(i)
    Err(_) => None
  }
}

///|
fn parse_int64_opt(s : String) -> Int64? {
  match @strconv.parse_int64?(s) {
    Ok(i) => Some(i)
    Err(_) => None
  }
}

///|
fn parse_passport(passport : Array[@string.StringView]) -> Passport {
  let mut birth_year : Int? = None
  let mut issue_year : Int? = None
  let mut expiration_year : Int? = None
  let mut height : String? = None
  let mut hair_color : String? = None
  let mut eye_color : String? = None
  let mut passport_id : Int64? = None
  let mut country_id : Int64? = None
  for field in passport {
    let split = field.split(":").to_array()
    match split[0] {
      "byr" => birth_year = parse_int_opt(split[1].to_string())
      "iyr" => issue_year = parse_int_opt(split[1].to_string())
      "eyr" => expiration_year = parse_int_opt(split[1].to_string())
      "hgt" => height = Some(split[1].to_string())
      "hcl" => hair_color = Some(split[1].to_string())
      "ecl" => eye_color = Some(split[1].to_string())
      "pid" => passport_id = parse_int64_opt(split[1].to_string())
      "cid" => country_id = parse_int64_opt(split[1].to_string())
      _ => ()
    }
  }
  Passport::{
    birth_year,
    issue_year,
    expiration_year,
    height,
    hair_color,
    eye_color,
    passport_id,
    country_id,
  }
}

///|
fn is_valid(passport : Passport) -> Bool {
  match passport {
    {
      passport_id: Some(_),
      birth_year: Some(_),
      issue_year: Some(_),
      expiration_year: Some(_),
      height: Some(_),
      hair_color: Some(_),
      eye_color: Some(_),
      country_id: Some(_)
      | None,
    } => true
    _ => false
  }
}

///|
fn part1(passports : Array[Array[@string.StringView]]) -> Int {
  passports
  .filter(fn { string_rep => string_rep |> parse_passport |> is_valid })
  .length()
}

///|
fn part2(_passports : Array[Array[@string.StringView]]) -> Int {
  0
}

///|
fn solve(input : @string.View) -> (Int, Int) {
  let passports = input
    .split("\n\n")
    .map(fn {
      line => line.replace_all(old="\n", new=" ").split(" ").to_array()
    })
    .to_array()
  (part1(passports), part2(passports))
}

///|
test "day 4" {
  let contents = @lib.read_file_from_path("inputs/day4.txt")
  match contents {
    Ok(contents) => inspect!(solve(contents), content="(210, 0)")
    Err(e) => println(e)
  }
}
