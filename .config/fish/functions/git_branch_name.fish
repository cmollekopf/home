function git_branch_name -d "Get current branch name"
  git_is_repo; and begin
    #command git symbolic-ref --short HEAD ^/dev/null;
    #  or command git show-ref --head -s --abbrev | head -n1 ^/dev/null
    command git symbolic-ref --short HEAD;
      or command git show-ref --head -s --abbrev | head -n1
  end
end
