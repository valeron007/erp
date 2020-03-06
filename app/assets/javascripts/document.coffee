$ ->
  $(".diff_link").on "click", ->
    that = $(this)
    out = $('.diffoutput-'+that.data('version-id'))
    if out.is(':empty')
      base = difflib.stringAsLines(that.find('.diff_content_from').text())
      newtxt = difflib.stringAsLines(that.find('.diff_content_to').text())
      sm = new difflib.SequenceMatcher(base, newtxt)
      out.empty().append diffview.buildView(
        baseTextLines: base
        newTextLines: newtxt
        opcodes: sm.get_opcodes()
        baseTextName: that.data('label-old')
        newTextName: that.data('label-new')
        contextSize: 5
        viewType: 0)
    else
      out.empty()
    false