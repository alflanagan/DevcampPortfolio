# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

FONT_SELECTIONS = [
  "'Merriweather', serif",
  "'Roboto Slab', serif",
  "'Vidaloka', serif",
  "'Cantata One', serif",
  "'Yatra One', cursive;"
]

CURRENT_EDIT_ROW = -1

@toggle_current_font = () ->
  if typeof window.__current_font == 'undefined'
    window.__current_font = 3
  window.__current_font += 1
  if (window.__current_font >= FONT_SELECTIONS.length)
    window.__current_font = 0
  $('h1').attr('style', 'font-family: ' + FONT_SELECTIONS[window.__current_font] + ';')
  $('p').attr('style', 'font-family: ' + FONT_SELECTIONS[window.__current_font] + ';')
  $('#font-name-display').text(FONT_SELECTIONS[window.__current_font])

@trigger_skill_edit = (e) ->
  skillId = e.target.dataset['skillId']
  console.log("Would edit #{skillId} record")
  if CURRENT_EDIT_ROW == -1
    CURRENT_EDIT_ROW = skillId
  else
    return
  $(e.target.parentElement).css(display: 'none')
  edit_skill_id = "#edit_skill_#{e.target.dataset['skillId']}"
  $(edit_skill_id).css(display: 'block')
