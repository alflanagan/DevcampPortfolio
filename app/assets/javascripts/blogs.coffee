# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###
  On clicking the status button, change the visible text, and update the hidden
  input that actually stores the current state.
###
@toggle_status_button = () ->
  the_button = $(this)
  the_input = $('#blog_status')
  if the_button.text().trim() == 'Draft'
    the_button.text('Draft')
    the_input.attr('value', 'draft')
  else
    the_button.text('Published')
    the_input.attr('value', 'published')
