function fish_prompt --description 'Write out the prompt'
    #Set the color for the status depending on the value
    if test $status -gt 0
      set __fish_color_status (set_color -o red)
    else
      set __fish_color_status (set_color -o green)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_color_usrename
        set -g __fish_color_usrename (set_color -o d75fd7)
    end

    if not set -q __fish_color_attmark
        set -g __fish_color_attmark (set_color -o 005fff)
    end

    if not set -q __fish_color_hostname
        set -g __fish_color_hostname (set_color -o green)
    end

    if not set -q __fish_color_shlvl
        set -g __fish_color_shlvl (set_color -o 875fff)
    end

    if not set -q __fish_color_datetime
        set -g __fish_color_datetime (set_color -o 8a8a8a)
    end

    if not set -q __fish_color_cwd_bule
        set -g __fish_color_cwd_bule (set_color -o 00afff)
    end

    switch "$USER"

        case root toor

            if not set -q __fish_prompt_cwd
                if set -q fish_color_cwd_root
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
                else
                    set -g __fish_prompt_cwd $__fish_color_cwd_bule
                end
            end

            #printf '%s@%s %s%s%s# ' $USER (prompt_hostname) "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"
            printf '%s%s%s@%s%s %s%s\r\f%s[%s]%s[%s] %s$%s ' "$__fish_color_usrename" $USER "$__fish_color_attmark" "$__fish_color_hostname" (prompt_hostname) "$__fish_prompt_cwd" "$PWD"\

        case '*'

            if not set -q __fish_prompt_cwd
                set -g __fish_prompt_cwd $__fish_color_cwd_bule
            end

            printf '%s%s%s@%s%s %s%s\r\f%s[%s]%s[%s] %s$%s ' "$__fish_color_usrename" $USER "$__fish_color_attmark" "$__fish_color_hostname" (prompt_hostname) "$__fish_prompt_cwd" "$PWD"\
             $__fish_color_shlvl $SHLVL "$__fish_color_datetime" (date "+%y/%m/%d %H:%M:%S") "$__fish_color_status" "$__fish_prompt_normal"

    end
end
