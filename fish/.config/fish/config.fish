set fish_greeting

# Navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end

# Utilities
function grep     ; command grep --color=auto $argv ; end

alias vim='nvim'
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias emacs='emacsclient -c -a "emacs"'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias commit='git commit -m'

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end
