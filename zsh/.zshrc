# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#testing git
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export _Z_CMD="zz"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

fpath+=~/.zfunc
# autoload -Uz compinit && compinit

DISABLE_FZF_KEY_BINDINGS=false
zstyle ':omz:alpha:lib:git' async-prompt no

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set the location for custom plugins and themes

#ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.zsh}"


########### Oh My Zsh Plugin Section ###########

# Plugins managed by Oh My Zsh
plugins=(
    git
    copyfile
    copypath
    fzf
    iterm2
    last-working-dir
    macos
    web-search
    zsh-interactive-cd
    toggle_key_mode
    brew
    AWS
)
# plugins=()

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Load oh-my-zsh plugins
for plugin in "${plugins[@]}"; do
    if [[ -f "$ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh" ]]; then
        source "$ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh"
    elif [[ -f "$ZSH/plugins/$plugin/$plugin.plugin.zsh" ]]; then
        source "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
    fi
done

########### End Oh My Zsh Plugin Section ###########


# Ensure dircolors are set
eval "$(dircolors /Users/bradleyeuell/Downloads/dircolors.ansi-dark)"

# Set theme
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh settings
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13
COMPLETION_WAITING_DOTS="true"

########### Custom Plugin Section ###########
# Define the custom plugin directory for _pluginload_
ZPLUGINDIR=${HOME}/.zsh/plugins

