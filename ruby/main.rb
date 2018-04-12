require './pomodoro.rb'

def menu
  p "POMODORO terminal timer by qmau"
  p "1. Load task file"
  p "2. Start pomodoro"
  p "3. Export mail report"
  p "4. Exit"
  choice = gets.chomp.to_i
  choice
end

case menu
when 1

when 2
  p "New task"
else
  exit
end



pomodoro = Pomodoro.new "task"
pomodoro.work
pomodoro.short_break
pomodoro.end
pomodoro.report
