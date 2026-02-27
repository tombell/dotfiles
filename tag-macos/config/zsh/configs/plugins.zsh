plugins=(
  "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for plugin in "${plugins[@]}"; do
  [[ -f "$plugin" ]] && source "$plugin"
done
