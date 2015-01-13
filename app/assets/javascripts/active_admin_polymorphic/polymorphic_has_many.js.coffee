$ ->
  if $('.polymorphic_has_many_container').length
    form = $('#main_content').find('form:first')
    counter = 0
    $(form).on 'submit', (e) ->
      parentForm = @
      expect = $(@).find('form').length
      if counter < expect
        e.preventDefault()

      $(@).find('form').each ->
        remoteSubmit @, ->
          counter++
          if counter == expect
            $(form).find('form').remove()
            $(parentForm).submit()

  $('.polymorphic_has_many_fields').each (index, rapper) ->
    rapper = $ rapper

    hiddenField = rapper.find 'input[type=hidden][data-path]'
    formPath = hiddenField.data 'path'

    extractAndInsertForm formPath, rapper


  $(document).on 'click', 'a.button.polymorphic_has_many_remove', (e)->
    e.preventDefault()
    parent    = $(@).closest '.polymorphic_has_many_container'
    to_remove = $(@).closest 'fieldset'
    recompute_positions parent

    parent.trigger 'polymorphic_has_many_remove:before', [to_remove, parent]
    to_remove.remove()
    parent.trigger 'polymorphic_has_many_remove:after', [to_remove, parent]

  $(document).on 'click', 'a.button.polymorphic_has_many_add', (e)->
    e.preventDefault()
    parent = $(@).closest '.polymorphic_has_many_container'
    parent.trigger before_add = $.Event('polymorphic_has_many_add:before'), [parent]

    unless before_add.isDefaultPrevented()
      index = parent.data('polymorphic_has_many_index') || parent.children('fieldset').length - 1
      parent.data has_many_index: ++index

      regex = new RegExp $(@).data('placeholder'), 'g'
      html  = $(@).data('html').replace regex, index

      fieldset = $(html).insertBefore(@)
      recompute_positions parent
      parent.trigger 'polymorphic_has_many_add:after', [fieldset, parent]

  $('.polymorphic_has_many_container').on 'change', '.polymorphic_type_select', (event) ->
    fieldset = $(this).closest 'fieldset'

    selectedOption = $(this).find 'option:selected'
    formPath = selectedOption.data 'path'

    label = $(this).prev 'label'
    label.remove()

    hiddenField = $('<input type="hidden" />')
    hiddenField.attr 'name', $(this).attr('name')
    hiddenField.val $(this).val()

    $(this).replaceWith hiddenField

    newListItem = $ '<li>'

    extractAndInsertForm formPath, fieldset

recompute_positions = (parent)->
  parent     = if parent instanceof jQuery then parent else $(@)
  input_name = parent.data 'sortable'
  position   = parseInt(parent.data('sortable-start') || 0, 10)

  parent.children('fieldset').each ->
    # We ignore nested inputs, so when defining your has_many, be sure to keep
    # your sortable input at the root of the has_many block.
    destroy_input  = $(@).find "> ol > .input > :input[name$='[_destroy]']"
    sortable_input = $(@).find "> ol > .input > :input[name$='[#{input_name}]']"

    if sortable_input.length
      sortable_input.val if destroy_input.is ':checked' then '' else position++

strip_actions = (form) ->
  $(form).remove('.actions').html()
  console.log form
  form

window.extractAndInsertForm= (url, target)->
  target = $ target

  $.get url, (data)->
    elements = $(data)
    form = $('#main_content form', elements).first()
    $(form).find('.actions').remove()

    target.prepend form

window.remoteSubmit = (target, callback)->
  $(target).data('remote', true)
  $(target).attr('action', $(target).attr('action') + '.json') # we gonna burn in hell for that

  $(target).trigger('submit.rails')
    .on 'ajax:beforeSend', ()->
      console.log arguments
      debugger
    .on 'ajax:success', (event, object, status, response) ->
      if response.status == 201
        $(target).next().find('input:first').val(object.id)

      callback()
