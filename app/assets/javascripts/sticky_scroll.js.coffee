$(window).scroll ->
  if $(window).scrollTop() > 50
    $('.dev-environment-alert-header').css 'top', $(window).scrollTop() - 50
  else
    $('.dev-environment-alert-header').css 'top', 0

  return
