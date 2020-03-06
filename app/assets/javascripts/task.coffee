$ ->
  $.rails.allowAction = (link) ->
    return true unless link.attr('data-confirm')
    $.rails.showConfirmDialog(link) # look bellow for implementations
    false # always stops the action since code runs asynchronously

  $.rails.confirmed = (link) ->
    link.removeAttr('data-confirm')
    link.trigger('click.rails')
  $.rails.showConfirmDialog = (link) ->
    modal_title = link.attr 'data-title'
    modal_text = link.attr 'data-text'
    modal_title = link.attr 'title' unless modal_title
    modal_text = link.attr 'data-confirm' unless modal_text
    html = """
           <div class="modal" id="confirmationDialog">
           <div class="modal-dialog">
           <div class="modal-content">
             <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">×</span></button>
               <h4 class="modal-title">#{modal_title}</h4>
             </div>
             <div class="modal-body">
               <p>#{modal_text}</p>
             </div>
             <div class="modal-footer">
               <button type="button" class="btn btn-link" data-dismiss="modal">Cancel</a>
               <button type="button" class="btn btn-primary confirm">OK</button>
             </div>
           </div>
           </div>
           </div>
           """
    $(html).modal()
    $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)

  ShowHideDate = () ->
    if $('#task_regularly').prop('checked')
      $('.finish_date_wrapper').hide()
    else
      $('.finish_date_wrapper').show()


  $('input[name="task[regularly]"]').on 'click', (e) ->
    ShowHideDate()
  ShowHideDate()

  $('.history-table-title').on 'click', (e) ->
    e.preventDefault()
    $(this).next(".history-table-changes").toggle()