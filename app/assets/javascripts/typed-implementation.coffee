
ready = ->
  new Typed('.element',
    strings: [
      'Welcome to my personal website.'
      "I hope you find something useful here, whether it's in my blog, "
      'or one of my programming projects.'
    ]
    typeSpeed: 0)
  return


$(document).ready ready
# must bypass turbolinks to set up listeners
$(document).on 'turbolinks:load', ready
