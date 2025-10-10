plugins=(
  "/opt/homebrew/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
)

for plugin in "${plugins[@]}"; do
  [[ -f "$plugin" ]] && source "$plugin"
done
