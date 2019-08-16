/* global $ */

export const Portfolio = {
  setPositions () {
    $('.card').each(i => $(this).attr('data-pos', i + 1))
  },

  _resortItems (e, ui) {
    const updatedOrder = []
    Portfolio.setPositions() /* update data to current positions */
    $('.card').each((i, element) => {
      const newData = {
        id: element.dataset.id,
        position: i + 1
      }
      updatedOrder.push(newData)
    })
    $.ajax({
      type: 'PUT',
      url: '/portfolios/sort',
      data: {
        order: updatedOrder
      }
    })
  },

  ready () {
    Portfolio.setPositions()
    $('.sortable').sortable()
    $('.sortable').sortable().bind('sortupdate', {}, Portfolio._resortItems)
  }
}

$(document).on('turbolinks:load', Portfolio.ready)
