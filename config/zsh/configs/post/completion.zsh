fpath=($HOME/.config/zsh/completion /usr/local/share/zsh/site-functions /opt/homebrew/share/zsh/site-functions $fpath)

autoload -Uz compinit
if [ -n $HOME/.zcompdump(#qN.mh+24) ]; then
  compinit -d $HOME/.zcompdump
else
  compinit -C
fi
