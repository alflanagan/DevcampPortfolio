'use strict'

import {
  Portfolio
} from '../../app/javascript/packs/portfolios'
import $ from 'jquery'

test('setPositions updates DOM elems with "card" class', () => {
  document.body.innerHTML = '<div><div class="card"><p>Some text.</p></div></div>'

  Portfolio.setPositions()

  expect($('.card').length).toBe(1)
  expect($('.card').each(function (index) {
    expect(this.getAttribute('data-pos')).toBe((index + 1).toString())
  }))
})
