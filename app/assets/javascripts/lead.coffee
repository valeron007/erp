$ ->
  $(".btn-file-del").on "click", ->
    $(this).next().val(1)
    $(this).parent().parent().hide()
