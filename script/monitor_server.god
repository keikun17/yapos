God.watch do |w|
  w.name = "nginx"
  w.start = "/usr/sbin/nginx"
  w.pid_file = "/var/run/nginx.pid"
  w.log = "/var/log/god-nginx.log"
  w.keepalive
end


God.watch do |w|
  w.name = "elasticsearch"
  w.start = "service elasticsearch start"
  w.pid_file = "/var/run/elasticsearch/elasticsearch.pid"
  w.log = "/var/log/god-elasticsearch.log"
  w.keepalive
end
