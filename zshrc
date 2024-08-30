for function in ~/.config/zsh/functions/*; do
  source $function
done

# extra files in ~/.config/zsh/configs/pre, ~/.config/zsh/configs, and
# ~/.config/zsh/configs/post these are loaded first, second, and third,
# respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.config/zsh/configs"

# zsh-autosuggestions
source "$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# asdf
source "$(brew --prefix asdf)/libexec/asdf.sh"

export VISUAL=nvim
export EDITOR=$VISUAL

[[ -f ~/.localrc ]] && source ~/.localrc
