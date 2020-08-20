function fish_right_prompt
  set -l color_normal (set_color normal)
  set -l color_error (set_color $fish_color_error)
  set -l color "$color_normal"
  
  set -l duration "$CMD_DURATION$cmd_duration"
  echo -sn "$color"(echo "$duration" | humanize_duration)"$color_normal "
  
  set_color $fish_color_autosuggestion 2> /dev/null; or set_color 555
  date "+%H:%M:%S"
  set_color normal
end
