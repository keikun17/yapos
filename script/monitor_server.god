God.watch do |w|
  w.name = "nginx"
  w.start = "/opt/nginx/sbin/nginx"
  w.pid_file = "/opt/nginx/logs/nginx.pid"
  w.keepalive
end


God.watch do |w|
  w.name = "elasticsearch"
  w.start = "service elasticsearch start"
  w.pid_file = "/var/run/elasticsearch.pid"
  w.keepalive
end
