
class Portfolios {
  /*
   * Set the data-pos value of each card to its position in the array.
   */
  static function set_positions () {
    $('.card').each(
      function(i) {
        $(this).attr('data-pos', i + 1)
      }
    )
  }

  static function sort_update_cb  (that) {
    const updated_order = []
    that.set_positions()

  }

  static function ready () {
    this.set_positions()
    $('.sortable').sortable()
    $('.sortable').sortable().bind('sortupdate',
      function(e, ui) {
        var updated_order
        updated_order = []
        set_positions(); // update data to current positions
        $('.card').each(function(i) {
          updated_order.push({
            id: $(this).data('id'),
            position: i + 1
          })
        })
        console.log(updated_order);
      $.ajax({
        type: 'PUT',
        url: '/portfolios/sort',
        data: {
          order: updated_order
        }
      })
    })
  }
}

$(document).ready(Portfolios.ready);
