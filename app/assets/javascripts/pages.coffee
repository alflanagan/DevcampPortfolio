# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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
