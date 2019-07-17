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
