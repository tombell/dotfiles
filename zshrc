# export env var for projects path
export PROJECTS="$HOME/Code"

# load custom executable functions
for function in ~/.config/zsh/functions/*; do
  source $function
done

# extra files in ~/.config/zsh/configs/pre , ~/.config/zsh/configs , and
# ~/.config/zsh/configs/post these are loaded first, second, and third,
# respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.config/zsh/configs"

files=(~/.aliases ~/.localrc)
for f in "${files[@]}"; do
  [[ -f "$f" ]] && source "$f"
done

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5a6477"

[[ -f "$(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
  && source "$(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[[ -f "$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] \
  && source "$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
