/* global $ */

export class Pages {
  // keep track of row being edited
  static CURRENT_EDIT_ROW = -1 // -1 ==> no row edited

  static triggerSkillEdit (e) {
    const skillId = e.target.dataset['skillId']
    if (Pages.CURRENT_EDIT_ROW === -1) {
      Pages.CURRENT_EDIT_ROW = skillId
    } else {
      return // we're already editing a row!!
    }

    const rowElement = $(e.target.parentElement)

    rowElement.css({ display: 'none' })

    const editSkillId = `#edit_skill_${skillId}`
    $(editSkillId).css({ display: 'block' })
  }

  static submitSkillEdit () {

  }
}
