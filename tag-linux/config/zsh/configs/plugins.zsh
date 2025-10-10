plugins=(
  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
)

for plugin in "${plugins[@]}"; do
  [[ -f "$plugin" ]] && source "$plugin"
done
