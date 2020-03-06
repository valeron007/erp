$(document).ready ->
  documentType              = $("#document_document_type")
  documentContent           = $(".document_content")
  jsSpreadSheet             = $("#js-spreadsheet")
  documentSheetContent      = $(".document_sheet_content")
  documentSheetContentInput = $("#sheet_content")
  documentForm              = $("#document-form")

  isEditable = ->
    Boolean(window.location.href.match(/new/) || window.location.href.match(/edit/))

  switchContentInput = (type) ->
    if isEditable()
      switch type
        when "text"
          jsSpreadSheet.hide()
          documentContent.show()
        when "sheet"
          documentContent.hide()
          jsSpreadSheet.show()
        else
          documentContent.hide()
          jsSpreadSheet.hide()

  initSocialCalc = ->
    $('#js-spreadsheet').socialcalc
      form: '#document-form'
      content: '#sheet_content'
      width: 700

  switchContentInput documentType.val()

  documentType.on "change", (e) ->
    switchContentInput e.target.value

  unless Boolean(window.location.href.match(/edit/)) && documentType.val() == "text"
    initSocialCalc()



