plugins=(
  "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for plugin in "${plugins[@]}"; do
  [[ -f "$plugin" ]] && source "$plugin"
done
