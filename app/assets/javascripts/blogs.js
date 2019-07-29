// All this logic will automatically be available in application.js.

class Blogs {

  /*
    Render a markdown string to HTML, and append to the DOM.

    @param {string} raw_md The markdown text to be rendered.
    @param {string} target_selector The CSS selector of the desired parent element.
  */
  static function render_md (raw_md, target_selector) {
    const rendered = $(window.markdownit().render(raw_md))
    let body_elem = $(target_selector)
    return body_elem.append(rendered)
  }

  /*
    On clicking the status button, change the visible text, and update the hidden
    input that actually stores the current state.
  */
  static function toggle_status_button () {
    const the_button = $(this)
    const the_input = $('#blog_status')
    if (the_button.text().trim() === 'Publish') {
      the_button.text('Draft')
      the_input.attr('value', 'draft')
    } else {
      the_button.text('Publish')
      the_input.attr('value', 'publish')
    }
  }

  /*
    Get markdown text from the editor, save it as the text of #blog_body element.
  */
  static function on_save_document (e) {
    console.log('saving')
    // put contents of editor back where rails can find it
    const editor = window.ace_editor
    $('#blog_body').text(editor.getValue())
  }

  /*
    Set up editor title preview, either with a value or a pseudo-placeholder.
  */

  static function _editor_title () {
    const title_in = $('#blog_title')
    const title_pre = $('#preview-title')

    title_in.on('input', () => {
      const new_val = title_in.val()
      if (new_val === '') {
        title_pre.text('')
        title_pre.append($('<span style="font-style: italic; color: lightgrey;">Entry Title</span>'))
      } else {
        title_pre.text(new_val)
      }
    })
  }

  static function _add_change_callback () {
    const doc = window.ace_editor
    const body_pre = $('#blog_body')
    md = window.markdownit()
    doc.on('change', () => {
      const result = $(md.render(doc.getValue()))
      body_pre.children().detach()
      body_pre.append(result)
    })
  }

  /*
    Sets up editor. Note: uses `this` to refer to the class, so be careful if using in a callback.
  */
  static function setup_editor () {
    this._editor_title()

    editor = ace.edit("ace-editor-anchor")
    editor.setTheme("ace/theme/github")
    editor.session.setMode("ace/mode/markdown")
    window.ace_editor = editor

    this._add_change_callback()
  }
}
