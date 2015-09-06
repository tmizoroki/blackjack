class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: ->
    if @length < 10
      console.log "Deck is less than 10 " + @length
      @trigger "reshuffled", @
      @initialize()
    new Hand [@pop(), @pop()], @, false

  dealDealer: ->
    if @length < 10
      console.log "Deck is less than 10 " + @length
      @trigger "reshuffled", @
      @initialize()
    new Hand [@pop().flip(), @pop()], @, true

