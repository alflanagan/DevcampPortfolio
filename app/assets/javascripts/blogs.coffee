# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###
  Render a markdown string to HTML, and append to the DOM.

  @param {string} raw_md The markdown text to be rendered.
  @param {string} target_selector The CSS selector of the desired parent element.
###
@render_md = (raw_md, target_selector) ->
  rendered = $(window.markdownit().render(raw_md))
  body_elem = $(target_selector)
  body_elem.append(rendered)

###
  On clicking the status button, change the visible text, and update the hidden
  input that actually stores the current state.
###
@toggle_status_button = () ->
  the_button = $(this)
  the_input = $('#blog_status')
  if the_button.text().trim() == 'Publish'
    the_button.text('Draft')
    the_input.attr('value', 'draft')
  else
    the_button.text('Publish')
    the_input.attr('value', 'publish')

@on_save_document  = (e) ->
  console.log('saving')
  # put contents of editor back where rails can find it
  editor = window.ace_editor
  $('#blog_body').text(editor.getValue())

@setup_editor = () ->
  title_in = $('#blog_title')
  title_pre = $('#preview-title')
  body_pre = $('#preview-body')
  title_in.on('input', () ->
    new_val = title_in.val()
    if (new_val == '')
      title_pre.text('')
      title_pre.append($('<span style="font-style: italic; color: lightgrey;">Entry Title</span>'))
    else
      title_pre.text(new_val)
  )

  editor = ace.edit("ace-editor-anchor")
  md = window.markdownit()

  editor.setTheme("ace/theme/github")
  editor.session.setMode("ace/mode/markdown")
  window.ace_editor = editor
  doc = editor.session.getDocument()
  doc.on('change', () ->
    result = $(md.render(doc.getValue()))
    body_pre.children().detach()
    body_pre.append(result)
  )
