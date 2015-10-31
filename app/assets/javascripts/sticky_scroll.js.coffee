$(window).scroll ->
  navbar_height = document.getElementById('navbar').scrollHeight
  if $(window).scrollTop() > navbar_height
    $('.dev-environment-alert-header').css 'top', $(window).scrollTop() - navbar_height
  else
    $('.dev-environment-alert-header').css 'top', 0
  return
