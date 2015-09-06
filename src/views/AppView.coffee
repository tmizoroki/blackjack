class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <div class="status"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="status"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
      @model.get('playerHand').stand()
      @model.get('dealerHand').calculateScore()
      @model.get('dealerHand').dealerHit()
    'click .restart-button': ->
      @model.restart()
      @render()
      @$('.hit-button').show()
      @$('.stand-button').show()
      @$('.restart-button').hide()
      @message = '<h2>Let\'s Play Some Blackjack!</h2>'
      @gameover = false
      @initialize()
      @model.initialize(true)
      @render()


  initialize: ->
    @message = '<h2>Let\'s Play Some Blackjack!</h2>'
    @gameover = false

    @model.on 'youbust', =>
      @message = '<h2 class="lose">You busted!</h2>'
      @gameover = true
      @render()
    @model.on 'youwin', =>
      @message = '<h2 class="win">You won!</h2>'
      @gameover = true
      @render()
    @model.on 'dealerwin', =>
      @message = '<h2 class="lose">The Dealer Won!</h2>'
      @gameover = true
      @render()
    @model.on 'tie', =>
      @message = '<h2 class="tie">It\'s a tie!</h2>'
      @gameover = true
      @render()
    @model.on 'blackjack', =>
      @message = '<h2 class="win">You got Blackjack!</h2>'
      @gameover = true
      @render()
    @model.on 'blackjacktie', =>
      @message = '<h2 class="tie">It\'s a Blackjack tie!</h2>'
      @gameover = true
      @render()
    @model.on 'reshuffled', =>
      @message = '<h2 class="tie">Deck was reshuffled!</h2>'
      @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    if @gameover
      @$('.status').html @message + '<button class="restart-button">Play Again?</button>'
      @$('.hit-button').hide()
      @$('.stand-button').hide()
    else
      @$('.status').html @message
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    window.b = @$('.hit-button')

