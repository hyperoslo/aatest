#= require active_admin/base
#= require polymorphic_has_many
#= require refile
#
$ ->
  $('form').on 'change', 'select[parent]', ->
    container = $(this).closest('fieldset')
    model     = $(this).val()

    children = container.find("[child]")

    children.hide()
    children.find('select').attr 'disabled', true

    children = container.find("[child][model='#{model}']")

    children.show()
    children.find('select').attr 'disabled', false

  $('select[parent]').trigger 'change'
