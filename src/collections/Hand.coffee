class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @score = 0
    @calculateScore()

    # Timing issue
    setTimeout =>
      @calculateScore()
      return
    , 10
    return

  hit: ->
    @add(@deck.pop())
    @calculateScore();
    @last() #why is this returning last?

  dealerHit: ->
    while @score < 17 then @hit()
    @trigger 'dealerDone', @

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: ->
    min = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    # min
    @score = min
    min

  bust: ->
    @trigger 'bust', @
    return

  stand: ->
    @trigger 'stand', @

  calculateScore: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    score = [@minScore(), @minScore() + 10 * @hasAce()]
    @score = if score[1] > 21 then score[0] else score[1]
    @trigger "recalculated", @

    if @score > 21 then @bust()
    return