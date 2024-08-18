# ~/.oh-my-zsh/custom/aliases.zsh

# Custom Aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias la="gls -GA --color=auto"
alias ll="gls -Gl --color=auto"
alias ls="gls --color=auto"
alias lla="gls -Al --color=auto"
alias zalias="nvim ~/.oh-my-zsh/custom/aliases.zsh"
alias sourcea="source ~/.zshrc"
alias dircolors='gdircolors'
alias rh='run-help'
alias rgf='rg_fzf'
alias lld='fd --hidden -l -d 1 | rg "^d.*$"'
alias db='dune build'
alias de='dune exec'
alias rmdst='find . -name .DS_Store -type f -delete'
alias tattach='tmux attach-session -t $(tmux list-sessions | fzf --preview "echo {}" | awk -F: "{print \$1}")'
alias tma2='tmux attach-session -t $(tmux list-sessions | awk -F: "{print \$1}" | xargs -I % zsh -c "echo Session %; tmux list-windows -t %" | xargs -I {} echo {} | while IFS= read -r line; 
do
        if [[ $line =~ "^Session" ]]
        then
        currentSession="${line/#Session }"
        echo "$line"
        else
        printf "%s:%s\n" "$currentSession" "$line"
        currentWindow="${line%%:*}"
        panes=("$(tmux list-panes -t $currentSession:$currentWindow)")
        echo $panes | awk -v currentSession="$currentSession" -v currentWindow="$currentWindow" "{OFS=\"\" ; print currentSession,\":\"currentWindow,\".\",\$0}"
        fi
done | fzf --reverse | awk -F ": " "{print \$1}")'
alias oe='eval $(opam env)'
alias co='colorize_output'
alias ez='exec zsh'
alias lls='ls_with_truepath'
alias dut='dune utop'
