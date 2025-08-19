fpath=($HOME/.config/zsh/completion $fpath)

autoload -Uz compinit
if [ -n $HOME/.zcompdump(#qN.mh+24) ]; then
  compinit -d $HOME/.zcompdump
else
  compinit -C
fi
