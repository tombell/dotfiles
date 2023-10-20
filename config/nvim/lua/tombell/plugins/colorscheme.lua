return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      highlight_overrides = {
        frappe = function(frappe)
          return {
            Folded = { fg = frappe.blue, bg = frappe.mantle },
            VertSplit = { fg = frappe.surface0, bg = frappe.base },
          }
        end,
      },
    },
  },
}
