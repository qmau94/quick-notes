class Pomodoro
  def initialize task
    @task_list = task
    @work = 0
    @start_time = Time.now
    @end_time = Time.now
  end

  def work
    p "Let's work on #{@task}"
    sleep 2
    @work += 1
  end
  
  def short_break
    p "Take a 5min short break"
    sleep 1
  end

  def long_break
    p "Take a 15min long break"
    sleep 1
  end
  
  def end
    @end_time = Time.now 
  end
  
  def report
    p "#{@task} worked on #{@work} session. From #{@start_time} to #{@end_time}"
  end
end

