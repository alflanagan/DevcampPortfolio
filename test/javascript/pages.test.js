'use strict'

import $ from 'jquery'
import {
  Pages
} from '../../app/javascript/packs/pages'

global.$ = global.jQuery = $

describe('static class Pages', () => {
  describe('static method triggerSkillEdit', () => {
    // sample of actual DOM, with a whole lot of irrelevant stuff removed
    const sampleDoc = `<div class="container" id="skills-edit-form">
        <div id="show_skill_1">
          <div class="skill-title" data-skill-id="1">Rails 0</div>
          <div class="skill-percent">15</div>
        </div>
        <div class="edit" style="display: none;" id="edit_skill_1">
          <form class="edit_skill"
                id="edit_skill_1"
                action="/skills/1"
                accept-charset="UTF-8"
                method="post">
            <input class="skill-title-edit" name="skill[title]" id="skill-title-edit-1" value="Rails 0" type="text">
            <input step="5" name="skill[percent_used]" id="skill-percent-edit-1" class="skill-percent-edit" value="15" min="5" max="100" type="number">
            <input type="submit" name="commit" value="+" data-disable-with="+">
          </form>
        </div>
        <div id="show_skill_2">
          <div class="skill-title" data-skill-id="2">Rails 1</div>
          <div class="skill-percent">5</div>
        </div>
        <div class="edit" style="display: none;" id="edit_skill_2">
          <form class="edit_skill" id="edit_skill_2" action="/skills/2"
                accept-charset="UTF-8" method="post">
            <input class="skill-title-edit" name="skill[title]" id="skill-title-edit-2"
                  value="Rails 1" type="text">
            <input step="5" name="skill[percent_used]" id="skill-percent-edit-2"
                  class="skill-percent-edit" value="5" min="5" max="100"
                  type="number">
            <input type="submit" name="commit" value="+" data-disable-with="+">
          </form>
        </div>`

    test('relies on certain data being present in the event object', () => {
      // so trigger actual event and make sure data is as we expect.
      document.body.innerHTML = sampleDoc
      const mockHandler = jest.fn()

      $('#show_skill_1>div').on('click', mockHandler)

      $('#show_skill_1 .skill-title').click()

      expect(mockHandler.mock.calls.length).toBe(1)
      const firstEvent = mockHandler.mock.calls[0][0]
      expect(firstEvent.target.dataset['skillId']).toBe('1')
      expect(firstEvent.target.parentElement.id).toBe('show_skill_1')

      $('#show_skill_1 .skill-percent').click()

      expect(mockHandler.mock.calls.length).toBe(2)
      const secondEvent = mockHandler.mock.calls[1][0]
      expect(secondEvent.target.dataset['skillId']).toBe('1')
      expect(secondEvent.target.parentElement.id).toBe('show_skill_1')
    })

    describe('when a click on skill title occurs', () => {
      test('it hides the skill row, and displays the form', () => {
        document.body.innerHTML = sampleDoc

        $('#show_skill_1>div').on('click', Pages.triggerSkillEdit)

        expect($('#show_skill_1').css('display')).toBe('block')
        expect($('#edit_skill_1').css('display')).toBe('none')

        $('#show_skill_1 .skill-title').click()

        expect($('#show_skill_1').css('display')).toBe('none')
        expect($('#edit_skill_1').css('display')).toBe('block')
      })
    })

    describe('when a click on the skill percentage occurs', () => {
      test('it hides the skill row, and displays the form', () => {
        document.body.innerHTML = sampleDoc

        $('#show_skill_1>div').on('click', Pages.triggerSkillEdit)

        expect($('#show_skill_1').css('display')).toBe('block')
        expect($('#edit_skill_1').css('display')).toBe('none')

        $('#show_skill_1 .skill-percent').click()

        expect($('#show_skill_1').css('display')).toBe('none')
        expect($('#edit_skill_1').css('display')).toBe('block')
      })
    })
  })
})
