set fish_greeting

alias vim='nvim'
alias lt='exa -aT --color=always --group-directories-first' # tree listing

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
