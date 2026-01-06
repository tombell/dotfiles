require("neotest").setup {
  adapters = {
    require "neotest-bun",
    require "neotest-golang",
    require "neotest-minitest",
    require "neotest-vitest",
  },
}
