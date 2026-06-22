plugins=(
  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for plugin in "${plugins[@]}"; do
  [[ -f "$plugin" ]] && source "$plugin"
done
