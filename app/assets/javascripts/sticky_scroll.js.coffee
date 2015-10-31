$(window).scroll ->
  navbar_height = document.getElementById('navbar').scrollHeight
  scroll_distance = $(window).scrollTop()
  sticky_element = document.getElementsByClassName('dev-environment-alert-header')[0]

  if scroll_distance > navbar_height
    sticky_element.style.top =  sticky_element.clientHeight + 'px'
  else
    sticky_element.style.top = (navbar_height - scroll_distance) + sticky_element.clientHeight + 'px'
  return
