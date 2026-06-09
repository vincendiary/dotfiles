# ~/.config/zsh/options.zsh

## Options

setopt AUTO_CD              # cd by typing directory name
setopt AUTO_PUSHD           # pushd by typing directory name
setopt PUSHD_IGNORE_DUPS    # don't push dupes on pushd
setopt PUSHD_SILENT         # don't print pushd messages
setopt COMPLETE_IN_WORD     # complete from cursor position
setopt ALWAYS_TO_END        # move cursor to end of line after completion
setopt HIST_FIND_NO_DUPS    # skip dupes on search
setopt HIST_IGNORE_ALL_DUPS # don't save dupes
setopt HIST_IGNORE_SPACE    # space prefixed commands are not saved
setopt EXTENDED_HISTORY     # save timestamp and duration of commands
setopt SHARE_HISTORY        # share history between sessions
setopt INTERACTIVE_COMMENTS # allow comments in interactive mode
setopt NO_BEEP              # don't beep

export HISTFILE=$ZDOTDIR/.zhistory
export HISTSIZE=100000
export SAVEHIST=100000
