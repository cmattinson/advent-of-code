import { defineConfig } from "vitest/config"

export default defineConfig({
  test: {
    include: ["test/**/*.bs.js", "test/**/*.test.ts"],
  },
})
