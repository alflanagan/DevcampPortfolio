'use strict'

import $ from 'jquery'
import {
  Portfolio
} from '../../app/javascript/packs/portfolios'

global.$ = global.jQuery = $

test('setPositions updates 1 DOM element with "card" class', () => {
  document.body.innerHTML = '<div><div class="card"><p>Some text.</p></div></div>'

  Portfolio.setPositions()

  expect($('.card').length).toBe(1)
  expect($('.card').each(function (index) {
    expect(this.getAttribute('data-pos')).toBe((index + 1).toString())
  }))
})

test('setPositions updates multiple DOM elements with "card" class', () => {
  document.body.innerHTML = `<div>
  <div class="card">
  <p>Some text.</p>
  </div>
  <div class="card">
    <div class="card">
      <p>Here is some more text, in a nested card.</p>
    </div>
  </div>
  </div>`

  Portfolio.setPositions()

  expect($('.card').length).toBe(3)
  expect($('.card').each(function (index) {
    expect(this.getAttribute('data-pos')).toBe((index + 1).toString())
  }))
})

test('_resortItems creates a call to update sort order', () => {
  document.body.innerHTML = `
  <div class="row sortable">
        <div class="col-md-4">
  <div class="card mb-4 shadow-sm" data-id="1" data-pos="1">
    <div class="card-body">
      <img width="100%" src="https://loremflickr.com/350/200?random=&quot;1&quot;">
    </div>
    <div class="card-header">
      <h3><a href="/portfolio/1">Portfolio Title 0</a></h3>
      <p>Ruby on Rails</p>
    </div>
  </div>
</div>
<div class="col-md-4">
  <div class="card mb-4 shadow-sm" data-id="2" data-pos="3">
    <div class="card-body">
      <img width="100%" src="https://loremflickr.com/350/200?random=&quot;2&quot;">
    </div>
    <div class="card-header">
      <h3><a href="/portfolio/2">Portfolio Title 1</a></h3>
      <p>Ruby on Rails</p>
    </div>
  </div>
</div>
<div class="col-md-4">
  <div class="card mb-4 shadow-sm" data-id="5" data-pos="2">
    <div class="card-body">
      <img width="100%" src="https://loremflickr.com/350/200?random=&quot;3&quot;">
    </div>
    <div class="card-header">
      <h3><a href="/portfolio/5">Portfolio Title 4</a></h3>
      <p>Ruby on Rails</p>
    </div>
  </div>
</div>`

  $.ajax = jest.fn()

  Portfolio._resortItems()
  expect($.ajax.mock.calls.length).toBe(1)
  const expected = [
    // note ids 2 and 5 have correct positions
    { id: '1', position: 1 },
    { id: '2', position: 2 },
    { id: '5', position: 3 }
  ]
  expect($.ajax.mock.calls[0][0]['data']['order']).toEqual(expected)
})
