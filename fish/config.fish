if status is-interactive
    set -g fish_greeting ''

    set -gx EDITOR nvim

    alias where 'which'

    fish_add_path /opt/homebrew/bin 
    fish_add_path /opt/homebrew/sbin
    fish_add_path $HOME/.local/bin

    fish_vi_key_bindings
    bind -M insert \ca beginning-of-line # ctrl-a in insert mode
    bind -M insert \ce end-of-line       # ctrl-e in insert mode

    # pull in work-specific config if present
    set -l work_config $__fish_config_dir/work.fish
    test -f $work_config && source $work_config

    command -q jj       && COMPLETE=fish jj        | source
    command -q kubectl  && kubectl completion fish | source
    command -q rustup   && rustup completions fish | source
    command -q direnv   && direnv hook fish        | source
    command -q starship && starship init fish      | source
    command -q herdr    && herdr completion fish   | source
end
