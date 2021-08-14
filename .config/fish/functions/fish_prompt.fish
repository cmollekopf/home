# You can override some default options with config.fish:
#
#  set -g theme_short_path yes

function prompt_segment -d "Function to show a segment"
  # Get colors
  set -l bg $argv[1]
  set -l fg $argv[2]

  # Set 'em
  set_color -b $bg
  set_color $fg

  # Print text
  if [ -n "$argv[3]" ]
    echo -n -s $argv[3]
  end
end

function show_status -d "Function to show the current status"
  if [ -n "$SSH_CLIENT" ]
    prompt_segment blue white ""
    set pad ""
  end
end

function fish_prompt
  set -l last_command_status $status
  set -l cwd

  if test "$theme_short_path" = 'yes'
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  set -l fish     "⋊>"
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄ "
  set -l dirty    "⨯"
  set -l none     "◦"

  set -l normal_color     (set_color normal)
  set -l success_color    (set_color cyan)
  set -l error_color      (set_color red --bold)
  set -l directory_color  (set_color brown)
  set -l repository_color (set_color green)
  #set -l success_color    (set_color $fish_pager_color_progress ^/dev/null; or set_color cyan)
  #set -l error_color      (set_color $fish_color_error ^/dev/null; or set_color red --bold)
  #set -l directory_color  (set_color $fish_color_quote ^/dev/null; or set_color brown)
  #set -l repository_color (set_color $fish_color_cwd ^/dev/null; or set_color green)

  show_status $last_command_status
  if test $last_command_status -eq 0
    echo -n -s $success_color $fish $normal_color
  else
    echo -n -s $error_color $fish $normal_color
  end

  if test "$PWD" != "$HOME"
    if git_is_repo
      if test "$theme_short_path" = 'yes'
        set root_folder (command git rev-parse --show-toplevel)
        #set root_folder (command git rev-parse --show-toplevel ^/dev/null)
        set parent_root_folder (dirname $root_folder)
        set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")

        echo -n -s " " $directory_color $cwd $normal_color
      else
        echo -n -s " " $directory_color $cwd $normal_color
      end

      echo -n -s " on " $repository_color (git_branch_name) $normal_color " "

    #   if git_is_touched
    #     echo -n -s $dirty
    #   else
    #     echo -n -s (git_ahead $ahead $behind $diverged $none)
    #   end
    else
      echo -n -s " " $directory_color $cwd $normal_color
    end
  end

  echo -n -s " "
end
