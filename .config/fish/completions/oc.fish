set -l commands rsh get
# Disable file completions
complete -c oc -f
# rsh completions
complete -c oc -n "__fish_seen_subcommand_from rsh" \
    -a "(oc get pods | grep Running | cut -d' ' -f1)"
# oc logs 
complete -c oc -n "__fish_seen_subcommand_from logs" \
    -a "(oc get pods | cut -d' ' -f1)"

complete -c oc -n "__fish_seen_subcommand_from describe" \
    -a "(oc get pods | cut -d' ' -f1)"
