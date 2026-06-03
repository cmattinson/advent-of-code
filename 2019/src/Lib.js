"use strict";

import { readFileSync } from "fs";

export function readFile(path) {
	return function () {
		return readFileSync(path, "utf8").trim();
	};
}
