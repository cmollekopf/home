

fzf_key_bindings
function fish_user_key_bindings
    ### Custom
    # bind \e, 'history-token-search-backward'
    # bind \e. 'history-token-search-forward'
    # bind \eup 'history-token-search-backward'
    # bind \edown 'history-token-search-forward'
    # bind \ebackspace 'backward-kill-word'
    # bind \eleft 'backward-word'
    # bind \eright 'forward-word'
    ### fzy ###
    bind \cr 'fzy_select_history (commandline -b)'
    bind \cf fzy_select_directory
    ### fzy ###
end
