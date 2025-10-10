require("neotest").setup {
  adapters = {
    require "neotest-golang",
    require "neotest-jest",
    require "neotest-rspec",
    require "neotest-vitest",
  },
}
