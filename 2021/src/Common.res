@module("fs") external readFileSync: (string, string) => string = "readFileSync"

let readInput = (path: string): string => readFileSync(path, "utf-8")->String.trim

let readLines = (path: string): array<string> => readInput(path)->Js.String.split("\n")