# Function to load custom plugins from GitHub
_pluginload_() {
    local giturl="$1"
    local plugin_name=${${1##*/}%.git}
    local plugindir="${ZPLUGINDIR}/$plugin_name"

    # Clone if the plugin isn't there already
    if [[ ! -d "${plugindir}" ]]; then
        command git clone --depth 1 --recursive --shallow-submodules "${giturl}" "${plugindir}"
        [[ $? -eq 0 ]] || { echo "plugin-load: git clone failed $1" && return 1; }
    fi

    # Symlink an init.zsh if there isn't one so the plugin is easy to source
    if [[ ! -f $plugindir/init.zsh ]]; then
        local initfiles=(
            $plugindir/$plugin_name.plugin.zsh(N)
            $plugindir/$plugin_name.zsh(N)
            $plugindir/$plugin_name(N)
            $plugindir/$plugin_name.zsh-theme(N)
            $plugindir/*.plugin.zsh(N)
            $plugindir/*.zsh(N)
            $plugindir/*.zsh-theme(N)
            $plugindir/*.sh(N)
        )
        [[ ${#initfiles[@]} -gt 0 ]] || { >&2 echo "plugin-load: no plugin init file found" && return 1; }
        command ln -s ${initfiles[1]} $plugindir/init.zsh
    fi

    # Source the plugin
    source $plugindir/init.zsh

    # Modify fpath
    fpath+=$plugindir
    [[ -d $plugindir/functions ]] && fpath+=$plugindir/functions
}

# Example custom plugins array
# custom_plugins=(
#     "peterhurford/up.zsh"
#     "marlonrichert/zsh-hist"
#     "reegnz/jq-zsh-plugin"
#     "MichaelAquilina/zsh-you-should-use"
#     "rupa/z"
#     "sudosubin/zsh-github-cli"
#     "zpm-zsh/ssh"
#     "romkatv/powerlevel10k"
#     "ellie/atuin"
# )

# add your plugins to this list
custom_plugins=(
    # core plugins
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions

    # # user plugins
    peterhurford/up.zsh                 # Cd to parent directories (ie. up 3)
    marlonrichert/zsh-hist              # Run hist -h for help
    reegnz/jq-zsh-plugin                # Write interactive jq queries (Requires jq and fzf)
    MichaelAquilina/zsh-you-should-use  # Recommends aliases when typed
    rupa/z                              # Tracks your most used directories, based on 'frequency'

    # Additional completions
    #sudosubin/zsh-github-cli
    #zpm-zsh/ssh

    # prompts
    # denysdovhan/spaceship-prompt
    #romkatv/powerlevel10k

    # load these last
    #zsh-users/zsh-syntax-highlighting
    zdharma-continuum/fast-syntax-highlighting
    #zsh-users/zsh-history-substring-search
)

mac_plugins=(
      ellie/atuin     # Replace history search with a sqlite database
)

# Load custom plugins from GitHub
# for repo in ${custom_plugins[@]}; do
#     _pluginload_ https://github.com/${repo}.git
# done

########### End Custom Plugin Section ###########

########### Custom Function Section ###########
# Load custom functions
# for function_file in $HOME/.zsh/functions/*.zsh; do
#   source $function_file
# done

# Add custom function directories to fpath
# fpath+=("$HOME/.zsh/functions")

# # Autoload all functions in the functions directory
# for func in $HOME/.zsh/functions/*.zsh; do
#   autoload -Uz "${func:t:r}"
# done

# # Source custom function descriptions
# for func_desc in $HOME/.zsh/functions/*.zsh; do
#   source "$func_desc"
# done

# load your plugins (clone, source, and add to fpath)
for repo in ${custom_plugins[@]}; do
  _pluginload_ https://github.com/${repo}.git
done
unset repo

if [[ ${OSTYPE} == "darwin"* ]]; then
  for mac_repo in ${mac_plugins[@]}; do
    _pluginload_ https://github.com/${mac_repo}.git
  done
  unset mac_repo
fi

# Update ZSH Plugins
function zshup () {
  local plugindir="${ZPLUGINDIR:-$HOME/.zsh/plugins}"
  for d in $plugindir/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}
# Load custom plugins
for plugin_dir in $ZSH/custom/plugins/*; do
  if [ -f $plugin_dir/*.plugin.zsh ]; then
    source $plugin_dir/*.plugin.zsh
  fi
done

# Load custom aliases
if [ -f $ZSH/custom/aliases.zsh ]; then
  source $ZSH/custom/aliases.zsh
fi

# Atuin configuration
if command -v atuin &>/dev/null; then
    export ATUIN_NOBIND="true"
    eval "$(atuin init zsh)"
    bindkey '^r' _atuin_search_widget
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# Load Completions
autoload -Uz compinit
compinit -i

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='nvim'
fi

# Encoding
export LANG='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'

# Paths
_myPaths=(
    "${HOME}/.local/bin"
    "/usr/local/bin"
    "/Library/TeX/texbin"
    "${HOME}/bin"
    "/opt/homebrew/bin"
)
for _path in "${_myPaths[@]}"; do
    if [[ -d ${_path} ]]; then
        if ! printf "%s" "${_path}" | grep -q "${PATH}"; then
            PATH="${_path}:${PATH}"
        fi
    fi
done
unset _myPaths _path

# Set options
setopt always_to_end
setopt append_history
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt completeinword
setopt extended_glob
setopt extended_history
setopt glob_dots
setopt hash_list_all
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt histignorespace
setopt inc_append_history
setopt interactivecomments
setopt longlistjobs
setopt no_beep
setopt nocaseglob
setopt nonomatch
setopt noshwordsplit
setopt notify
setopt numeric_glob_sort
setopt pushd_ignore_dups
setopt share_history
HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=${HISTSIZE}

# Automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Set a variable so I can check if I'm running zsh
export ZSH_VERSION=$(zsh --version | awk '{print $2}')

# Set man pager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Load custom dotfiles
#DOTFILES_LOCATION="${HOME}/repos/dotfiles"
#configFileLocations=(
#    "${DOTFILES_LOCATION}/dotfiles/shell"
#    "${HOME}/repos/dotfiles-private/dotfiles/shell"
#)
# for configFileLocation in "${configFileLocations[@]}"; do
#     if [ -d "${configFileLocation}" ]; then
#         while read -r configFile; do
#             source "${configFile}"
#         done < <(find "${configFileLocation}" \
#             -maxdepth 1 \
#             -type f \
#             -name '*.zsh' \
#             -o -name '*.sh' | sort)
#     fi
#done
# unset DOTFILES_LOCATION configFileLocations configFileLocation

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Perl setup
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
PATH="/Users/bradleyeuell/perl5/bin${PATH:+:${PATH}}"; export PATH
PERL5LIB="/Users/bradleyeuell/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB
PERL_LOCAL_LIB_ROOT="/Users/bradleyeuell/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT
PERL_MB_OPT="--install_base \"/Users/bradleyeuell/perl5\""; export PERL_MB_OPT
PERL_MM_OPT="INSTALL_BASE=/Users/bradleyeuell/perl5"; export PERL_MM_OPT

# Python setup

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


export HELPDIR="~/zsh_help"
# Remove the default of run-help being aliased to man
unalias run-help
# Use zsh's run-help, which will display information for zsh builtins.
autoload run-help

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Bind the toggle function to Ctrl+T for vi command mode
bindkey -M vicmd '^T' toggle_key_mode

eval "$(ssh-agent -s)" > /dev/null
ssh-add -K ~/.ssh/id_rsa &>/dev/null

export PATH="/opt/homebrew/opt/sqlite3/bin:$PATH"

complete -C '/usr/local/bin/aws_completer' aws

export ZSH_STARTUP_COMPLETE=true

# opam configuration
[[ ! -r /Users/bradleyeuell/.opam/opam-init/init.zsh ]] || source /Users/bradleyeuell/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
eval "$(zoxide init zsh)"
