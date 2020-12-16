function fish_right_prompt
  set_color 555
  set -l duration "$CMD_DURATION$cmd_duration"
  echo -sn (humantime $CMD_DURATION)" "
  
  echo (date "+%H:%M:%S")
end
