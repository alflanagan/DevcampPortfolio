/* global $ */

export class Pages {
  // keep track of row being edited
  static CURRENT_EDIT_ROW = -1 // -1 ==> no row edited

  /**
   * Hide the div to show the skill, and display the one to edit it.
   * @param {Event} e Event with target which is a child of the "show" div.
   */
  static triggerSkillEdit (e) {
    const skillId = e.target.dataset['skillId']
    if (Pages.CURRENT_EDIT_ROW === -1) {
      Pages.CURRENT_EDIT_ROW = skillId
    } else {
      return // we're already editing a row!!
    }

    const rowElement = $(e.target.parentElement)

    const editSkillId = `#edit_skill_${skillId}`
    // don't hide 'show' div if 'edit' div not present
    if ($(editSkillId).length > 0) {
      rowElement.css({ display: 'none' })
      $(editSkillId).css({ display: 'block' })
    }
  }

  /**
   * Establish click handlers on appropriate classes, if the skills
   * form is on the page.
   */
  static ready () {
    Pages.CURRENT_EDIT_ROW = -1
    const skillsForm = document.getElementById('skills-edit-form')
    if (skillsForm !== null) {
      $('.skill-title').click(Pages.triggerSkillEdit)
      $('.skill-percent').click(Pages.triggerSkillEdit)
    }
  }
}
