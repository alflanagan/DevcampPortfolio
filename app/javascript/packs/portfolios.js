import Sortable from 'sortablejs'

export const Portfolio = {
  setPositions () {
    $('.card').each(function (i) {
      $(this).attr('data-pos', i + 1)
    })
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
    var container = document.getElementById('sortable')
    Sortable.create(container, {
      onUpdate: Portfolio._resortItems
    })
  }
}
