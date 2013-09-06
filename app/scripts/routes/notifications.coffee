class app.Routers.Notifications extends Backbone.Router
  routes:
    'unread': 'index'
    'participating': 'participating'
    'all': 'all'
    'r/:id': 'repository'
    'n/:id': 'show'

  initialize: (options)->
    @repositories = options.repositories

    @on 'route', @selectItem

    @collection = new app.Collections.Notifications()
    @view = new app.Views.Notifications(collection: @collection)
    @view.render()

  index: ->
    @collection.fetch reset: true

  participating: ->
    @collection.fetch reset: true, data: {participating: true, all: false}

  all: ->
    @collection.fetch reset: true, data: {all: true}

  show: (id) ->
    model = @collection.get(id)
    return unless model
    new app.Views.NotificationDetailsView(model: model)

  repository: (id) ->
    model = @repositories.get(id)
    return unless model
    @collection.fetch reset: true, url: model.notifications_url()

  # FIXME: total hack, but can't think of a better way to do it
  selectItem: ->
    $('#lists').find('.selected').removeClass('selected')
    $('#lists').find("a[href='#{window.location.hash}']").addClass('selected')
