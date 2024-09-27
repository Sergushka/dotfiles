# If you come from bash you might have to change your $PATH.
export MODULAR_HOME="$HOME/.modular"
export PATH="$HOME/bin:/usr/local/bin:$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

alias ls="eza --icons=always"

eval "$(starship init zsh)"
