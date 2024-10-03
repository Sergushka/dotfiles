# If you come from bash you might have to change your $PATH.
export MODULAR_HOME="$HOME/.modular"
export PATH="$HOME/bin:/usr/local/bin:$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

alias ls="eza --icons=always"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias boot-win="sudo efibootmgr -n 2; sudo reboot"

eval "$(starship init zsh)"
