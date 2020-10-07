# exa aliases
abbr ls "exa"
abbr l "exa"
abbr la "exa -a"

# bat alias
abbr cat "bat"

# autojump
if test -f $HOME/.autojump/share/autojump/autojump.fish; . $HOME/.autojump/share/autojump/autojump.fish; end

# helpful env variables
export LC_CTYPE="en_CA.UTF-8"
export PATH="$PATH:$HOME/.cargo/bin"
set -Ux CARGO_TARGET_DIR "$HOME/cargo_builds"
set -g EDITOR /usr/bin/nvim
set -g QT_SCALE_FACTOR 0.60

# nerd fonts
set -g theme_nerd_fonts yes
set -g theme_display_date no

# vi keybinds
fish_vi_key_bindings

# don't show vi status on powerline prompt
set -g theme_display_vi no

# remove greeting
function fish_greeting
end
