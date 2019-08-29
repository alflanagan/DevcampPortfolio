'use strict'

import $ from 'jquery'
import {
  Skill
} from '../../app/javascript/packs/skills'

global.$ = global.jQuery = $

describe('static class Skills', () => {
  describe('static method triggerSkillEdit', () => {
    // sample of actual DOM, with a whole lot of irrelevant stuff removed
    const sampleDoc = `<div class="container" id="skills-edit-form">
        <div id="show_skill_1">
          <div class="skill-title" data-skill-id="1">Rails 0</div>
          <div class="skill-percent" data-skill-id="1">15</div>
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
          <div class="skill-percent" data-skill-id="2">5</div>
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

      const skillsForm = document.getElementById('skills-edit-form')
      expect(skillsForm).toBeDefined()
    })

    describe('when a click on skill title occurs', () => {
      test('it hides the skill row, and displays the form', () => {
        document.body.innerHTML = sampleDoc

        Skill.ready()

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

        Skill.ready()

        expect($('#show_skill_1').css('display')).toBe('block')
        expect($('#edit_skill_1').css('display')).toBe('none')

        $('#show_skill_1 .skill-percent').click()

        expect($('#show_skill_1').css('display')).toBe('none')
        expect($('#edit_skill_1').css('display')).toBe('block')
      })
    })

    describe('when a second click on another skill title occurs', () => {
      test('it is ignored', () => {
        document.body.innerHTML = sampleDoc

        Skill.ready()

        expect($('#show_skill_1').css('display')).toBe('block')
        expect($('#edit_skill_1').css('display')).toBe('none')
        expect($('#show_skill_2').css('display')).toBe('block')
        expect($('#edit_skill_2').css('display')).toBe('none')

        $('#show_skill_1 .skill-title').click()
        expect($('#show_skill_1').css('display')).toBe('none')
        expect($('#edit_skill_1').css('display')).toBe('block')
        expect($('#show_skill_2').css('display')).toBe('block')
        expect($('#edit_skill_2').css('display')).toBe('none')

        $('#show_skill_2 .skill-title').click()
        expect($('#show_skill_1').css('display')).toBe('none')
        expect($('#edit_skill_1').css('display')).toBe('block')
        expect($('#show_skill_2').css('display')).toBe('block')
        expect($('#edit_skill_2').css('display')).toBe('none')
      })
    })

    // this passes, but breaks test that run after it, since it 'breaks' the
    // Skill object. Should fix.
    xdescribe('when the skills form is not present', () => {
      test('nothing happens', () => {
        document.body.innerHTML = `<div class="container">
          <div id="show_skill_1">
            <div class="skill-title" data-skill-id="1">Rails 0</div>
            <div class="skill-percent" data-skill-id="1">15</div>
          </div>
        </div>`
        Skill.triggerSkillEdit = jest.fn()

        Skill.ready()
        $('.skill-title').click()
        expect(Skill.triggerSkillEdit).not.toBeCalled()

        document.body.innerHTML = `<div class="container" id="skills-edit-form">
          <div id="show_skill_1">
            <div class="skill-title" data-skill-id="1">Rails 0</div>
            <div class="skill-percent" data-skill-id="1">15</div>
          </div>
        </div>`
        Skill.ready()
        $('.skill-title').click()
        expect(Skill.triggerSkillEdit.mock.calls.length).toBe(1)
      })
    })

    describe('if the edit form is not present', () => {
      test('nothing happens', () => {
        document.body.innerHTML = `<div class="container" id="skills-edit-form">
          <div id="show_skill_1">
            <div class="skill-title" data-skill-id="1">Rails 0</div>
            <div class="skill-percent" data-skill-id="1">15</div>
          </div>
        </div>`

        Skill.ready()

        expect($('#show_skill_1').css('display')).toBe('block')

        $('#show_skill_1 .skill-percent').click()

        expect($('#show_skill_1').css('display')).toBe('block')
      })
    })
  })
})
