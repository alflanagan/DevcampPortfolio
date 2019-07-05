ready = undefined
set_positions = undefined

set_positions = ->
  $('.card').each (i) ->
    $(this).attr 'data-pos', i + 1
    return
  return

ready = ->
  set_positions()
  $('.sortable').sortable()
  $('.sortable').sortable().bind 'sortupdate', (e, ui) ->
    updated_order = []
    set_positions() # update data to current positions
    $('.card').each (i) ->
      updated_order.push
        id: $(this).data('id')
        position: i + 1
      return
    console.log updated_order
    $.ajax
      type: 'PUT'
      url: '/portfolios/sort'
      data: order: updated_order
    return
  return

$(document).ready ready
