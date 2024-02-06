neofetch

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f ~/.flake/config/zsh/.p10k.zsh ]]; then
  source ~/.flake/config/zsh/.p10k.zsh
fi

bindkey -M menuselect '\r' .accept-line

# export EDITOR=nvim
