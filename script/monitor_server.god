God.watch do |w|
  w.name = "nginx"
  w.start = "/opt/nginx/sbin/nginx"
  w.keepalive
end


God.watch do |w|
  w.name = "elastic_search"
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "/var/run/elasticsearch.pid"
end
