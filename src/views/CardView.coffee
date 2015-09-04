class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @render()
    @model.on 'change:revealed', =>
      console.log "change revealed"
      @render()
    , @


  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    console.log "render was called"
    @$el.removeClass 'covered'
    @$el.addClass 'covered' unless @model.get 'revealed'

