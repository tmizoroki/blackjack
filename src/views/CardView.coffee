class window.CardView extends Backbone.View
  className: 'card'
  tagname: 'img'

  template: _.template '<img src="img/cards/<%- revealed ? rankName + \'-\' + suitName : \'back\' %>.png">'


  initialize: ->
    @render()
    @model.on 'change:revealed', =>
      console.log "change revealed"
      # @render()
    , @


  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    console.log "render was called"
    @$el.removeClass 'covered'
    @$el.addClass 'covered' unless @model.get 'revealed'

