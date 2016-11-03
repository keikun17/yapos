God.watch do |w|
  w.name = "nginx"
  w.start = "/opt/nginx/sbin/nginx"
  w.keepalive
end


God.watch do |w|
  w.name = "elasticserch"
  w.start = "service elasticsearch restart"
  w.keepalive
end

