
export class Pages {
  // keep track of row being edited
  static CURRENT_EDIT_ROW = -1  // -1 ==> no row edited

  static trigger_skill_edit (e) {

    if (Pages.CURRENT_EDIT_ROW == -1) {
      Pages.CURRENT_EDIT_ROW = skillId
    } else {
      return // we're already editing a row!!
    }

    const skillId = e.target.dataset['skillId']
    const row_element = $(e.target.parentElement)

    row_element.css({display: 'none'})

    const edit_skill_id = `#edit_skill_${skillId}`
    $(edit_skill_id).css({display: 'block'})
  }

  static submit_skill_edit () {

  }
}
