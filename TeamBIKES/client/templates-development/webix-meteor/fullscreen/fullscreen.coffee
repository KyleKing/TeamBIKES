Template.FullScreen.rendered = ->
  proxy = webix.proxy('meteor', Books)

  #datatable
  table =
    view: 'datatable'
    id: 'dtable'
    select: true
    multiselect: true
    editable: true
    editaction: 'dblclick'
    columns: [
      {
        id: 'name'
        editor: 'text'
        fillspace: 1
      }
      {
        id: 'author'
        editor: 'text'
        fillspace: 1
      }
    ]
    autoheight: true
    scrollX: false
    url: proxy
    save: proxy

  toolbar =
    view: 'toolbar'
    elements: [
      {
        view: 'label'
        label: 'Dbl-Click to edit any row'
      }
      {
        view: 'button'
        value: 'Add'
        width: 100
        click: ->
          row = $$('dtable').add(
            name: ''
            author: '')
          $$('dtable').editCell row, 'name'
          return
      }
      {
        view: 'button'
        value: 'Remove'
        width: 100
        click: ->
          id = $$('dtable').getSelectedId()
          if id
            $$('dtable').remove id
          else
            webix.message 'Please select any row first'
          return
      }
    ]

  templates = cols: [
    {
      header: 'Webix Data Binding (select row in table)'
      body:
        id: 't1'
        view: 'reactive'
        template: 'info'
    }
    {
      header: 'Meteor Data Binding'
      body:
        id: 't2'
        view: 'reactive'
        template: 'allinfo'
    }
    {
      header: 'Content with Scroll'
      body:
        id: 't3'
        view: 'reactive'
        template: 'longinfo'
    }
  ]
  @ui = webix.ui(
    type: 'wide'
    rows: [
      toolbar
      table
      templates
    ])
  # show data in template when row selected in the datatable
  $$('t1').bind $$('dtable')
  return

Template.FullScreen.destroyed = ->
  if @ui
    @ui.destructor()
  return

#configure auto-updates for allinfo template
Template.allinfo.helpers books: ->
  Books.find()

# ---
# generated by js2coffee 2.1.0