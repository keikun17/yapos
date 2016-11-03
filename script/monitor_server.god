God.watch do |w|
  w.name = "nginx"
  w.start = "/opt/nginx/sbin/nginx"
  w.keepalive
end


God.watch do |w|
  w.name = "elastic_search"
  w.interval = 30.seconds
  w.start = "service elasticsearch start"
  w.stop = "service elasticsearch stop"
  w.restart = "service elasticsearch restart"
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "/var/run/elasticsearch.pid"

  # Cleanup the pid file (this is needed for processes running as a daemon).
  w.behavior(:clean_pid_file)

  # Conditions under which to start the process
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end

    start.condition(:process_exits)
  end
  
  # Conditions under which to restart the process
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 2000.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
      c.notify = 'me'
    end
  
    restart.condition(:cpu_usage) do |c|
      c.above = 90.percent
      c.times = 5
      c.notify = 'me'
    end
    restart.condition(:elasticsearch_stats) do |c|
      c.status = [:yellow, :green]
      c.notify = 'me'
    end
  end
  
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
      c.notify = 'me'
    end
  end
end
