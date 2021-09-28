# exa aliases
abbr ls "exa"
abbr l "exa"
abbr la "exa -a"
abbr ll "exa -l"

# bat alias
if type -q batcat
    abbr cat "batcat"
else if type -q bat
    abbr cat "bat"
end

# autojump
if test -f $HOME/.autojump/share/autojump/autojump.fish; . $HOME/.autojump/share/autojump/autojump.fish; end

# helpful env variables
export LC_CTYPE="en_CA.UTF-8"
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin:/home/jonathan/.local/share/gem/ruby/2.7.0/bin:$HOME/.emacs.d/bin/"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
set -Ux CARGO_TARGET_DIR "$HOME/cargo_builds"
export EDITOR=(which nvim)

# nerd fonts
set -g theme_nerd_fonts yes
set -g theme_display_date no

# vi keybinds
fish_vi_key_bindings

# don't show vi status on powerline prompt
set -g theme_display_vi no
set -g theme_color_scheme nord

# remove greeting
function fish_greeting
end

export LLVM_SYS_100_PREFIX=/usr/lib/llvm-11/
export LC_ALL=en_US.UTF-8
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/jonathan/.mujoco/mjpro150/bin"
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
