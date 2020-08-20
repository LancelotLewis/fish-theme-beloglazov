# name: beloglazov

function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function _git_ahead_count -a branch_name
  echo (command git log origin/$branch_name..HEAD 2> /dev/null | \
    grep '^commit' | wc -l | tr -d ' ')
end

function fish_prompt
  set -l last_status $status

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l green (set_color green)
  set -l red (set_color red)
  set -l brightred (set_color -o red)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)

  if test $last_status = 0
      set arrow "$green➜ "
  else
      set arrow "$red➜ "
  end

  set -l cwd $cyan(basename (prompt_pwd))$normal

  if [ (_git_branch_name) ]
    set -l git_branch_name (_git_branch_name)
    set -l git_branch $brightred$git_branch_name$normal
    set git_info "$blue ($git_branch$blue)$normal"
    set -l git_ahead_count (_git_ahead_count $git_branch_name)

    if [ $git_ahead_count != 0 ]
      set -l ahead_count "$green+$git_ahead_count$normal"
      set git_info "$git_info $ahead_count"
    end

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗$normal"
      set git_info "$git_info$dirty"
    end
  end

  echo -n -s $arrow ' ' $cwd $git_info $normal ' '

end
